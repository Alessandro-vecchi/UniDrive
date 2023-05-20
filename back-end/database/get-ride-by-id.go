package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func GetRideByID(db *gorm.DB, id string) (*models.Ride, error) {
	var ride models.Ride
	result := db.Where("id = ?", id).First(&ride)
	if result.Error != nil {
		return nil, result.Error
	}
	return &ride, nil
}
