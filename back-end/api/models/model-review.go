package models

type Review struct {
	ID string `gorm:"type:varchar(100);primary_key" json:"id"`
	Rating int `json:"rating"`
	Review string `json:"review"`
	Author string `json:"author"`
	CreatedAt string `json:"created_at"`
	}