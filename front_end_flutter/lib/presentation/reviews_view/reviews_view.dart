import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_header_adaptive/adaptive_height_sliver_persistent_header.dart';
import 'package:uni_drive/presentation/reviews_view/state/review_cubit.dart';
import 'package:uni_drive/presentation/reviews_view/widgets/review_list.dart';

import '../../models/profile.dart';
import 'widgets/review_header.dart';

class ReviewView extends StatelessWidget {
  final Profile profile;

  const ReviewView(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewCubit>(
        create: (context) => ReviewCubit()..getReviews(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Reviews'),
          ),
          body: BlocBuilder<ReviewCubit, ReviewState>(
            builder: (context, state) => switch (state) {
              ReviewLoading() => const Center(child: CircularProgressIndicator()),
              ReviewLoaded() => CustomScrollView(
                  slivers: [
                    AdaptiveHeightSliverPersistentHeader(
                      floating: true,
                      child: ReviewsHeader(
                        fullName: '${profile.name} ${profile.surname}',
                        totalReviews: state.reviews.length,
                        averageRating:
                            state.reviews.fold(0, (previousValue, element) => previousValue + element.rating.ceil()) /
                                state.reviews.length,
                        //todo get from profile
                        fiveStarReviews: state.reviews.where((element) => element.rating == 5).length,
                        fourStarReviews: state.reviews.where((element) => element.rating == 4).length,
                        threeStarReviews: state.reviews.where((element) => element.rating == 3).length,
                        twoStarReviews: state.reviews.where((element) => element.rating == 2).length,
                        oneStarReviews: state.reviews.where((element) => element.rating == 1).length,
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8),
                      sliver: SliverToBoxAdapter(
                        child: ReviewsList(state.reviews),
                      ),
                    ),
                  ],
                ),
              ReviewError() => const Center(child: Text('Error')),
            },
          ),
        ));
  }
}
