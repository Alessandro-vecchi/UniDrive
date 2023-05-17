package models

type Profile struct{
	Id int `json:"id"`
	Username string `json:"username"`
	Age int `json:"age"`
	Faculty string `json:"faculty"`
	Profile_picture_url string `json:"profile_picture_url"`
	Bio string `json:"bio"`
	Reviews []Review `json:"reviews"`
	Total_rides_given int `json:"total_rides_given"`
	Joined_in string `json:"joined_in"`
	Car_details Car_details `json:"car_details"`
	City string `json:"city"`
	District string `json:"district"`
	Instagram_url string `json:"instagram_url"`
} 