package database

import (
	"UniDrive/back-end/api/models"
	"fmt"

	"github.com/jinzhu/gorm"
	
)

// da modifica
func GetReviews(db *gorm.DB, id string) (models.Ride, error) {
	var ride models.Ride
	result := db.Raw("SELECT * FROM ride WHERE id = ?", id).Scan(&ride)
	fmt.Println(ride)
	if result.Error != nil {
		return models.Ride{}, result.Error
	}

	
	return ride, nil
}