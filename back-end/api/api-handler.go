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

	/* RIDES */
	// Search for rides by origin, destination and time
	r.GET("/rides/", h.searchRides)
	// Get a ride
	r.GET("/rides/:id", h.getRideByID)

	/* BOOKING */
	// book a ride
	r.POST("/booking/", h.bookRide)
	// delete a ride
	r.DELETE("/booking/:booking_id", h.deleteBooking)

}
