package database

import (
	"UniDrive/back-end/api/models"
	"time"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
)

func BookRide(db *gorm.DB, user_id string, ride_id string) (models.Booking, error) {
	var booking models.Booking
	rawUuid, err := uuid.NewV4()
	if err != nil {
		return booking, err
	}
	uuid := rawUuid.String()

	timestamp := time.Now().Format(time.RFC3339)

	tx := db.Begin()

	result := tx.Exec("INSERT INTO booking(id, ride_id, booking_timestamp, passenger_id) values (?,?,?,?) ", uuid, ride_id, timestamp, user_id)
	if result.Error != nil {
		tx.Rollback()
		return booking, result.Error
	}

	var carDetails models.CarDetails

	result = db.Raw("SELECT * FROM car_details WHERE user_id = (SELECT driver_id FROM ride WHERE id = ?)", ride_id).Find(&carDetails)
	if result.Error != nil {
		return booking, result.Error
	}

	result = tx.Exec("UPDATE ride SET available_seats = available_seats - 1   WHERE id = ?", ride_id)
	if result.Error != nil {
		tx.Rollback()
		return booking, result.Error
	}

	booking.RideId = ride_id
	booking.BookingTimestamp = timestamp
	booking.CarDetails = carDetails
	tx.Commit()

	return booking, nil
}
