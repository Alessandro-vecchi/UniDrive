package database

import (
	"fmt"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// Attach the DB to the Gin context using middleware
func New(db *gorm.DB) gin.HandlerFunc {
	// Define the SQL statements
	sqlStatements := []string{
		// `DROP TABLE IF EXISTS profiles;`,
		// `DROP TABLE IF EXISTS car_details;`,
		// `DROP TABLE IF EXISTS reviews;`,
		// `DROP TABLE IF EXISTS ride;`,
		// `DROP TABLE IF EXISTS booking;`,
		`CREATE TABLE IF NOT EXISTS profile_dbs (
			id TEXT NOT NULL PRIMARY KEY,
			name TEXT NOT NULL,
			surname TEXT NOT NULL,
			age INTEGER NOT NULL,
			faculty TEXT NOT NULL,
			university TEXT NOT NULL,
			profile_picture_url TEXT,
			bio TEXT,
			joined_in TEXT NOT NULL,
			city TEXT,
			district TEXT,
			instagram_url TEXT
		);`,
		`CREATE TABLE IF NOT EXISTS car_details (
			user_id TEXT NOT NULL PRIMARY KEY,
			car_model TEXT NOT NULL ,
			car_color TEXT NOT NULL,
			car_plate TEXT,
			tot_seats INTEGER NOT NULL,
			FOREIGN KEY (user_id)
				REFERENCES profile_dbs(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		);`,
		`CREATE TABLE IF NOT EXISTS reviews (
			id TEXT NOT NULL PRIMARY KEY,
			reviewed_user_id TEXT NOT NULL,
			rating INTEGER NOT NULL,
			body TEXT,
			timestamp TEXT NOT NULL,
			author_name TEXT NOT NULL,
			FOREIGN KEY (reviewed_user_id)
				REFERENCES profile_dbs(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		);`,
		`
		CREATE TABLE IF NOT EXISTS ride (
			id TEXT NOT NULL PRIMARY KEY,
			origin_latitude REAL NOT NULL,
			origin_longitude REAL NOT NULL,
			destination_latitude REAL NOT NULL,
			destination_longitude REAL NOT NULL,
			depart_datetime TEXT,
			driver_id TEXT NOT NULL,
			FOREIGN KEY (driver_id)
				REFERENCES profile_dbs(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		);`,
		`CREATE TABLE IF NOT EXISTS booking (
			id TEXT NOT NULL PRIMARY KEY,
			ride_id TEXT  NOT NULL,
			booking_timestamp TEXT NOT NULL,
			passenger_id TEXT  NOT NULL,
			FOREIGN KEY (ride_id)
				REFERENCES ride(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		);`,
		`INSERT INTO ride VALUES('delta', 41.762810, 12.480150, 41.904850, 12.517000, '2023-06-04 12:20', '733ae80e-372f-4764-9cb1-d400d0cd8138');
		INSERT INTO ride VALUES('gamma', 41.770110, 12.484130, 41.902340, 12.510000, '2023-06-04 12:30', '03827aaa-e229-4623-b5ec-d842d691c8ea');
		INSERT INTO ride VALUES('bravo', 41.748114, 12.479390, 41.908341, 12.521080, '2023-06-04 11:50', '61e28f09-d297-4578-9f4e-448ed329bc63');`,
	}
	// Enable foreign key constraints
	/*err := db.Exec("PRAGMA foreign_keys = 1").Error
	if err != nil {
		fmt.Println("Error enabling foreign key constraints:", err)
		return nil
	}*/

	// Execute each SQL statement
	for _, statement := range sqlStatements {
		result := db.Exec(statement)
		if result.Error != nil {
			fmt.Println("Error creating tables:", result.Error)
		}
	}

	return func(c *gin.Context) {
		c.Set("DB", db)
		c.Next()
	}
}
