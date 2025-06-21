import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/cards/product_card.dart';
import 'package:trendychef/Presentation/widgets/sliders/auto_crousel_slider.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/api/product/get.dart';
import 'package:trendychef/core/services/data/models/category.dart';
import 'package:trendychef/l10n/app_localizations.dart';

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
    // Delayed future: you can remove Future.delayed if unnecessary
    category = Future.delayed(
      const Duration(seconds: 1),
      () => getAllCategoryWithProducts(),
    );
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
                        AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final categoryList = snapshot.data!;
            if (categoryList.isEmpty) {
              return const Center(child: Text("No categories found"));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AutoSlidingBanner(),
                  ),
                  // Build category sections
                  ...categoryList.map(
                    (category) => _buildCategorySection(category),
                  ),
                ],
              ),
            );
          } else {
            // Handles snapshot.hasData == false and no error state
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }

  Widget _buildCategorySection(CategoryModel category) {
    // If products is null or empty, return empty widget
    final lang = AppLocalizations.of(context)!;
    final products = category.products ?? [];
    if (products.isEmpty) {
      return const SizedBox.shrink();
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
              Text(
                (category.name ?? "Category").toUpperCase(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                  letterSpacing: 1,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      color: AppColors.fontBlack.withOpacity(0.2),
                    ),
                  ],
                  color: AppColors.primary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement navigation to category detail page
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetailPage(category: category)));
                },
                child: Text(
                  lang.viewAll,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Horizontal Product List
        SizedBox(
          height: 295,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown,
              },
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];
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

        const SizedBox(height: 20),
      ],
    );
  }
}
