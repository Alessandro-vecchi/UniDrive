package api

import (
	"github.com/gin-gonic/gin"
)

// RegisterRoutes registers the API routes
func (h *Handler) RegisterRoutes(r *gin.Engine) {
	r.GET("/ping", h.ping)

	/* USER PROFILE */
	// Create an user profile
	r.POST("/profile/", h.crateANewUser)
	// Get user profile
	r.GET("/profile/:id", h.getProfileByID)
	// Update user profile
	r.PUT("/profile/:id", h.updateUserProfile)

	/* USER REVIEW */
	// Create a review
	r.POST("/feedback/", h.createReview)
	// Get a list of reviews
	r.GET("/feedback/", h.getReview)

}
