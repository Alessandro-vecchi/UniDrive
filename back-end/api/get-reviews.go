package api

import (
	"net/http"

	"UniDrive/back-end/database"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getReviews(c *gin.Context) {
	// Retrieve the DB instance from the context
	db, exists := c.Get("DB")
	if !exists {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	if !ok {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Invalid database connection type"})
		return
	}

	user_id := c.Param("user_id")

	reviews, err := database.GetReviews(gormDB, user_id)
	if err == gorm.ErrRecordNotFound {
		c.JSON(http.StatusNotFound, gin.H{"message": "No reviews found", "error": err.Error()})
		return
	} else if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Failed to get reviews from database", "error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, reviews)
}
