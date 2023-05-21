package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func SearchRides(db *gorm.DB, from string, to string, date_time string) ([]models.Ride, error) {
	var rides []models.Ride

	// Query with case-insensitive matching date_time = ?
	result := db.Where("LOWER(origin) = ? AND LOWER(destination) = ? AND depart_date_time = ?", from, to, date_time).Find(&rides)
	if result.Error != nil {
		return nil, result.Error
	}
	return rides, nil
}
