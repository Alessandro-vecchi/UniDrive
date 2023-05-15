package api

import (
	"github.com/gin-gonic/gin"
)

// ping handles the ping API call
func (h *Handler) ping(c *gin.Context) {
	c.JSON(200, gin.H{
		"message": "pong",
	})
}