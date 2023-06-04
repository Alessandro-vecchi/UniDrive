package api

import (
	"github.com/gin-gonic/gin"
)

// RegisterRoutes registers the API routes
func (h *Handler) RegisterRoutes(r *gin.Engine) {
	r.GET("/ping", h.ping)

	/* PROFILE */
	// Create an user profile
	r.POST("/profile/", h.createUser)
	// Get user profile
	r.GET("/profile/:user_id", h.getProfile)
	// Update user profile
	r.PUT("/profile/:user_id", h.updateProfile)

	/* REVIEW */
	// Create a review
	r.POST("/profile/:user_id/review/", h.createReview)
	// Get a list of reviews
	r.GET("/profile/:user_id/review/", h.getReviews)

	/* RIDES */
	// Search for rides by origin, destination and time
	r.GET("/rides/", h.getRides)
	// Get a ride
	r.GET("/rides/:id", h.getRide)

	/* BOOKING */
	// book a ride
	r.POST("/rides/:ride_id/booking/", h.bookRide)
	// delete a ride
	r.DELETE("/rides/:ride_id/booking/:booking_id", h.deleteBooking)

	/* CAR DETAILS */
	r.POST("/profile/:user_id/car_details", h.postCarDetails)

	/* REVERSE GEOCODING */
	r.GET("/reverse_geocoding", h.reverseGeocoding)

}
