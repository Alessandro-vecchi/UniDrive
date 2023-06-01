package database

import (
	"UniDrive/back-end/api/models"
	"time"

	"github.com/jinzhu/gorm"
)

// TempRide is a temporary structure to hold the data retrieved from the database
type TempRide struct {
	ID             string  `json:"id"`
	Origin         string  `json:"origin"`
	Destination    string  `json:"destination"`
	DepartDatetime string  `json:"depart_datetime"`
	AvailableSeats int     `json:"available_seats"`
	Name           string  `json:"name"`
	Surname        string  `json:"surname"`
	ProfilePictureUrl string `json:"profile_picture_url"`
	Rating         float64 `json:"rating"`
}

func SearchRides(db *gorm.DB, from string, to string, date_time string, user_id string) ([]models.Ride, error) {
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
		Select("ride.id, ride.origin, ride.destination, ride.depart_datetime, ride.available_seats, profile_dbs.name, profile_dbs.surname, profile_dbs.profile_picture_url, (SELECT AVG(rating) FROM reviews WHERE reviewed_user_id = ride.driver_id) as rating").
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
			Origin:         tempRide.Origin,
			Destination:    tempRide.Destination,
			DepartDatetime: tempRide.DepartDatetime,
			AvailableSeats: tempRide.AvailableSeats,
			DriverProfile: models.ShortProfile{
				Name:              tempRide.Name,
				Surname:           tempRide.Surname,
				ProfilePictureUrl: tempRide.ProfilePictureUrl,
				Rating:            tempRide.Rating,
			},
			// Populate MeetingPoint and MeetingTime here
			MeetingPoint:   "MeetingPoint",
			MeetingTime:    tempRide.DepartDatetime, // "MeetingTime",
		}
	}

	return rides, nil
}
