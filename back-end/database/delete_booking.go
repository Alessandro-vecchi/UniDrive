package database

import (
	
	"github.com/jinzhu/gorm"
	"errors"
)

func DeleteBooking(db *gorm.DB, booking_id string) (error) {
	tx := db.Begin()
	
	result := tx.Exec("UPDATE ride SET available_seats = available_seats + 1   WHERE id = (SELECT ride_id FROM booking WHERE id = ? )", booking_id)
	if result.Error != nil {
		return  result.Error
	}

	
	

	result = tx.Exec("DELETE FROM booking WHERE id = ?",booking_id)
	if result.Error != nil {
		tx.Rollback()
		return result.Error
	}

	if result.RowsAffected == 0{
		tx.Rollback()
		return errors.New("no rows affected")
	}

	
	tx.Commit()
	
	return nil
}