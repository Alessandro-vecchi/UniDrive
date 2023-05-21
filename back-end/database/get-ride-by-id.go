package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func GetRideByID(db *gorm.DB, id string) (models.Ride, error) {
	var ride models.Ride
	result := db.Raw("SELECT * FROM ride WHERE id = ?", id).Scan(&ride)
	if result.Error != nil {
		return ride, result.Error
	}
	return ride, nil
}
