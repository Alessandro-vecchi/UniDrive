package database

import (
	"UniDrive/back-end/api/models"
	"strings"
	"time"

	"github.com/jinzhu/gorm"
	"golang.org/x/image/colornames"
)

type TempProfile struct {
	TotalRidesGiven int     `json:"total_rides_given"`
	Rating          float64 `json:"rating"`
	CarModel        string  `json:"car_model"`
	CarColor        string  `json:"car_color"`
	LicenseSince    string  `json:"license_since"`
	CarPlate        string  `json:"car_plate"`
}

func GetProfileByID(db *gorm.DB, id string) (*models.Profile, error) {
	var profile_db models.Profile_DB
	result := db.Where("id = ?", id).First(&profile_db)
	if result.Error != nil {
		return nil, result.Error
	}

	date_time := time.Now().UTC().String()[:16] // 2023-06-07 12:20
	layout := "2006-01-02 15:04"
	t, err := time.Parse(layout, date_time)
	if err != nil {
		return nil, err
	}
	endedRides := t.Add(-1 * time.Hour).Format(layout)

	var tempProfile TempProfile // Joins("JOIN reviews ON reviews.reviewed_user_id = profile_dbs.id").
	err = db.Debug().
		Table("profile_dbs").
		Select("(SELECT COUNT(*) FROM ride WHERE ride.driver_id = profile_dbs.id AND depart_datetime < ?) as total_rides_given, (SELECT AVG(rating) FROM reviews WHERE reviewed_user_id = profile_dbs.id) as rating, car_details.car_model, car_details.car_color, car_details.license_since, car_details.car_plate", endedRides).
		Joins("JOIN car_details ON car_details.user_id = profile_dbs.id").
		Where("profile_dbs.id = ?", id).
		Scan(&tempProfile).Error

	if err != nil {
		return nil, err
	}

	hexValue := colornames.Map[strings.ToLower(tempProfile.CarColor)]

	profile := models.Profile{
		Id:                profile_db.ID,
		Name:              profile_db.Name,
		Surname:           profile_db.Surname,
		Age:               profile_db.Age,
		Faculty:           profile_db.Faculty,
		University:        profile_db.University,
		ProfilePictureUrl: profile_db.ProfilePictureUrl,
		Bio:               profile_db.Bio,
		TotalRidesGiven:   tempProfile.TotalRidesGiven,
		JoinedIn:          profile_db.JoinedIn,
		Rating:            tempProfile.Rating,
		City:              profile_db.City,
		District:          profile_db.District,
		InstagramName:     profile_db.InstagramName,
		InstagramUrl:      profile_db.InstagramUrl,
		CarDetails: models.CarDetails{
			CarModel:     tempProfile.CarModel,
			CarColor:     tempProfile.CarColor,
			CarColorHex:  hexValue,
			LicenseSince: tempProfile.LicenseSince,
			CarPlate:     tempProfile.CarPlate,
		},
	}
	return &profile, nil
}
