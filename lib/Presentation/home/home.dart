import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/product_card.dart';
import 'package:trendychef/Presentation/search/page/search.dart';
import 'package:trendychef/core/services/api/product/fetch_products.dart';
import 'package:trendychef/core/services/data/models/product.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'widget/side_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    products = fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: deepGreen),
        title: Center(
          child: Text(
            "Trendy Chef",
            style: TextStyle(
              color: deepGreen,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: CircleAvatar(
                backgroundColor: lightGreen,
                radius: 18,
                child: Icon(Icons.search, size: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              // Horizontally scrollable product list
              SizedBox(
                height: 320,
                child: FutureBuilder<List<ProductModel>>(
                  future: products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No products found"));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return productCard(context, product);
                        },
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
