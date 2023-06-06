part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewLoading extends ReviewState {
  const ReviewLoading();
  @override
  List<Object> get props => [];
}

class ReviewLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

class ReviewError extends ReviewState {
  const ReviewError();

  @override
  List<Object> get props => [];
}
