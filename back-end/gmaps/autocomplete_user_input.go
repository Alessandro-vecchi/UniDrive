package gmaps

import (
	"context"
	"log"
	"os"

	"googlemaps.github.io/maps"
)

func GetSuggestedPlaces(input string, latitude, longitude float64) ([]maps.AutocompletePrediction, error) {
	apiKey := os.Getenv("GOOGLE_MAPS_API_KEY")
	googleMapsClient, err := maps.NewClient(maps.WithAPIKey(apiKey))
	if err != nil {
		log.Fatalf("failed to create client: %v", err)
	}

	r := &maps.PlaceAutocompleteRequest{
		Input:    input,
		Language: "it", // Set language to Italian
		Location: &maps.LatLng{
			Lat: latitude,
			Lng: longitude,
		},
		Radius: 100000, // Set radius to 100 km
	}

	resp, err := googleMapsClient.PlaceAutocomplete(context.Background(), r)
	if err != nil {
		return nil, err
	}

	return resp.Predictions, nil
}

/* func main() {
	predictions, err := getSuggestedPlaces("piazza")
	if err != nil {
		log.Fatalf("failed to get suggested places: %v", err)
	}

	for _, prediction := range predictions {
		fmt.Println(prediction.Description)
	}
} */
