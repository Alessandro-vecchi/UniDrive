package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func GetProfile(db *gorm.DB, userId int) (models.Profile, error) {
	var p models.Profile
	row := db.Raw("SELECT * FROM profile WHERE id = ?",userId).Row()
	err := row.Scan(&p.Id, &p.Username, &p.Age, &p.Faculty, &p.Profile_picture_url, &p.Bio, &p.Total_rides_given, p.Joined_in, &p.Car_details.Car_model, &p.Car_details.Car_color, &p.Car_details.Car_plate, &p.City, &p.District, p.Instagram_url)
	return p,err

	
}
