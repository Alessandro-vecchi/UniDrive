import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.name,
    required this.surname,
    required this.date,
    required this.rating,
    required this.reviewBody,
  }) : super(key: key);

  final String name;
  final String surname;

  final DateTime date;
  final double rating;
  final String reviewBody;

  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(16),
      // ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$name $surname',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _getFormattedDate(date),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(5, (index) {
                    if (index < rating) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      );
                    } else {
                      return const Icon(
                        Icons.star_border,
                        color: Colors.grey,
                        size: 16,
                      );
                    }
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              reviewBody,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedDate(date) {
    final monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final formattedDate = '${monthNames[date.month]} ${date.day}, ${date.year}';
    return formattedDate;
  }
}
