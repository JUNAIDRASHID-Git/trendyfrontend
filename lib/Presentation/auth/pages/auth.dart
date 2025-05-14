// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trendychef/Presentation/auth/widgets/applebtn.dart';
import 'package:trendychef/Presentation/auth/widgets/googlebtn.dart';
import 'package:trendychef/core/theme/colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  // Define the brand colors based on the logo


  @override
  Widget build(BuildContext context) {
    // Get screen size to implement responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLargeScreen = screenSize.width > 800;

    return Scaffold(
      backgroundColor: lightCream,
      body: SafeArea(
        child:
            isLargeScreen
                ? _buildTabletDesktopLayout(context, screenSize)
                : _buildMobileLayout(context, screenSize),
      ),
    );
  }

  // Two-column layout for tablet and desktop
  Widget _buildTabletDesktopLayout(BuildContext context, Size screenSize) {
    final bool isExtraLargeScreen = screenSize.width > 1200;
    final double branding = screenSize.width * (isExtraLargeScreen ? 0.6 : 0.5);
    final double auth = screenSize.width - branding;

    return Row(
      children: [
        // Left section - Logo and branding
        Container(
          width: branding,
          decoration: BoxDecoration(
            color: accentCream,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(3, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              SizedBox(
                width: isExtraLargeScreen ? 250 : 200,
                height: isExtraLargeScreen ? 250 : 200,
                child: Image.asset("assets/images/trendy_logo.png"),
              ),
              SizedBox(height: 40),
              // Brand name
              Text(
                "TRENDY CHEF",
                style: TextStyle(
                  fontSize: isExtraLargeScreen ? 48 : 38,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              SizedBox(height: 20),
              // Brand tagline
              SizedBox(
                width: branding * 0.7,
                child: Text(
                  "Cook Like a Pro, Eat Like a Gourmet",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isExtraLargeScreen ? 24 : 20,
                    fontFamily: "Poppins",
                    color: deepGreen,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Right section - Authentication
        Container(
          width: auth,
          padding: EdgeInsets.symmetric(horizontal: auth * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Welcome text
              Text(
                "WELCOME BACK",
                style: TextStyle(
                  fontSize: isExtraLargeScreen ? 42 : 36,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                ),
              ),
              SizedBox(height: isExtraLargeScreen ? 60 : 40),

              // Auth buttons
              SizedBox(width: auth * 0.7, child: googleBtn(context)),
              SizedBox(height: 20),
              SizedBox(width: auth * 0.7, child: appleBtn()),
              SizedBox(height: isExtraLargeScreen ? 60 : 40),

              // Sign in text
              Text(
                "Continue your order by signing in",
                style: TextStyle(
                  fontSize: isExtraLargeScreen ? 24 : 20,
                  fontFamily: "Poppins",
                  color: deepGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Single column layout for mobile devices
  Widget _buildMobileLayout(BuildContext context, Size screenSize) {
    final bool isSmallMobile = screenSize.width < 360;

    return SingleChildScrollView(
      child: Container(
        // Minimum height to fill the screen
        constraints: BoxConstraints(
          minHeight: screenSize.height - MediaQuery.of(context).padding.top,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10),
            // Top section with logo
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: isSmallMobile ? 15 : 20,
                    bottom: isSmallMobile ? 10 : 15,
                  ),
                  child: Center(
                    child: Text(
                      "Trendy Chef",
                      style: TextStyle(
                        fontSize: isSmallMobile ? 32 : 40,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                  ),
                ),
                // Added brand description for mobile layout
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.1,
                  ),
                  child: Text(
                    "Seamless Shopping Starts Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isSmallMobile ? 16 : 20,
                      fontFamily: "Poppins",
                      color: deepGreen,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              width: isSmallMobile ? 220 : 250,
              height: isSmallMobile ? 220 : 250,
              child: Lottie.asset("assets/lottie/auth.json"),
            ),

            // Middle section with auth buttons
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.1,
                vertical: isSmallMobile ? 30 : 40,
              ),
              child: Column(
                children: [
                  googleBtn(context),
                  SizedBox(height: 30),
                  appleBtn(),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
