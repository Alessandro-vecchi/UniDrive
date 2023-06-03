package api

import (
	"net/http"
	"time"

	"UniDrive/back-end/api/models"

	"github.com/gin-gonic/gin"
	"github.com/gofrs/uuid"
	"github.com/jinzhu/gorm"
)

func (h *Handler) createReview(c *gin.Context) {
	user_id := c.Param("user_id")

	db, _ := c.Get("DB")
	conn := db.(*gorm.DB)

	rawReviewId, err := uuid.NewV4()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Could not create uuid", "error": err.Error()})
	}

	reviewId := rawReviewId.String()

	var feedback models.Review
	if err := c.BindJSON(&feedback); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"message": "Bad request", "error": err.Error()})
		return
	}

	feedback.ID = reviewId
	feedback.ReviewedUserID = user_id
	feedback.Timestamp = time.Now().Format(time.RFC3339)

	if err := conn.Save(&feedback).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "Could not create feedback", "error": err.Error()})
		return
	}

	c.JSON(201, feedback)
}
