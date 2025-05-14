import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';

Drawer sideDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: lightGreen,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: deepGreen),
            child: Text(
              'Trendy Chef',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Poppins",
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // close drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.white),
            title: Text('Favorites', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Favorites Page
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Navigate to Settings Page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }