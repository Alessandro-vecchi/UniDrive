package api

import (
	"UniDrive/back-end/gmaps"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func (h *Handler) autocomplete(c *gin.Context) {

	// Retrieving query parameters input, latitude and longitude.
	input := c.Query("input")
	lat, _ := strconv.ParseFloat(c.Query("latitude"), 64)
	lng, _ := strconv.ParseFloat(c.Query("longitude"), 64)
	predictions, err := gmaps.GetSuggestedPlaces(input, lat, lng)
	if err != nil {
		log.Fatalf("failed to get suggested places: %v", err)
	}

	for _, prediction := range predictions {
		fmt.Println(prediction.Description)
	}

	c.JSON(http.StatusOK, predictions)
}
