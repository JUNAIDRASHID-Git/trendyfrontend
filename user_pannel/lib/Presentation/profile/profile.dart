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
              SizedBox(height: 20),
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

                  final imageUrl =
                      user.picture != null && user.picture!.isNotEmpty
                          ? "https://corsproxy.io/?${Uri.encodeFull(user.picture!)}"
                          : null;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Image.network(
                              imageUrl ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.primary.withOpacity(0.8),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name.isNotEmpty == true
                                  ? user.name
                                  : 'Guest',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontBlack,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user.email?.isNotEmpty == true
                                  ? user.email!
                                  : (user.phone.isNotEmpty == true
                                      ? user.phone
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
