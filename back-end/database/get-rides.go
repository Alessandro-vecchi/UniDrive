package database

import (
	"UniDrive/back-end/api/models"
	"strings"

	"github.com/jinzhu/gorm"
)

func SearchRides(db *gorm.DB, from string, to string, at_h int, at_min int) ([]models.Ride, error) {
	var rides []models.Ride

	// Convert the search parameters to lowercase
	from = strings.ToLower(from)
	to = strings.ToLower(to)

	// Query with case-insensitive matching
	result := db.Where("LOWER(origin) = ? AND LOWER(destination) = ? AND depart_hour = ? AND depart_mins = ?", from, to, at_h, at_min).Find(&rides)
	if result.Error != nil {
		return nil, result.Error
	}
	return rides, nil
}
