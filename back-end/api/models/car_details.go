package models

type CarDetails struct {
	UserID   string `gorm:"not null;foreignkey:ProfileDBID" json:"user_id"`
	CarModel string `json:"car_model"`
	CarColor string `json:"car_color"`
	CarPlate string `json:"car_plate"`
}
