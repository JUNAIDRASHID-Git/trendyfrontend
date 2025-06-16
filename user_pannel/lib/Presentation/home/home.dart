import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/cards/product_card.dart';
import 'package:trendychef/Presentation/widgets/sliders/auto_crousel_slider.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/api/product/get.dart';
import 'package:trendychef/core/services/data/models/category.dart';
import 'package:trendychef/core/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CategoryModel>> category;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    category = Future.delayed(
      const Duration(seconds: 1),
      () => getAllCategoryWithProducts(),
    ).then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CategoryModel>>(
        future: category,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      "assets/images/trendy_logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    width: 80, // Slightly larger than the image
                    height: 80,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary, // Customize color
                      ), // Customize color
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No categories found"));
          } else {
            final categoryList = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSlidingBanner(),
                  // Build category sections
                  ...categoryList.map(
                    (category) => _buildCategorySection(category),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategorySection(CategoryModel category) {
    // Check if category has products
    if (category.products == null || category.products!.isEmpty) {
      return const SizedBox.shrink(); // Don't show empty categories
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.fontWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  category.name?.toUpperCase() ?? "Category",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 2,
                        color: AppColors.fontBlack.withOpacity(0.2),
                      ),
                    ],
                    color: AppColors.primary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to category detail page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailPage(category: category)));
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: deepGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Product List
        SizedBox(
          height: 295, // Fixed height for horizontal list
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: category.products!.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = category.products![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: 200,
                    child: productCard(context, product),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20), // Space between categories
      ],
    );
  }
}
