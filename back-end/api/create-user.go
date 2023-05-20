package api

import (
	"UniDrive/back-end/api/models"
	"UniDrive/back-end/database"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"github.com/sirupsen/logrus"
)

func (h *Handler) createUser(c *gin.Context) {

	logger := logrus.StandardLogger()

	var profile models.Profile_DB
	if err := c.ShouldBindJSON(&profile); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to decode profile"})
		logger.Info("Failed to decode profile")
		return
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

	err := database.CreateProfile(gormDB, &profile)
	if err != nil {
		c.JSON(500, gin.H{"error": "User cannot be added to database"})
		return
	}

	c.JSON(201, profile)
}
