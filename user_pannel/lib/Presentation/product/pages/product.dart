import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/product/widgets/image_container.dart';
import 'package:trendychef/Presentation/product/widgets/price_container.dart';
import 'package:trendychef/Presentation/product/widgets/product_details_container.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/core/services/data/models/product.dart';

class Productpage extends StatelessWidget {
  final ProductModel product;
  const Productpage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (isWide)
                    // For tablets or wide screens: Row layout
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: productImageContainer(
                              imageUrl: product.image,
                              kg: product.weight,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              productDetailsContainer(
                                title: product.eName,
                                subTitle: product.eDescription ?? "",
                              ),
                              SizedBox(height: 10),
                              priceContainer(
                                salePrice: product.salePrice,
                                regularPrice: product.regularPrice,
                                productID: product.id.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    // For mobile: Column layout
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: productImageContainer(
                            imageUrl: product.image,
                            kg: product.weight,
                          ),
                        ),
                        const SizedBox(height: 20),
                        productDetailsContainer(
                          title: product.eName,
                          subTitle: product.eDescription ?? "",
                        ),
                        SizedBox(height: 10),
                        priceContainer(
                          salePrice: product.salePrice,
                          regularPrice: product.regularPrice,
                          productID: product.id.toString(),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
