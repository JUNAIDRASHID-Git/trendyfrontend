import 'package:flutter/material.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

TextFormField searchField(
  TextEditingController searchController,
  BuildContext context,
) {
  final lang = AppLocalizations.of(context)!;
  return TextFormField(
    controller: searchController,
    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      fillColor: AppColors.secondary,
      filled: true,
      label: Text(lang.search),
      labelStyle: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Icon(Icons.search, size: 28, color: AppColors.primary),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      suffixIcon:
          searchController.text.isNotEmpty
              ? Container(
                width: 16,
                margin:
                    lang.localeName == "en"
                        ? const EdgeInsets.only(right: 10)
                        : const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
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
