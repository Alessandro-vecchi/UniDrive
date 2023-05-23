package database

import (
	"context"
	"fmt"
	"log"
	"os"

	"googlemaps.github.io/maps"
)

func getCoordinates(address string) (float64, float64, error) {
	apiKey := os.Getenv("GOOGLE_MAPS_API_KEY")
	googleMapsClient, err := maps.NewClient(maps.WithAPIKey(apiKey))
	if err != nil {
		log.Fatalf("failed to create client: %v", err)
	}

	r := &maps.GeocodingRequest{
		Address: address,
	}

	resp, err := googleMapsClient.Geocode(context.Background(), r)
	if err != nil {
		return 0, 0, err
	}
	if len(resp) == 0 {
		return 0, 0, fmt.Errorf("no results for %s", address)
	}

	return resp[0].Geometry.Location.Lat, resp[0].Geometry.Location.Lng, nil
}

/* func gmaps() {
	lat, lng, err := getCoordinates("Via Gian Pietro Talamini")
	if err != nil {
		log.Fatalf("failed to get coordinates: %v", err)
	}

	log.Printf("Coordinates: %v, %v", lat, lng)
} */
