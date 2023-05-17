package api

import (
	"fmt"
	"net/http"

	"UniDrive/back-end/api/models"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

func (h *Handler) getReview(c *gin.Context) {
	db, _ := c.Get("DB")
	conn := db.(*gorm.DB)

	id := c.Param("id")

	var review models.Review
	if err := conn.First(&review, id).Error; err != nil {
		fmt.Println(err, id, review)
		c.JSON(http.StatusNotFound, gin.H{"error": "Review not found"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"data": review})
}
