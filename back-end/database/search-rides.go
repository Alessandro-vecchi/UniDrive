package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func SearchRides(db *gorm.DB, from string, to string, date_time string, user_id string) ([]models.Ride, error) {
	var rides []models.Ride

	// Query with case-insensitive AND  id = ? <> your_id = ?;
	rows, err := db.Raw("SELECT * FROM ride WHERE LOWER(origin) = ? AND LOWER(destination) = ? AND depart_datetime = ? AND  driver_id <> ?;", from, to, date_time, user_id).Rows()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	found := false
	for rows.Next() {
		var ride models.Ride
		rows.Scan(&ride.ID, &ride.Origin, &ride.Destination, &ride.DepartDatetime, &ride.DriverName, &ride.DriverID, &ride.AvailableSeats)
		rides = append(rides, ride)
		found = true
		// fmt.Println(ride, rides)
	}

	if !found {
		return nil, gorm.ErrRecordNotFound
	}

	return rides, nil
}
