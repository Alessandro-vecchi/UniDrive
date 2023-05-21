package database

import (
	"UniDrive/back-end/api/models"
	"log"
	"strconv"
	"time"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
)

func CreateProfile(db *gorm.DB, profile *models.Profile_DB) error {
	// creating user id
	rawUserId, err := uuid.NewV4()
	if err != nil {
		log.Fatalf("failed to get UUID: %v", err)
	}

	userId := rawUserId.String()

	profile.ID = userId

	t := time.Now()
	profile.JoinedIn = t.Month().String() + " " + strconv.Itoa(t.Year()) // time.Now().Format(time.RFC3339) // TODO: must not be modified again

	result := db.Create(profile)
	if result.Error != nil {
		return result.Error
	}
	
	//result = db.Raw("SELECT LAST_INSERT_ID()").Scan(&profile)

	

	return nil
}
