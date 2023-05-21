package api

import (
	"UniDrive/back-end/database"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getRides(c *gin.Context) {
	// Retrieving query parameters
	from := c.Query("origin")
	to := c.Query("destination")
	date := c.Query("date")
	at_hour := c.Query("hour")
	at_h, _ := strconv.Atoi(at_hour)
	at_m := c.Query("mins")
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
	// Convert the search parameters to lowercase
	from = strings.ToLower(from)
	to = strings.ToLower(to)
	date_time := date + " " + strconv.Itoa(at_h) + ":" + strconv.Itoa(at_min) // 2006-01-02 15:30

	rides, err := database.SearchRides(gormDB, from, to, date_time)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to search for rides"})
		return
	}

	c.JSON(http.StatusOK, rides)
}
