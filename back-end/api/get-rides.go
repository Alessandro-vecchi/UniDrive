package api

import (
	"UniDrive/back-end/database"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getRides(c *gin.Context) {
	// Retrieving query parameters
	from := c.Query("from")
	to := c.Query("to")
	date := c.Query("date")
	at_hour := c.Query("at_h")
	at_h, _ := strconv.Atoi(at_hour)
	at_m := c.Query("at_min")
	at_min, _ := strconv.Atoi(at_m)

	// Retrieve the DB instance from the context
	db, exists := c.Get("DB")
	if !exists {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Invalid database connection type"})
		return
	}

	rides, err := database.SearchRides(gormDB, from, to, date, at_h, at_min)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to search for rides"})
		return
	}

	c.JSON(http.StatusOK, rides)
}
