package api

import (
	"UniDrive/back-end/database"

	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// bookRide is an API handler for booking a ride
func (h *Handler) bookRide(c *gin.Context) {

	user_id := gin.AuthUserKey
	ride_id := c.Param("ride_id")

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

	_, err := database.GetBookedRide(gormDB, user_id, ride_id)
	if err == nil {
		// The booking already exists. Return 409 Conflict
		c.JSON(http.StatusConflict, gin.H{"message": "Already booked"})
		return
	} else if err != gorm.ErrRecordNotFound {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "cannot get from database", "message": err.Error()})
		return
	}

	// Create the booking
	booking, err := database.BookRide(gormDB, user_id, ride_id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "cannot post to database", "message": err.Error()})
		return
	}

	// Booking created successfully, return 201 Created
	c.JSON(http.StatusCreated, booking)

}
