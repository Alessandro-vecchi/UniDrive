package models

type Ride struct {
	ID             string `gorm:"primary_key" json:"id"`
	Origin         string `json:"origin"`
	Destination    string `json:"destination"`
	DepartDatetime string `json:"depart_datetime"`
	DriverName     string `json:"driver_name"`
	DriverID       string `gorm:"not null;foreignkey:ProfileDBID" json:"driver_id"`
	AvailableSeats int    `json:"available_seats"`
}
