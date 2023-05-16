package api

import (
	"encoding/json"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"UniDrive/back-end/api/models"
)

func(h *Handler) crateANewUser(c *gin.Context) {


	logger := logrus.StandardLogger()
	
	var profile models.Profile
	err := json.NewDecoder(c.Request.Body).Decode(&profile)
	if err != nil {
		c.Writer.WriteHeader(http.StatusBadRequest)
		logger.Info("Failed to decode profile")
	}

	//chiama db

	c.JSON(http.StatusOK, profile)
}