package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"UniDrive/back-end/api"
	"UniDrive/back-end/database"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
	"github.com/sirupsen/logrus"
)

var db *gorm.DB

func init() {
	// Connect to the database
	var err error
	db, err = gorm.Open("sqlite3", "server.db")
	if err != nil {
		log.Fatalf("failed to connect database: %s", err)
	}
	// automatically create the database schema based on the Review struct
	// db.AutoMigrate(&models.Review{})
}
func main() {

	// Init logging
	logger := logrus.New()
	logger.SetOutput(os.Stdout)
	logger.SetLevel(logrus.InfoLevel)

	logger.Infof("application initializing")

	// Start Database
	logger.Println("initializing database support")
	defer func() {
		logger.Debug("database stopping")
		_ = db.Close()
	}()

	dbMiddleware := database.New(db)

	// Initialise Gin
	r := gin.Default()

	r.Use(dbMiddleware)

	// Use the Logrus logger as the Gin router's logger
	//r.Use(gin.LoggerWithWriter(logger.Writer()))

	// Create the API server

	// Initialise API handler and register routes
	apiHandler := api.NewHandler()
	apiHandler.RegisterRoutes(r)

	// Start the service listening for requests
	logger.Infof("API listening on %s", "0.0.0.0:3000")
	// r.Run("0.0.0.0:3000") // listens on 0.0.0.0:3000
	srv := &http.Server{
		Addr:    ":3000",
		Handler: r,
	}

	go func() {
		if err := srv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			logger.Fatalf("listen: %s\n", err)
		}
	}()

	/* Ensuring that in-progress tasks complete before the application or server stops.
	Wait for interrupt signal to gracefully shutdown the server with a timeout */

	quit := make(chan os.Signal, 1)                      // buffer size of 1
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM) // Ctrl+C or kill
	<-quit
	logger.Println("Shutting down server gracefully...")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := srv.Shutdown(ctx); err != nil {
		logger.Fatal("Server forced to shutdown:", err)
	}

	logger.Println("Server exiting")
}
