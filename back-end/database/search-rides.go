package database

import (
	"UniDrive/back-end/api/models"
	"fmt"

	"github.com/jinzhu/gorm"
)

func SearchRides(db *gorm.DB, from string, to string, date_time string) ([]models.Ride, error) {
	var rides []models.Ride

	// Query with case-insensitive AND  id = ? <> your_id = ?;
	rows, err := db.Raw("SELECT * FROM ride WHERE LOWER(origin) = ? AND LOWER(destination) = ? AND depart_datetime = ?", from, to, date_time).Rows()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var ride models.Ride
		rows.Scan(&ride.ID, &ride.Origin, &ride.Destination, &ride.DepartDatetime, &ride.DriverName, &ride.DriverID, &ride.AvailableSeats)
		rides = append(rides, ride)
		fmt.Println(ride, rides)
	}

	return rides, nil
}
