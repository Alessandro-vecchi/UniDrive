package api

import (
	"encoding/json"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
)

func(h *Handler) crateANewUser(c *gin.Context) {

	type Review struct {
	Rating int `json:"rating"`
	Review string `json:"review"`
	}

	type Profile struct{
		Username string `json:"username"`
		Age int `json:"age"`
		Faculty string `json:"faculty"`
		ProfilePictureUrl string `json:"profile_picture_url"`
		Bio string `json:"bio"`
		Reviews []Review `json:"reviews"`
		TotalRidesGiven int `json:"total_rides_given"`
	} 

	logger := logrus.StandardLogger()
	
	var profile Profile
	err := json.NewDecoder(c.Request.Body).Decode(&profile)
	if err != nil {
		c.Writer.WriteHeader(http.StatusBadRequest)
		logger.Info("Failed to decode profile")
	}

	//chiama db

	c.JSON(http.StatusOK, profile)
}