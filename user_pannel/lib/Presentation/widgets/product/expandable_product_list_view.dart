import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/checkout/bloc/check_out_bloc.dart';
import 'package:trendychef/core/constants/colors.dart';

class ExpandableProductList extends StatefulWidget {
  final CheckOutLoaded state;

  const ExpandableProductList({super.key, required this.state});

  @override
  State<ExpandableProductList> createState() => _ExpandableProductListState();
}

class _ExpandableProductListState extends State<ExpandableProductList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final items = widget.state.items;
    final visibleItemCount =
        _isExpanded ? items.length : (items.isNotEmpty ? 1 : items.length);
    final itemHeight = 112.0;
    final containerHeight = (visibleItemCount * itemHeight) + 60;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: containerHeight,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.fontWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            // Clip visible product cards only
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleItemCount,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.productImage,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey.shade100,
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productEName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildQuantityButton(
                                    context,
                                    Icons.remove,
                                    item.quantity > 1
                                        ? () =>
                                            _updateQuantity(context, item, -1)
                                        : null,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  _buildQuantityButton(
                                    context,
                                    Icons.add,
                                    () => _updateQuantity(context, item, 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Price
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/riyal_logo.png",
                              width: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${item.productSalePrice}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),

            Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
              color: AppColors.primary,
            ),
            if (_isExpanded == false) Text("${items.length - 1} More"),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Icon(
          icon,
          size: 16,
          color: onTap != null ? Colors.black54 : Colors.grey.shade400,
        ),
      ),
    );
  }

  void _updateQuantity(BuildContext context, item, int change) {
    context.read<CheckOutBloc>().add(
      CheckOutUpdateEvent(item.productId.toString(), item.quantity + change),
    );
  }
}
