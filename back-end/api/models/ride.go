package models

type Ride struct {
	ID                string `json:"id"`
	Origin            string `json:"origin"`
	To                string `json:"destination"`
	DepartureDatetime string `json:"depart_datetime"`
	DriverName        string `json:"driver_name"`
	DriverID          string `json:"driver_id"`
	AvailableSeats    int    `json:"available_seats"`
}
