import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trendychef/Presentation/cart/cart.dart';
import 'package:trendychef/Presentation/home/home.dart';
import 'package:trendychef/Presentation/profile/profile.dart';
import 'package:trendychef/core/constants/colors.dart';

Container gNavBottom(BuildContext context) {
  List<Widget> pages = [HomePage(), CartPage(), ProfilePage()];
  return Container(
    width: 200,
    height: 70,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: GNav(
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: AppColors.primary.withOpacity(0.3),
        tabBorderRadius: 30,
        padding: EdgeInsets.all(16),
        gap: 10,

        onTabChange: (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => pages[value]),
          );
        },
        tabs: [
          GButton(icon: Icons.shopify_sharp, text: "Shop", onPressed: () {}),
          GButton(
            icon: const IconData(0xec92, fontFamily: 'MaterialIcons'),
            text: "Cart",
          ),
          GButton(icon: Icons.person, text: "Profile"),
        ],
      ),
    ),
  );
}
