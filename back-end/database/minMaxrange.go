package database

import (
	"math"
)

const EarthRadius = 6371 // Radius of Earth in km

func getCoordinatesRange(lat float64, lng float64, radius float64) (float64, float64, float64, float64) {
	// Convert latitude and longitude from degrees to radians
	latRad := math.Pi * lat / 180
	// lngRad := math.Pi * lng / 180

	// Change in latitude = radius / Earth's radius
	// As latitude lines are parallel, the distance is the same anywhere on Earth
	dLat := radius / EarthRadius

	// As lines of longitude converge at the poles, the change in longitude depends on latitude
	dLng := radius / (EarthRadius * math.Cos(latRad))

	// Convert back to degrees
	dLatDeg := dLat * 180 / math.Pi
	dLngDeg := dLng * 180 / math.Pi

	// Calculate the min and max latitude and longitude
	minLat := lat - dLatDeg
	maxLat := lat + dLatDeg
	minLng := lng - dLngDeg
	maxLng := lng + dLngDeg

	return minLat, maxLat, minLng, maxLng
}
