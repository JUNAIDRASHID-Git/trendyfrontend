import 'package:flutter/material.dart';

Container cartBtn(BuildContext context) {
  return Container(
    width: 50,
    height: 35,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(30),
        splashColor: const Color.fromARGB(255, 186, 186, 186),
        child: Center(child: Icon(Icons.shop)),
      ),
    ),
  );
}
