package api

import (
	"UniDrive/back-end/database"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) bookRide(c *gin.Context) {
	user_id := c.Query("user_id")
	ride_id := c.Query("ride_id")

	db, exists := c.Get("DB")
	if !exists {
		// Handle DB not found in the context
		c.JSON(500, gin.H{"error": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	if !ok {
		// Handle incorrect DB instance type
		c.JSON(500, gin.H{"error": "Invalid database connection type"})
		return
	}

	booking, err := database.BookRide(gormDB, user_id, ride_id)
	if err != nil {
		c.JSON(500, gin.H{"error": "cannot ost booking to database"})
		return
	}

	c.JSON(201, booking)
	
	
}
