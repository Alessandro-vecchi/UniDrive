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
		/* `DROP TABLE IF EXISTS profiles;`,
		`DROP TABLE IF EXISTS car_details;`,
		`DROP TABLE IF EXISTS reviews;`,
		`DROP TABLE IF EXISTS ride;`,
		`DROP TABLE IF EXISTS booking;`, */
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
			FOREIGN KEY (user_id)
				REFERENCES profile_dbs(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		);`,
		`CREATE TABLE IF NOT EXISTS reviews (
			id TEXT NOT NULL PRIMARY KEY,
			reviewed_user_id TEXT NOT NULL,
			rating INTEGER NOT NULL,
			review TEXT,
			timestamp TEXT NOT NULL,
			author_name TEXT NOT NULL,
			FOREIGN KEY (reviewed_user_id)
				REFERENCES profile_dbs(id)
				ON UPDATE CASCADE ON DELETE CASCADE
		);`,
		`CREATE TABLE IF NOT EXISTS ride (
			id TEXT NOT NULL PRIMARY KEY,
			origin TEXT NOT NULL,
			destination TEXT NOT NULL,
			depart_hour INTEGER,
			depart_mins INTEGER,
			driver_name TEXT NOT NULL,
			driver_id TEXT NOT NULL,
			available_seats INTEGER NOT NULL,
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
		);

		
		
		`,
		//INSERT INTO car_details VALUES ('5484dfb1-dd85-40e5-ae90-d17f0d967ed4', 'spark', 'green', 'EPNFRATM');
		//INSERT INTO ride VALUES('fratm', 'via fratellino', 'via sorellina','micio','5484dfb1-dd85-40e5-ae90-d17f0d967ed4', '4', '2002-10-02T10:00:00-05:00'   );
	}

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
