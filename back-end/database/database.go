package database

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// Attach the DB to the Gin context using middleware
func New(db *gorm.DB) gin.HandlerFunc {

	sqlStatement := `
	CREATE TABLE IF NOT EXISTS profile
	(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, age INTEGER NOT NULL, faculty TEXT NOT NULL, profile_picture_url TEXT, bio TEXT, total_rides_given INTEGER NOT NULL, joined_in TEXT NOT NULL, car_model TEXT, car_color TEXT, car_plate TEXT, city TEXT NOT NULL, district TEXT NOT NULL, instagram_url TEXT);
	CREATE TABLE IF NOT EXISTS review 
	(id INTEGER PRIMARY KEY AUTOINCREMENT, reviewed_user_id INTEGER NOT NULL, rating INTEGER NOT NULL, review TEXT, timestamp TEXT NOT NULL, author_name TEXT NOT NULL,
	FOREIGN KEY (reviewed_user_id)
	REFERENCES profile(id)
	ON UPDATE CASCADE ON DELETE CASCADE);
	CREATE TABLE IF NOT EXISTS ride
	(id INTEGER PRIMARY KEY AUTOINCREMENT, origin TEXT NOT NULL, destination TEXT NOT NULL, driver_name TEXT NOT NULL, driver_id INTEGER NOT NULL, available_seats INTEGER NOT NULL, depart_hour TEXT NOT NULL,
	FOREIGN KEY (driver_id)
	REFERENCES profile(id)
	ON UPDATE CASCADE ON DELETE CASCADE);
	CREATE TABLE IF NOT EXISTS booking 
	(id INTEGER PRIMARY KEY AUTOINCREMENT, ride_id INTEGER NOT NULL, booking_timestamp TEXT NOT NULL, passenger_id INTEGER NOT NULL,
	FOREIGN KEY (ride_id)
	REFERENCES ride(id)
	ON UPDATE CASCADE ON DELETE CASCADE);
	
	`
	result := db.Exec(sqlStatement)
	if result.Error != nil {
		fmt.Println("Error creating tables", result.Error)
	}

	return func(c *gin.Context) {
		c.Set("DB", db)
		c.Next()
	}
}
