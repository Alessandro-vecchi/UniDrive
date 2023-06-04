package api

import (
	"UniDrive/back-end/gmaps"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func (h *Handler) reverseGeocoding(c *gin.Context) {

	// Retrieving query parameters latitude and longitude.
	lat, _ := strconv.ParseFloat(c.Query("latitude"), 64)
	lng, _ := strconv.ParseFloat(c.Query("longitude"), 64)
	formatted_address, err := gmaps.GetAddress(lat, lng)
	if err != nil {
		log.Fatalf("failed to get formatted address: %v", err)
	}

	log.Printf("Coordinates: %v, %v, %v", lat, lng, formatted_address)
	// log.Printf("formatted_address: %v", formatted_address[0])

	c.JSON(http.StatusOK, formatted_address)
}
