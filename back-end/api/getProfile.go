package api

import (
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	"strconv"
)

func (h *Handler) getUserProfile(c *gin.Context) {
	// Retrieve the DB instance from the context
	db, exists := c.Get("DB")
	if !exists {
		// Handle DB not found in the context
		c.JSON(500, gin.H{"error": "Database connection not found"})
		return
	}

	// Access the DB instance using type assertion
	gormDB, ok := db.(*gorm.DB)
	

	if !ok {
		// Handle incorrect DB instance type
		c.JSON(500, gin.H{"error": "Invalid database connection type"})
		return
	}

	userId, err := strconv.Atoi(c.Params.ByName("user_id"))
	if err!=nil {
		c.JSON(500, gin.H{"error": "cannot convert userid in int"})
		return
	}
	// Use the DB instance for querying data
	// ...
	_ = gormDB
}
