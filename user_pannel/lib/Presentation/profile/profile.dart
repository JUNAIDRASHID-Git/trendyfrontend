import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/profile/widgets/buttons/log_out_btn.dart';
import 'package:trendychef/Presentation/profile/widgets/page_view/page_view_profile.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/data/models/user_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              FutureBuilder<UserModel?>(
                future: fetchUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("❌ Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text("User not found"));
                  }

                  final user = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary.withOpacity(0.8),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name?.isNotEmpty == true
                                  ? user.name!
                                  : 'Guest',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontBlack,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.email?.isNotEmpty == true
                                  ? user.email!
                                  : (user.phone?.isNotEmpty == true
                                      ? user.phone!
                                      : ''),
                              style: TextStyle(
                                color: AppColors.fontBlack.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 10),
                            logOutBtn(context),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              SizedBox(child: const PageViewWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
