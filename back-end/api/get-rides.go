package api

import (
	"UniDrive/back-end/database"
	"fmt"
	"log"
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
	// Convert the search parameters to lowercase
	from = strings.ToLower(from)
	to = strings.ToLower(to)

	date := c.Query("date") // Assumes the format "2006-01-02"
	time := c.Query("time") // Assumes the format "15:04"

	// Concatenate date and time with a space in between
	date_time := fmt.Sprintf("%s %s", date, time) // Result will be in the format "2006-01-02 15:04"

	radiusStr := c.Query("radius")
	var radius float64
	if radiusStr == "" {
		radius = 1.0
	} else {
		radius, _ = strconv.ParseFloat(radiusStr, 64)
	}

	origin_lat, origin_lng, origin_formatted_address, err := getCoordinates(from)
	if err != nil {
		log.Fatalf("failed to get coordinates: %v", err)
	}

	log.Printf("Coordinates: %v, %v", origin_lat, origin_lng, origin_formatted_address)

	destination_lat, destination_lng, destination_formatted_address, err := getCoordinates(from)
	if err != nil {
		log.Fatalf("failed to get coordinates: %v", err)
	}

	log.Printf("Coordinates: %v, %v", destination_lat, destination_lng, destination_formatted_address)

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

	user_id := c.GetHeader("user_id")

	rides, err := database.SearchRides(gormDB, origin_lat, origin_lng, origin_formatted_address, destination_lat, destination_lng, destination_formatted_address, date_time, user_id, radius)
	if err == gorm.ErrRecordNotFound {
		c.JSON(http.StatusNotFound, gin.H{"message": "No rides found", "error": err.Error()})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get profile from database", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, rides)
}
