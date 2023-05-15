package api

import (
	"github.com/gin-gonic/gin"
)


// RegisterRoutes registers the API routes
func (h *Handler) RegisterRoutes(r *gin.Engine) {
	r.GET("/ping", h.ping)
}


