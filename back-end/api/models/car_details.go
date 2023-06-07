package models

import "image/color"

type CarDetails struct {
	UserID       string     `gorm:"not null;foreignkey:ProfileDBID" json:"user_id"`
	CarModel     string     `json:"car_model"`
	CarColor     string     `json:"car_color"`
	CarColorHex  color.RGBA `json:"car_color_hex"`
	CarPlate     string     `json:"car_plate"`
	LicenseSince string     `json:"license_since"`
	TotSeats     int        `json:"tot_seats"`
}
