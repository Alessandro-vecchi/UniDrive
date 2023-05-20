package database

import (
	"UniDrive/back-end/api/models"
	"github.com/jinzhu/gorm"
)

func SearchRides(db *gorm.DB, from string, to string, at string) ([]models.Ride, error) {
	var rides []models.Ride
	result := db.Where("origin = ? AND destination = ? AND depart_hour = ?", from, to, at).Find(&rides)
	if result.Error != nil {
		return nil, result.Error
	}
	return rides, nil
}
