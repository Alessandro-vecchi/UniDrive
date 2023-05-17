package api

import (
	"github.com/gin-gonic/gin"
)

// RegisterRoutes registers the API routes
func (h *Handler) RegisterRoutes(r *gin.Engine) {
	r.GET("/ping", h.ping)

	r.POST("/feedback/", h.createReview)
	r.GET("/feedback/:id", h.getReview)

	r.POST("/profile/", h.crateANewUser)
	r.GET("/profile/:id", h.getUserProfile)

}
