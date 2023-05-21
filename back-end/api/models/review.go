package models

type Review struct {
	ID             string `gorm:"type:varchar(100);primary_key" json:"id"`
	ReviewedUserID string `json:"reviewed_user_id"`
	Rating         int    `json:"rating"`
	Body           string `json:"body"`
	AuthorName     string `json:"author_name"`
	Timestamp      string `json:"timestamp"`
}
