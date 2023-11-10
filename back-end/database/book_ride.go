package database

import (
	"UniDrive/back-end/api/models"
	"errors"
	"fmt"
	"time"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
)

type Temp struct {
	AvailableSeats int `json:"available_seats"`
}

func BookRide(db *gorm.DB, user_id string, ride_id string) (models.Booking, error) {

	// Check if the user has already booked this ride
	var temp Temp
	err := db.Debug().
		Table("ride").
		Select("(SELECT car_details.tot_seats - 1 - COUNT(*) FROM booking WHERE ride_id = ?) as available_seats", ride_id).
		Joins("JOIN car_details ON car_details.user_id = ride.driver_id").
		Where("ride.id = ?", ride_id).
		Scan(&temp).Error

	if err != nil {
		return models.Booking{}, err
	}
	if temp.AvailableSeats <= 0 {
		return models.Booking{}, errors.New("no seats available")
	}
	fmt.Print(temp.AvailableSeats)
	// Create id for the booking
	var booking models.Booking
	raw_booking_id, err := uuid.NewV4()
	if err != nil {
		return booking, err
	}
	booking_id := raw_booking_id.String()

	timestamp := time.Now().Format(time.RFC3339)

	tx := db.Begin()

	// Add booking to the database
	result := tx.Exec("INSERT INTO booking(id, ride_id, booking_timestamp, passenger_id) values (?,?,?,?) ", booking_id, ride_id, timestamp, user_id)
	if result.Error != nil {
		tx.Rollback()
		return booking, result.Error
	}

	// Get car details
	var carDetails models.CarDetails

	result = db.Raw("SELECT * FROM car_details WHERE user_id = (SELECT driver_id FROM ride WHERE id = ?)", ride_id).Find(&carDetails)
	if result.Error != nil {
		return booking, errors.New("could not find car details")
	}

	// Update available seats from the ride
	/* result = tx.Exec("UPDATE ride SET available_seats = available_seats - 1   WHERE id = ? and available_seats <> 0", ride_id)
	if result.Error != nil {
		tx.Rollback()
		return booking, result.Error
	}
	if result.RowsAffected == 0 {
		tx.Rollback()
		return booking, errors.New("no more seats available")
	} */

	booking.BookingId = booking_id
	booking.RideId = ride_id
	booking.BookingTimestamp = timestamp
	booking.CarDetails = carDetails
	tx.Commit()

	return booking, nil
}
