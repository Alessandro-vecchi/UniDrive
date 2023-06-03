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
		//`DROP TABLE IF EXISTS car_details;`,
		// `DROP TABLE IF EXISTS reviews;`,
		//`DROP TABLE IF EXISTS ride;`,
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
		`INSERT INTO ride VALUES('delta', 41.762810, 12.480150, 41.904850, 12.517000, '2023-06-04 12:20', 'f836fbd7-14bf-4c3d-b708-824f0fbad5d6');
		INSERT INTO ride VALUES('gamma', 41.770110, 12.484130, 41.902340, 12.510000, '2023-06-04 12:30', '4e6481eb-3d62-4326-8701-a75862197acd');
		INSERT INTO ride VALUES('bravo', 41.748114, 12.479390, 41.908341, 12.521080, '2023-06-04 11:50', '55498bcc-b298-4ebe-92b4-86931a5b8df3');`,

		//INSERT INTO car_details VALUES ('e50490db-c90d-4fb6-b593-c9c76b0ba616', 'spark', 'green', 'EPNFRATM');
		//INSERT INTO ride VALUES('gamma', 'via fratellino', 'via sorellina','2023-06-04 12:00', 'f279fde7-4976-4d41-ab4b-e99568236d90', '4');

		/* INSERT INTO ride VALUES('delta', 41.762810, 12.480150, 41.904850, 12.517000, '2023-06-04 12:20', 'f836fbd7-14bf-4c3d-b708-824f0fbad5d6', '3');
		INSERT INTO ride VALUES('gamma', 41.770110, 12.484130, 41.902340, 12.515000, '2023-06-04 12:30', '4e6481eb-3d62-4326-8701-a75862197acd', '4');
		INSERT INTO ride VALUES('bravo', 41.764114, 12.479990, 41.904341, 12.516080, '2023-06-04 11:50', '55498bcc-b298-4ebe-92b4-86931a5b8df3', '1'); */
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
