package gmaps

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
)

type DistanceMatrixResponse struct {
	Rows []struct {
		Elements []struct {
			Status   string `json:"status"`
			Duration struct {
				Value int    `json:"value"`
				Text  string `json:"text"`
			} `json:"duration"`
			Distance struct {
				Value int    `json:"value"`
				Text  string `json:"text"`
			} `json:"distance"`
		} `json:"elements"`
	} `json:"rows"`
}

func ComputeDistance(originLat, originLng, destLat, destLng string) (int, int, error) {
	apiKey := os.Getenv("GOOGLE_MAPS_API_KEY")
	baseURL := "https://maps.googleapis.com/maps/api/distancematrix/json"

	// Build the request URL
	queryParams := url.Values{}
	queryParams.Set("units", "metric")
	// queryParams.Set("mode", "walking")
	queryParams.Set("origins", originLat+","+originLng)
	queryParams.Set("destinations", destLat+","+destLng)
	queryParams.Set("key", apiKey)
	url := baseURL + "?" + queryParams.Encode()
	log.Printf("URL: %v", url)

	// Send the HTTP request
	resp, err := http.Get(url)
	if err != nil {
		return 0, 0, err
	}
	defer resp.Body.Close()

	// Read the response body
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return 0, 0, err
	}

	// Parse the JSON response
	var response DistanceMatrixResponse
	err = json.Unmarshal(body, &response)
	if err != nil {
		return 0, 0, err
	}

	// Check if there are any elements in the response
	if len(response.Rows) == 0 || len(response.Rows[0].Elements) == 0 {
		return 0, 0, fmt.Errorf("no distance matrix elements found in the response")
	}

	// Extract the distance and duration values
	distance := response.Rows[0].Elements[0].Distance.Value
	duration := response.Rows[0].Elements[0].Duration.Value

	return distance, duration, nil
}

/* func main() {
	originLat := "37.7749"
	originLng := "-122.4194"
	destLat := "34.0522"
	destLng := "-118.2437"

	distance, duration, err := ComputeDistance(originLat, originLng, destLat, destLng)
	if err != nil {
		log.Fatalf("Failed to compute distance: %v", err)
	}

	fmt.Printf("Distance: %d meters\n", distance)
	fmt.Printf("Duration: %d seconds\n", duration)
} */
