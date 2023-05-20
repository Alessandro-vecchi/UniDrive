package api

import (
	"github.com/gin-gonic/gin"
)

// RegisterRoutes registers the API routes
func (h *Handler) RegisterRoutes(r *gin.Engine) {
	r.GET("/ping", h.ping)

	/* USER PROFILE */
	// Create an user profile
	r.POST("/profile/", h.createUser)
	// Get user profile
	r.GET("/profile/:id", h.getProfile)
	// Update user profile
	r.PUT("/profile/:id", h.updateProfile)

	/* USER REVIEW */
	// Create a review
	r.POST("/profile/:user_id/review/", h.createReview)
	// Get a list of reviews
	r.GET("/feedback/", h.getReview)

	/* RIDES */
	// Search for rides by origin, destination and time
	r.GET("/rides/", h.getRides)
	// Get a ride
	r.GET("/rides/:id", h.getRide)

	/* BOOKING */
	// book a ride
	r.POST("/booking/", h.bookRide)
	// delete a ride
	r.DELETE("/booking/:booking_id", h.deleteBooking)

}
