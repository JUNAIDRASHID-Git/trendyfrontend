import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_event.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_state.dart';
import 'package:trendychef/core/constants/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

Expanded cartCardBuilder(CartLoaded state, BuildContext context) {
  final lang = AppLocalizations.of(context)!;
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
                        lang.localeName == "en"
                            ? item.productEName
                            : item.productArName,
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
                        showDialog(
                          context: context,
                          barrierDismissible:
                              false, // Prevent dismissing by tapping outside
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: Row(
                                children: [
                                  const Text('🛒 Remove Item'),
                                  const Spacer(),
                                  // Animated sad emoji
                                  TweenAnimationBuilder<double>(
                                    duration: const Duration(seconds: 1),
                                    tween: Tween(begin: 0.5, end: 1.0),
                                    builder: (context, scale, child) {
                                      return Transform.scale(
                                        scale: scale,
                                        child: const Text(
                                          '😢',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Are you sure you want to remove this item from your cart?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.red.shade200,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Text(
                                          '⚠️',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(width: 8),
                                        const Expanded(
                                          child: Text(
                                            'This action cannot be undone',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              actionsPadding: const EdgeInsets.all(16),
                              actions: <Widget>[
                                // Cancel Button
                                TextButton.icon(
                                  icon: const Text(
                                    '😊',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  label: const Text(
                                    'Keep It',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                    // Optional: Show a brief snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          '😄 Great choice! Item kept in cart',
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                // Delete Button
                                ElevatedButton.icon(
                                  icon: const Text(
                                    '💔',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  label: const Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.fontWhite,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    elevation: 2,
                                  ),
                                  onPressed: () {
                                    // Add the delete action
                                    context.read<CartBloc>().add(
                                      DeleteCartItem(item.productId),
                                    );
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                              ],
                            );
                          },
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
