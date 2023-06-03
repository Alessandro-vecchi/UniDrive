package gmaps

import (
	"context"
	"fmt"
	"log"
	"os"

	"googlemaps.github.io/maps"
)

func GetCoordinates(address string) (float64, float64, string, error) {
	apiKey := os.Getenv("GOOGLE_MAPS_API_KEY")
	googleMapsClient, err := maps.NewClient(maps.WithAPIKey(apiKey))
	if err != nil {
		log.Fatalf("failed to create client: %v", err)
	}

	r := &maps.GeocodingRequest{
		Address:  address,
		Language: "it",
	}

	resp, err := googleMapsClient.Geocode(context.Background(), r)
	if err != nil {
		return 0, 0, "", err
	}
	if len(resp) == 0 {
		return 0, 0, "", fmt.Errorf("no results for %s", address)
	}

	return resp[0].Geometry.Location.Lat, resp[0].Geometry.Location.Lng, resp[0].FormattedAddress, nil
}

// reverse geocoding
func GetAddress(lat, lng float64) (string, error) {
	apiKey := os.Getenv("GOOGLE_MAPS_API_KEY")
	googleMapsClient, err := maps.NewClient(maps.WithAPIKey(apiKey))
	if err != nil {
		log.Fatalf("failed to create client: %v", err)
	}

	r := &maps.GeocodingRequest{
		LatLng: &maps.LatLng{
			Lat: lat,
			Lng: lng,
		},
		Language: "it",
	}

	resp, err := googleMapsClient.ReverseGeocode(context.Background(), r)
	if err != nil {
		return "", err
	}
	if len(resp) == 0 {
		return "", fmt.Errorf("no results for coordinates: %v, %v", lat, lng)
	}

	// Return the formatted address of the first result.
	return resp[0].FormattedAddress, nil
}
