package database

import (
	"UniDrive/back-end/api/models"
	"time"
	"strconv"
	"github.com/jinzhu/gorm"
	"github.com/gofrs/uuid"
)

func BookRide(db *gorm.DB, user_id string, ride_id string) (models.Booking, error) {
	var booking models.Booking
	rawUuid, err := uuid.NewV4()
	if err != nil {
		return booking, err
	}
	uuid := rawUuid.String()
	

	t := time.Now()
	timestamp := t.Month().String() + " " + strconv.Itoa(t.Year())

	result := db.Exec("INSERT INTO ride(id, ride_id, booking_timestamp, passenger_id) values (?,?,?,?) ",uuid,ride_id,timestamp,user_id)
	if result.Error != nil {
		return booking, result.Error
	}
	

	var carDetails models.CarDetails

	result = db.Raw("SELECT * FROM car_details WHERE user_id = (SELECT driver_id FROM ride WHERE id = ?)",ride_id).Find(&carDetails)
	if result.Error != nil {
		return booking, result.Error
	}

	
	booking.RideId = ride_id
	booking.BookingTimestamp = timestamp
	booking.CarDetails = carDetails
	
	return booking, nil
}

