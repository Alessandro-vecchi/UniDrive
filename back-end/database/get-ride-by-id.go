package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
	"fmt"
)

func GetRideByID(db *gorm.DB, id string) (models.Ride, error) {
	var ride models.Ride
	result := db.Raw("SELECT * FROM ride WHERE id = ?", id).Scan(&ride)
	if result.Error != nil {
		return ride, result.Error
	}
	var fra string
	result = db.Raw("SELECT origin FROM ride WHERE id = ?", id).Scan(&fra)
	if result.Error != nil {
		return ride, result.Error
	}
	fmt.Println(fra)
	return ride, nil
}
