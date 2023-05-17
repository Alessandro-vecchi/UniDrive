package models

type Profile struct {
	Username          string `json:"username"`
	Age               int    `json:"age"`
	Faculty           string `json:"faculty"`
	ProfilePictureUrl string `json:"profile_picture_url"`
	Bio               string `json:"bio"`
	// Reviews []Review `json:"reviews"`
	TotalRidesGiven int        `json:"total_rides_given"`
	JoinedIn        string     `json:"joined_in"`
	CarDetails      CarDetails `json:"car_details"`
	City            string     `json:"city"`
	District        string     `json:"district"`
	Instagram_url   string     `json:"instagram_url"`
}

type Profile_DB struct {
	ID                string `json:"id"`
	Username          string `json:"username"`
	Age               int    `json:"age"`
	Faculty           string `json:"faculty"`
	ProfilePictureUrl string `json:"profile_picture_url"`
	Bio               string `json:"bio"`
	JoinedIn          string `json:"joined_in"`
	City              string `json:"city"`
	District          string `json:"district"`
	InstagramUrl      string `json:"instagram_url"`
}
