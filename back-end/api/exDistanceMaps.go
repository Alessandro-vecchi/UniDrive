package api

import (
	"context"
	"log"

	"github.com/kr/pretty"
	"googlemaps.github.io/maps"
)

func main() {
	API_key := "AIzaSyD39NGTQHm7FYO4fGdZTwWcV7l2rKlv02U"
	c, err := maps.NewClient(maps.WithAPIKey(API_key))
	if err != nil {
		log.Fatalf("fatal error: %s", err)
	}
	r := &maps.DistanceMatrixRequest{
		Origins:      []string{"Sydney Town Hall"},
		Destinations: []string{"Parramatta, NSW"},
	}
	resp, err := c.DistanceMatrix(context.Background(), r)
    if err != nil {
		log.Fatalf("fatal error: %s", err)
	}
	pretty.Println(resp)
}

func directions() {
	API_key := "AIzaSyD39NGTQHm7FYO4fGdZTwWcV7l2rKlv02U"
	c, err := maps.NewClient(maps.WithAPIKey(API_key))
	if err != nil {
		log.Fatalf("fatal error: %s", err)
	}
	r := &maps.DirectionsRequest{
		Origin:      "Sydney",
		Destination: "Perth",
	}
	route, _, err := c.Directions(context.Background(), r)
	if err != nil {
		log.Fatalf("fatal error: %s", err)
	}

	pretty.Println(route)
}
