package database

import (
	"UniDrive/back-end/api/models"
	"fmt"
	"log"

	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
)

func CreateProfile(db *gorm.DB, profile *models.Profile_DB) error {
	// creating user id
	rawUserId, err := uuid.NewV4()
	if err != nil {
		log.Fatalf("failed to get UUID: %v", err)
	}
	log.Printf("generated Version 4 UUID for the comment: %v", rawUserId)
	userId := rawUserId.String()

	profile.ID = userId
	// profile.JoinedIn = time.Now().Format(time.RFC3339) // TODO: must not be modified again

	result := db.Save(profile)
	fmt.Println(result)
	if result.Error != nil {
		return result.Error
	}

	return nil
}
