import 'package:flutter/material.dart';
import 'package:trendychef/core/constants/colors.dart';

TextFormField searchField(TextEditingController searchController) {
  return TextFormField(
    controller: searchController,
    decoration: InputDecoration(
      fillColor: AppColors.secondary,
      filled: true,
      hintText: "Search",
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(Icons.search, size: 28, color: AppColors.primary),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(30),
      ),
      suffixIcon:
          searchController.text.isNotEmpty
              ? Container(
                width: 16,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.clear, color: AppColors.fontBlack, size: 15),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
              )
              : null,
    ),
  );
}
