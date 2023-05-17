package database

import (
	"UniDrive/back-end/api/models"
	"time"

	"github.com/jinzhu/gorm"
)

func PostProfile(db *gorm.DB, profile models.Profile) (int,error) {

	result := db.Exec(`INSERT INTO PROFILE(username,age,faculty,profile_picture_url,bio,total_rides_given,joined_in,car_model,car_color,car_plate,city,district,instagram_url) 
				VALUES(?,?,?,?,?,0,?,?,?,?,?,?,?)`, profile.Username, profile.Age, profile.Faculty, profile.Profile_picture_url, profile.Bio, time.Now().Format(time.RFC3339), profile.Car_details.Car_model, profile.Car_details.Car_color, profile.Car_details.Car_plate, profile.City, profile.District, profile.Instagram_url)
	if result.Error != nil {
		return 0,result.Error
	}
	
	//result = db.Raw("SELECT LAST_INSERT_ID()").Scan(&profile)

	

	return 0,result.Error
}
