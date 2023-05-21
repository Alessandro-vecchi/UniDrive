package api

import (
	"UniDrive/back-end/api/models"
	"UniDrive/back-end/database"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) updateProfile(c *gin.Context) {

	var profile models.Profile
	if err := c.ShouldBindJSON(&profile); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Failed to decode profile"})
		return
	}
	// Retrieve the ID from the path parameters
	profile.Id = c.Param("user_id")
	

	// Retrieve the DB instance from the context
	db, exists := c.Get("DB")
	if !exists {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Invalid database connection type"})
		return
	}

	err := database.UpdateProfile(gormDB, profile)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error(), "message": "Failed to update profile"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Profile updated successfully"})
}
