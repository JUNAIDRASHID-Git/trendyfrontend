import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/home/widget/cards/product_card.dart';
import 'package:trendychef/Presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/core/services/data/models/product.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController;
  const SearchPage({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    // Trigger search every time SearchPage is rebuilt with a new value
    context.read<SearchBloc>().add(Searching(searchController.text));

    return Scaffold(
      appBar: AppBar(title: const Text("Search Products")),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial || state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No products found'));
            }
            return _buildProductGrid(context, state.products);
          } else if (state is SearchError) {
            return const Center(child: Text('No products found'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, List<ProductModel> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Fixed card dimensions
        const double cardWidth = 180.0;
        const double cardHeight = 290.0;
        const double spacing = 8.0;
        const double padding = 16.0;

        // Calculate number of columns based on screen width
        // Minimum 2 columns, maximum based on available space
        final availableWidth = constraints.maxWidth - (padding * 2);
        int crossAxisCount =
            ((availableWidth + spacing) / (cardWidth + spacing)).floor();
        crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

        return Padding(
          padding: const EdgeInsets.all(padding),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: cardWidth / cardHeight,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final ProductModel product = products[index];
              return SizedBox(
                width: cardWidth,
                height: cardHeight,
                child: productCard(context, product),
              );
            },
          ),
        );
      },
    );
  }
}
