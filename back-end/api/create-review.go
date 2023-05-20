package api

import (
	"net/http"

	"UniDrive/back-end/api/models"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) createReview(c *gin.Context) {
	db, _ := c.Get("DB")
	conn := db.(*gorm.DB)

	var feedback models.Review
	if err := c.BindJSON(&feedback); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Bad request"})
		return
	}

	if err := conn.Save(&feedback).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Could not create feedback"})
		return
	}

	c.JSON(201, gin.H{"data": feedback})
}
