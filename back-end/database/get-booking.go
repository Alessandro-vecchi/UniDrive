package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func GetBookedRide(db *gorm.DB, user_id string, ride_id string) (models.Booking, error) {
	var booking models.Booking
	result := db.Raw("SELECT * FROM booking WHERE ride_id = ? AND passenger_id = ?", ride_id, user_id).Scan(&booking)

	if result.Error != nil {
		return models.Booking{}, result.Error
	}

	return booking, nil
}
