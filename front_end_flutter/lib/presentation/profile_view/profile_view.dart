import 'package:flutter/cupertino.dart';
import 'package:uni_drive/presentation/profile_view/widgets/experience_info.dart';
import 'package:uni_drive/presentation/profile_view/widgets/recent_reviews.dart';

import 'widgets/personal_info.dart';
import 'widgets/profile_header.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF363ABE),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: const [
            ProfileHeader(),
            SizedBox(height: 8),
            ExperienceInfo(),
            SizedBox(height: 8),
            PersonalInfo(),
            SizedBox(height: 8),
            RecentReviews(),
          ],
        ),
      ),
    );
  }
}
