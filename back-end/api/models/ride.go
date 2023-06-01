package models

type Ride struct {
	ID             string       `gorm:"primary_key" json:"id"`
	Origin         string       `json:"origin"`
	Destination    string       `json:"destination"`
	DepartDatetime string       `json:"depart_datetime"`
	DriverProfile  ShortProfile `json:"driver_profile"`
	AvailableSeats int          `json:"available_seats"`
	MeetingPoint   string       `json:"meeting_point"`
	MeetingTime    string       `json:"meeting_time"`
}

type ShortProfile struct {
	ProfilePictureUrl string  `json:"profile_picture_url"`
	Name              string  `json:"name"`
	Surname           string  `json:"surname"`
	Rating            float64 `json:"rating"`
}
