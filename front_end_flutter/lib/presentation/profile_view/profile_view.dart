import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_drive/presentation/profile_view/state/profile_cubit.dart';
import 'package:uni_drive/presentation/profile_view/widgets/experience_info.dart';
import 'package:uni_drive/presentation/profile_view/widgets/recent_reviews.dart';

import 'widgets/personal_info.dart';
import 'widgets/profile_header.dart';

class ProfileView extends StatelessWidget {
  final String userId;

  const ProfileView(this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit()..getProfile(userId),
      child: SafeArea(
        child: Container(
          color: const Color(0xFF363ABE),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) => switch (state) {
              ProfileLoading() =>
                const Center(child: CircularProgressIndicator()),
              ProfileLoaded() => ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    ProfileHeader(state.profile),
                    const SizedBox(height: 8),
                    ExperienceInfo(state.profile),
                    const SizedBox(height: 8),
                    PersonalInfo(state.profile),
                    const SizedBox(height: 8),
                    RecentReviews(state.profile),
                  ],
                ),
              ProfileError() => const Center(child: Text('Error')),
            },
          ),
        ),
      ),
    );
  }
}
