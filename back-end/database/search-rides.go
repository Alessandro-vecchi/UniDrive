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
	// date_time := date + " " + strconv.Itoa(at_h) + ":" +strconv.Itoa(at_min) // 2006-01-02 15:30

	// Query with case-insensitive matching date_time = ?
	result := db.Where("LOWER(origin) = ? AND LOWER(destination) = ? AND depart_hour = ? AND depart_mins = ?", from, to, at_h, at_min).Find(&rides)
	if result.Error != nil {
		return nil, result.Error
	}
	return rides, nil
}
