package database

import (
	"UniDrive/back-end/api/models"
	"UniDrive/back-end/gmaps"
	"time"

	"github.com/jinzhu/gorm"
)

// TempRide is a temporary structure to hold the data retrieved from the database
type TempRide struct {
	ID                   string  `json:"id"`
	OriginLatitude       float64 `json:"origin_latitude"`
	OriginLongitude      float64 `json:"origin_longitude"`
	DestinationLatitude  float64 `json:"destination_latitude"`
	DestinationLongitude float64 `json:"destination_longitude"`
	DepartDatetime       string  `json:"depart_datetime"`
	AvailableSeats       int     `json:"available_seats"`
	Name                 string  `json:"name"`
	Surname              string  `json:"surname"`
	ProfilePictureUrl    string  `json:"profile_picture_url"`
	Rating               float64 `json:"rating"`
}

func SearchRides(db *gorm.DB, origin_lat float64, origin_lng float64, origin_formatted_address string, destination_lat float64, destination_lng float64, destination_formatted_address string, date_time string, user_id string, radius float64) ([]models.Ride, error) {
	// Parse date_time into a Time
	layout := "2006-01-02 15:04"
	t, err := time.Parse(layout, date_time)
	if err != nil {
		return nil, err
	}

	// Start and end time for the date range
	startTime := t.Add(-1 * time.Hour).Format(layout)
	endTime := t.Add(1 * time.Hour).Format(layout)

	origin_min_lat, origin_max_lat, origin_min_long, origin_max_long := getCoordinatesRange(origin_lat, origin_lng, radius)
	destination_min_lat, destination_max_lat, destination_min_long, destination_max_long := getCoordinatesRange(destination_lat, destination_lng, 1.0) // Radius is always 1.0km for destination
	// Query rides
	tempRides := []TempRide{}
	err = db.Debug().
		Table("ride").
		Select("ride.id, ride.origin_latitude, ride.origin_longitude, ride.destination_latitude, ride.destination_longitude, ride.depart_datetime, ride.available_seats, profile_dbs.name, profile_dbs.surname, profile_dbs.profile_picture_url, (SELECT AVG(rating) FROM reviews WHERE reviewed_user_id = ride.driver_id) as rating").
		Joins("JOIN profile_dbs ON ride.driver_id = profile_dbs.id").
		Where("ride.origin_latitude BETWEEN ? AND ? AND ride.origin_longitude BETWEEN ? AND ? AND ride.destination_latitude BETWEEN ? AND ? AND ride.destination_longitude BETWEEN ? AND ? AND ride.depart_datetime BETWEEN ? AND ? AND ride.driver_id <> ?", origin_min_lat, origin_max_lat, origin_min_long, origin_max_long, destination_min_lat, destination_max_lat, destination_min_long, destination_max_long, startTime, endTime, user_id).
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
		origin_fa, err := gmaps.GetAddress(tempRide.OriginLatitude, tempRide.OriginLongitude)
		if err != nil {
			return nil, err
		}
		dest_fa, err := gmaps.GetAddress(tempRide.DestinationLatitude, tempRide.DestinationLongitude)
		if err != nil {
			return nil, err
		}
		rides[i] = models.Ride{
			ID:             tempRide.ID,
			Origin:         origin_fa,
			Destination:    dest_fa,
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
				Latitude:  tempRide.DestinationLatitude,
				Longitude: tempRide.DestinationLongitude,
				Distance:  0,
				Time:      tempRide.DepartDatetime,
			},
		}
	}

	return rides, nil
}
