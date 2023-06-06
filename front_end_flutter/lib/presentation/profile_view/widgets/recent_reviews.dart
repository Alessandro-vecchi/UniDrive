import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_drive/presentation/reviews_view/reviews_view.dart';
import 'package:uni_drive/presentation/reviews_view/state/review_cubit.dart';

import '../../../models/profile.dart';
import '../../reviews_view/widgets/review_list.dart';

class RecentReviews extends StatelessWidget {
  final Profile profile;
  const RecentReviews(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewCubit>(
      create: (context) => ReviewCubit()..getReviews(limit: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF222227),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Recent Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewView(profile))),
                  child: const Text('See All'),
                ),
              ],
            ),
            BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) => switch (state) {
                ReviewLoading() => const Center(child: CircularProgressIndicator()),
                ReviewLoaded() => ReviewsList(state.reviews),
                ReviewError() => const Center(child: Text('Error')),
              },
            ),
          ],
        ),
      ),
    );
  }
}
