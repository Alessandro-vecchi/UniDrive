package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func GetProfileByID(db *gorm.DB, id string) (*models.Profile_DB, error) {
	var profile models.Profile_DB
	result := db.Where("id = ?", id).First(&profile)
	if result.Error != nil {
		return nil, result.Error
	}
	return &profile, nil
}
