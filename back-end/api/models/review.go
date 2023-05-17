package models

type Review struct {
	ID string `gorm:"type:varchar(100);primary_key" json:"id"`
	Rating int `json:"rating"`
	Review string `json:"review"`
	Author_name string `json:"author_name"`
	Timestamp string `json:"timestamp"`
	}