import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_event.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_state.dart';

Expanded cartCardBuilder(CartLoaded state) {
  return Expanded(
    child: ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F0), // Light green background
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Product Image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.productImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey.shade400,
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Product Name and Quantity Controls
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        item.productEName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Quantity Controls Row
                      Row(
                        children: [
                          // Decrease Button
                          InkWell(
                            onTap:
                                item.quantity > 1
                                    ? () {
                                      context.read<CartBloc>().add(
                                        UpdateCartQuantityEvent(
                                          productId: item.productId.toString(),
                                          quantity: item.quantity - 1,
                                        ),
                                      );
                                    }
                                    : null,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color:
                                    item.quantity > 1
                                        ? Colors.black54
                                        : Colors.grey.shade400,
                              ),
                            ),
                          ),

                          // Quantity Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Increase Button
                          InkWell(
                            onTap: () {
                              context.read<CartBloc>().add(
                                UpdateCartQuantityEvent(
                                  productId: item.productId.toString(),
                                  quantity: item.quantity + 1,
                                ),
                              );
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Price and Delete Button Column
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Delete Button
                    InkWell(
                      onTap: () {
                        context.read<CartBloc>().add(
                          DeleteCartItem(item.productId),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red.shade400,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Price
                    Row(
                      children: [
                        Image.asset("assets/images/riyal_logo.png", width: 16),
                        Text(
                          ' ${item.productSalePrice}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
