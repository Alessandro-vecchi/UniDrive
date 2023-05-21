package api

import (
	"UniDrive/back-end/database"

	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

type Body struct {
	RideId string `json:"ride_id"`
	UserId string `json:"user_id"`
}

func (h *Handler) bookRide(c *gin.Context) {
	var body Body

	if err := c.ShouldBindJSON(&body); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Failed to decode body", "error": err})
		return
	}

	user_id := body.UserId
	ride_id := body.RideId

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
		// The booking already exists.
		// 204 No Content for idempotency.
		c.JSON(204, gin.H{"message": "Already booked"})
		return
	} else if err != gorm.ErrRecordNotFound {
		c.JSON(500, gin.H{"error": "cannot get from database", "message": err.Error()})
		return
	}

	booking, err := database.BookRide(gormDB, user_id, ride_id)
	if err != nil {
		c.JSON(500, gin.H{"error": "cannot post to database", "message": err.Error()})
		return
	}

	c.JSON(201, booking)

}
