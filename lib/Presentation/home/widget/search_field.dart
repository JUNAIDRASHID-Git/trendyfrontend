import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';

Padding searchField() {
    return Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  fillColor: lightGreen,
                  filled: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.search, size: 32, color: Colors.white),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            );
  }