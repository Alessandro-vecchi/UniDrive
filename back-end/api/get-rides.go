package api

import (
	"UniDrive/back-end/database"
	"fmt"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getRides(c *gin.Context) {
	// Retrieving query parameters
	from := c.Query("origin")
	to := c.Query("destination")
	date := c.Query("date")
	at_h := c.Query("hour")
	at_min := c.Query("min")

	// Retrieve the DB instance from the context
	db, exists := c.Get("DB")
	if !exists {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Invalid database connection type"})
		return
	}
	// Convert the search parameters to lowercase
	from = strings.ToLower(from)
	to = strings.ToLower(to)
	date_time := date + " " + at_h + ":" + at_min // 2006-01-02 15:30
	fmt.Println(date_time, from, to)
	rides, err := database.SearchRides(gormDB, from, to, date_time)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to search for rides", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, rides)
}
