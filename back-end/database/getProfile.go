package database

import (
	"github.com/jinzhu/gorm"
	"UniDrive/back-end/api/models"
)

func GetProfile(db *gorm.DB, userId int) (models.Profile, error) {
	
}