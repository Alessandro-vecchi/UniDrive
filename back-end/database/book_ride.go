package database

import (
	"UniDrive/back-end/api/models"
	"errors"
	"time"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
)

func BookRide(db *gorm.DB, user_id string, ride_id string) (models.Booking, error) {

	// check if ride exists and has available seats
	ride, err := GetRideByID(db, ride_id)
	if err != nil {
		return models.Booking{}, err
	}

	// Check if there are available seats before booking
	if ride.AvailableSeats <= 0 {
		return models.Booking{}, errors.New("no seats available")
	}

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
	result = tx.Exec("UPDATE ride SET available_seats = available_seats - 1   WHERE id = ? and available_seats <> 0", ride_id)
	if result.Error != nil {
		tx.Rollback()
		return booking, result.Error
	}
	if result.RowsAffected == 0 {
		tx.Rollback()
		return booking, errors.New("no more seats available")
	}

	booking.RideId = ride_id
	booking.BookingTimestamp = timestamp
	booking.CarDetails = carDetails
	tx.Commit()

	return booking, nil
}
