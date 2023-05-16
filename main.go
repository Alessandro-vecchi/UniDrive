package main

import (
	"os"

	"UniDrive/back-end/api"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
	"github.com/sirupsen/logrus"
)

var db *gorm.DB

func main() {

	// Init logging
	logger := logrus.New()
	logger.SetOutput(os.Stdout)
	logger.SetLevel(logrus.InfoLevel)

	logger.Infof("application initializing")

	// Start Database
	logger.Println("initializing database support")

	// Connect to the database
	var err error
	db, err = gorm.Open("sqlite3", "server.db")
	if err != nil {
		logger.Fatalf("failed to connect database: %v", err)
		panic("failed to connect database")
	}
	defer func() {
		logger.Debug("database stopping")
		_ = db.Close()
	}()
	

	// Initialise Gin
	r := gin.Default()

	// Attach the DB to the Gin context using middleware
	r.Use(func(c *gin.Context) {
		c.Set("DB", db)
		c.Next()
	})

	// Use the Logrus logger as the Gin router's logger
	//r.Use(gin.LoggerWithWriter(logger.Writer()))

	// Create the API server

	// Initialise API handler and register routes
	apiHandler := api.NewHandler()
	apiHandler.RegisterRoutes(r)

	// Start the service listening for requests
	logger.Infof("API listening on %s", "0.0.0.0:3000")
	r.Run("0.0.0.0:3000") // listens on 0.0.0.0:3000

	logger.Println("Server exiting")
}
