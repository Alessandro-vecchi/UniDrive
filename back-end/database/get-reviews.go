package database

import (
	"UniDrive/back-end/api/models"

	"github.com/jinzhu/gorm"
)

// da modifica
func GetReviews(db *gorm.DB, id string) ([]models.Review, error) {

	var reviews []models.Review

	// Query with case-insensitive
	rows, err := db.Raw("SELECT * FROM reviews WHERE reviewed_user_id = ?;", id).Rows()
	if err != nil {
		return []models.Review{}, err
	}
	defer rows.Close()

	found := false
	for rows.Next() {
		var review models.Review
		rows.Scan(&review.ID, &review.ReviewedUserID, &review.Rating, &review.Review, &review.Timestamp, &review.AuthorName)
		reviews = append(reviews, review)
		found = true
	}

	if !found {
		return []models.Review{}, gorm.ErrRecordNotFound
	}

	return reviews, nil
}
