package database

import (
	"github.com/jinzhu/gorm"
	"UniDrive/back-end/api/models"
)

func PostProfile(db *gorm.DB, profile models.Profile) error{

	result := db.Exec(`INSERT INTO PROFILE(username,age,faculty,profile_picture_url,bio,total_rides_given,joined_in,car_model,car_color,car_plate,city,district,instagram_url) 
				VALUES(?,?,?,?,?,0,?,?,?,?,?,?,?)`,profile.Username, profile.Age, profile.Faculty, profile.Profile_picture_url, profile.Bio, profile.Total_rides_given, profile.Joined_in, profile.Car_details.Car_model, profile.Car_details.Car_color, profile.Car_details.Car_plate, profile.City, profile.District, profile.Instagram_url)
	if result.Error != nil {
		return result.Error
	}

	return nil
}