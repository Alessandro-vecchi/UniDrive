package models

type Ride struct {
	ID             string `json:"id"`
	From           string `json:"origin"`
	To             string `json:"destination"`
	DepartureHour  string `json:"depart_hour"`
	DriverName     string `json:"driver_name"`
	DriverID       string `json:"driver_id"`
	AvailableSeats int    `json:"available_seats"`
}
