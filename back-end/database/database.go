package database

import (
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
)

// Attach the DB to the Gin context using middleware
func New(db *gorm.DB) gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Set("DB", db)
		c.Next()
	}
}