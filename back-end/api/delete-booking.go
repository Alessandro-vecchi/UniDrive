package api

import (
	"UniDrive/back-end/database"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) deleteBooking(c *gin.Context) {

	booking_id := c.Param("booking_id")
	
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

	err := database.DeleteBooking(gormDB,booking_id)
	if err != nil {
		c.JSON(500, gin.H{"error": "cannot delete booking from database"})
		return
	}

	c.JSON(200, gin.H{"message": "booking eliminated succesfully"})


}