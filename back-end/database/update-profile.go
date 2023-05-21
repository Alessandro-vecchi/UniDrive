package database

import (
	"UniDrive/back-end/api/models"
	"github.com/jinzhu/gorm"
)

func UpdateProfile(db *gorm.DB, profile models.Profile) error {
	// Update the desired fields in the profile
	result := db.Model(&models.Profile_DB{}).Where("id = ?", profile.Id).Updates(models.Profile_DB{
		Name:          	profile.Name,
		Surname: 		profile.Surname,
		Age:               profile.Age,
		Faculty:           profile.Faculty,
		ProfilePictureUrl: profile.ProfilePictureUrl,
		Bio:               profile.Bio,
		City:              profile.City,
		District:          profile.District,
		InstagramUrl:      profile.InstagramUrl,
	})
	if result.Error != nil {
		return result.Error
	}

	result = db.Model(&models.CarDetails{}).Where("user_id = ?", profile.Id).Updates(models.CarDetails{
		CarModel: profile.CarDetails.CarModel,
		CarColor: profile.CarDetails.CarColor,
		CarPlate: profile.CarDetails.CarPlate,
	})
	if result.Error != nil {
		return result.Error
	}


	return nil
}
