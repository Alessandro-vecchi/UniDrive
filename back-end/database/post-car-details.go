package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

func PostCarDetails(db *gorm.DB, user_id string, car_details models.CarDetails) error {
	result := db.Exec("INSERT INTO car_details VALUES (?,?,?,?,?)", user_id, car_details.CarModel, car_details.CarColor, car_details.CarPlate, car_details.TotSeats)
	if result.Error != nil {
		return result.Error
	}

	return nil
}
