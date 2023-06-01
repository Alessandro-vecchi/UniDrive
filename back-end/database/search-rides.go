package database

import (
	"UniDrive/back-end/api/models"
	"time"

	"github.com/jinzhu/gorm"
)

// TempRide is a temporary structure to hold the data retrieved from the database
type TempRide struct {
	ID                   string  `json:"id"`
	OriginLatitude       float64  `json:"origin_latitude"`
	OriginLongitude      float64  `json:"origin_longitude"`
	DestinationLatitude  float64  `json:"destination_latitude"`
	DestinationLongitude float64  `json:"destination_longitude"`
	DepartDatetime       string  `json:"depart_datetime"`
	AvailableSeats       int     `json:"available_seats"`
	Name                 string  `json:"name"`
	Surname              string  `json:"surname"`
	ProfilePictureUrl    string  `json:"profile_picture_url"`
	Rating               float64 `json:"rating"`
}

func SearchRides(db *gorm.DB, origin_lat float64, origin_lng float64, origin_formatted_address string, destination_lat float64, destination_lng float64, destination_formatted_address string, date_time string, user_id string) ([]models.Ride, error) {
	// Parse date_time into a Time
	layout := "2006-01-02 15:04"
	t, err := time.Parse(layout, date_time)
	if err != nil {
		return nil, err
	}

	// Start and end time for the date range
	startTime := t.Add(-1 * time.Hour).Format(layout)
	endTime := t.Add(1 * time.Hour).Format(layout)

	// Query rides
	tempRides := []TempRide{}
	err = db.Debug().
		Table("ride").
		Select("ride.id, ride.origin_latitude, ride.origin_longitude, ride.destination_latitude, ride.destination_longitude, ride.depart_datetime, ride.available_seats, profile_dbs.name, profile_dbs.surname, profile_dbs.profile_picture_url, (SELECT AVG(rating) FROM reviews WHERE reviewed_user_id = ride.driver_id) as rating").
		Joins("JOIN profile_dbs ON ride.driver_id = profile_dbs.id").
		Where("LOWER(ride.origin) = ? AND LOWER(ride.destination) = ? AND ride.depart_datetime BETWEEN ? AND ? AND ride.driver_id <> ?", from, to, startTime, endTime, user_id).
		Scan(&tempRides).Error

	if err != nil {
		return nil, err
	}

	if len(tempRides) == 0 {
		return nil, gorm.ErrRecordNotFound
	}

	// Populate ShortProfile and Ride for each ride
	rides := make([]models.Ride, len(tempRides))
	for i, tempRide := range tempRides {
		rides[i] = models.Ride{
			ID:             tempRide.ID,
			Origin:         origin_formatted_address,
			Destination:    destination_formatted_address,
			DepartDatetime: tempRide.DepartDatetime,
			AvailableSeats: tempRide.AvailableSeats,
			DriverProfile: models.ShortProfile{
				Name:              tempRide.Name,
				Surname:           tempRide.Surname,
				ProfilePictureUrl: tempRide.ProfilePictureUrl,
				Rating:            tempRide.Rating,
			},
			// Populate MeetingPoint and MeetingTime here
			MeetingPointInfo: models.MeetingPoint{
				Latitude:  0,
				Longitude: 0,
				Distance:  0,
				Time:      tempRide.DepartDatetime,
			},
		}
	}

	return rides, nil
}
