package models

type Ride struct {
	ID             string `json:"id"`
	From           string `json:"origin"`
	To             string `json:"destination"`
	DepartureHour  int    `json:"depart_hour"`
	DepartureMins  int    `json:"depart_mins"`
	DriverName     string `json:"driver_name"`
	DriverID       string `json:"driver_id"`
	AvailableSeats int    `json:"available_seats"`
}
