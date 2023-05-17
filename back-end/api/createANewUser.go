package api

import (
	"encoding/json"
	"net/http"
	"github.com/jinzhu/gorm"
	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"UniDrive/back-end/api/models"
	"UniDrive/back-end/database"
)

func(h *Handler) crateANewUser(c *gin.Context) {


	logger := logrus.StandardLogger()
	
	var profile models.Profile
	err := json.NewDecoder(c.Request.Body).Decode(&profile)
	if err != nil {
		c.Writer.WriteHeader(http.StatusBadRequest)
		logger.Info("Failed to decode profile")
	}

	// Retrieve the DB instance from the context
	db, exists := c.Get("DB")
	if !exists {
		// Handle DB not found in the context
		c.JSON(500, gin.H{"error": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	if !ok {
		// Handle incorrect DB instance type
		c.JSON(500, gin.H{"error": "Invalid database connection type"})
		return
	}

	user_id,err := database.PostProfile(gormDB, profile)
	if err != nil {
		c.JSON(500, gin.H{"error": "User cannot be added to database"})
		return
	}
	profile.Id = user_id
	c.JSON(http.StatusOK, profile)
}