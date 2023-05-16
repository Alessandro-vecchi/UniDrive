package models

type Profile struct{
	Username string `json:"username"`
	Age int `json:"age"`
	Faculty string `json:"faculty"`
	ProfilePictureUrl string `json:"profile_picture_url"`
	Bio string `json:"bio"`
	Reviews []Review `json:"reviews"`
	TotalRidesGiven int `json:"total_rides_given"`
} 