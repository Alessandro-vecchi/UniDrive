package api

import (
	"UniDrive/back-end/database"
	"net/http"
	"UniDrive/back-end/api/models"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) postCarDetails(c *gin.Context) {
	user_id := c.Param("user_id")

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
	var car_details models.CarDetails
	err := c.BindJSON(&car_details)
	if err != nil {
		c.JSON(500, gin.H{"error": err.Error(), "message": "failed to decode body"})
		return
	}

	database.PostCarDetails(gormDB, user_id, car_details)
}