package models

type Booking struct {
	RideId string `gorm:"not null;foreignkey:RideID" json:"ride_id"`
	BookingTimestamp string `json:"booking_timestamp"`
	CarDetails CarDetails `json:"car_details"`
}