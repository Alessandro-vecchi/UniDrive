package api

import (
	"UniDrive/back-end/database"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getRides(c *gin.Context) {
	// Retrieving query parameters
	from := c.Query("origin")
	to := c.Query("destination")
	date_time := c.Query("date_time") // 2023-05-31 17:06

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
	user_id := c.GetHeader("user_id")

	rides, err := database.SearchRides(gormDB, from, to, date_time, user_id)
	if err == gorm.ErrRecordNotFound {
		c.JSON(http.StatusNotFound, gin.H{"message": "No rides found", "error": err.Error()})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get profile from database", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, rides)
}
