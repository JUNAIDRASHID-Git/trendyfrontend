import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/search_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Products"),),
      body: SafeArea(child: searchField()),
    );
  }
}
