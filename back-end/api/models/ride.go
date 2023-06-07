package models

type Ride struct {
	ID               string       `gorm:"primary_key" json:"id"`
	Origin           string       `json:"origin"`
	Destination      string       `json:"destination"`
	DepartDatetime   string       `json:"depart_datetime"`
	DriverProfile    ShortProfile `json:"driver_profile"`
	AvailableSeats   int          `json:"available_seats"`
	MeetingPointInfo MeetingPoint `json:"meeting_point"`
	CarDetails       CarDetails   `json:"car_details"`
}

type ShortProfile struct {
	ProfilePictureUrl string  `json:"profile_picture_url"`
	Name              string  `json:"name"`
	Surname           string  `json:"surname"`
	Rating            float64 `json:"rating"`
}

type MeetingPoint struct {
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
	Address   string  `json:"address"`
	Distance  string  `json:"distance"`
	Time      string  `json:"time"`
}
