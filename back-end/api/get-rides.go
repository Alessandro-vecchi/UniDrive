package api

import (
	"UniDrive/back-end/database"
	"UniDrive/back-end/gmaps"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getRides(c *gin.Context) {
	var (
		origin_lat, origin_lng   float64
		origin_formatted_address string
		err                      error
	)
	// Retrieving query parameter origin and convert him to latitude and longitude, if necessary.
	from := c.Query("origin")
	if from != "" {
		origin_lat, origin_lng, origin_formatted_address, err = gmaps.GetCoordinates(strings.ToLower(from))
		if err != nil {
			log.Fatalf("failed to get coordinates: %v", err)
		}
	} else {
		origin_lat, _ = strconv.ParseFloat(c.Query("origin_lat"), 64)
		origin_lng, _ = strconv.ParseFloat(c.Query("origin_lng"), 64)
		origin_formatted_address, err = gmaps.GetAddress(origin_lat, origin_lng)
		if err != nil {
			log.Fatalf("failed to get formatted address: %v", err)
		}
	}

	log.Printf("Coordinates: %v, %v, %v", origin_lat, origin_lng, origin_formatted_address)

	// Retrieving query parameter destination and convert him to latitude and longitude.
	to := c.Query("destination")

	destination_lat, destination_lng, destination_formatted_address, err := gmaps.GetCoordinates(strings.ToLower(to)) // Convert the search parameters to lowercase
	if err != nil {
		log.Fatalf("failed to get coordinates: %v", err)
	}

	log.Printf("Coordinates: %v, %v, %v", destination_lat, destination_lng, destination_formatted_address)

	// Retrieve the date and time from the query parameters
	dateTime := c.Query("date") // Assumes the format 2023-06-05T00:00:00.000

	// Split the dateTime string at "T" to separate the date and time parts
	parts := strings.Split(dateTime, "T")

	// Parse the date string in the format "2006-01-02"
	date := parts[0]

	time := c.Query("time") // Assumes the format "15:04"

	// Concatenate date and time with a space in between
	date_time := fmt.Sprintf("%s %s", date, time) // Result will be in the format "2006-01-02 15:04"
	log.Printf("Date Time: %v", date_time)

	// Retrieve the radius from the query parameters
	radiusStr := c.Query("radius")
	var radius float64
	if radiusStr == "" {
		radius = 2.0
	} else {
		radius, _ = strconv.ParseFloat(radiusStr, 64)
	}
	log.Printf("Radius: %v", radiusStr)

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

	user_id := c.GetHeader("Authorization")

	rides, err := database.SearchRides(gormDB, origin_lat, origin_lng, origin_formatted_address, destination_lat, destination_lng, destination_formatted_address, date_time, user_id, radius)
	if err == gorm.ErrRecordNotFound {
		c.JSON(http.StatusNotFound, gin.H{"message": "No rides found", "error": err.Error()})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get rides from database", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, rides)
}
