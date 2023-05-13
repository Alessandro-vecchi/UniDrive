package main

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"github.com/sirupsen/logrus"
)

type Web struct {
	APIHost         string
	DebugHost       string
	ReadTimeout     time.Duration
	WriteTimeout    time.Duration
	ShutdownTimeout time.Duration
}

var db *gorm.DB
var webConfig Web = Web{
	APIHost:         "0.0.0.0:3000",
	DebugHost:       "0.0.0.0:4000",
	ReadTimeout:     5 * time.Second,
	WriteTimeout:    5 * time.Second,
	ShutdownTimeout: 5 * time.Second,
}

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
	db, err = gorm.Open("postgres", "host=localhost user=gorm dbname=gorm password=gorm sslmode=disable")
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

	// Define a simple route
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	// Create the API server
	apiserver := &http.Server{
		Addr:         webConfig.APIHost,
		Handler:      r,
		ReadTimeout:  webConfig.ReadTimeout,
		WriteTimeout: webConfig.WriteTimeout,
	}

	// Start the service listening for requests in a separate goroutine
	go func() {
		logger.Infof("API listening on %s", apiserver.Addr)
		if err := apiserver.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			logger.Fatalf("listen: %s\n", err)
		}
		logger.Infof("stopping API server")
	}()

	// Wait for interrupt signal to gracefully shutdown the server with a timeout
	quit := make(chan os.Signal, 1) // buffer size of 1
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	logger.Println("Shutting down server...")

	ctx, cancel := context.WithTimeout(context.Background(), webConfig.ShutdownTimeout)
	defer cancel()
	if err := apiserver.Shutdown(ctx); err != nil {
		logger.Fatal("Server forced to shutdown:", err)
	}

	logger.Println("Server exiting")
}
