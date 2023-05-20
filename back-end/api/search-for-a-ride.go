package api

import (
	"UniDrive/back-end/database"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) searchRides(c *gin.Context) {
	from := c.Query("from")
	to := c.Query("to")
	at := c.Query("at")

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

	rides, err := database.SearchRides(gormDB, from, to, at)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to search for rides"})
		return
	}

	c.JSON(http.StatusOK, rides)
}
