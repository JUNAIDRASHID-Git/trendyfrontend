import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_edit_dialog.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_row_info.dart';
import 'package:trendychef/core/services/data/models/user_model.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class ExpandableAddressRow extends StatefulWidget {
  final Address address;
  final String phone;

  const ExpandableAddressRow({
    super.key,
    required this.address,
    required this.phone,
  });

  @override
  State<ExpandableAddressRow> createState() => _ExpandableAddressRowState();
}

class _ExpandableAddressRowState extends State<ExpandableAddressRow> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final address = widget.address;
    final phone = widget.phone;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade100, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.deliveryAddress,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Text(
                        lang.tapToEditDeliveryInfo,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_outlined, color: Colors.blue.shade700),
                  onPressed: () => showEditDialog(context, address, phone),
                  tooltip: lang.editAddress,
                ),
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.blue.shade700,
                ),
              ],
            ),

            // Expanded Content
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (phone.isNotEmpty) ...[
                        buildAddressInfoRow(
                          icon: Icons.phone_outlined,
                          label: lang.phone,
                          value: phone,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 12),
                      ],
                      buildAddressInfoRow(
                        icon: Icons.home_outlined,
                        label: lang.address,
                        value: "${address.street}, ${address.city}",
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      buildAddressInfoRow(
                        icon: Icons.location_city_outlined,
                        label: lang.location,
                        value: "${address.state}, ${address.postalCode}",
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 8),
                      buildAddressInfoRow(
                        icon: Icons.public_outlined,
                        label: lang.country,
                        value: address.country,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
