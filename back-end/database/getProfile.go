package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func GetProfile(db *gorm.DB, userId int) (models.Profile, error) {
	return models.Profile{}, nil
}
