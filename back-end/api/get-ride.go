package api

import (
	"UniDrive/back-end/database"
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getRide(c *gin.Context) {
	id := c.Param("id")

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

	ride, err := database.GetRideByID(gormDB, id)
	if err != nil {
		if err == gorm.ErrRecordNotFound {
			c.JSON(http.StatusNotFound, gin.H{"message": "ride not found", "error": err.Error()})
			return
		} else if err == errors.New("no seats available") {
			c.JSON(http.StatusBadRequest, gin.H{"message": "no seats available"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Invalid database connection type", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, ride)
}
