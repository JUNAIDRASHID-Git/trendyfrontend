import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isPopular;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isPopular = false,
  });
}

class PaymentMethodSelector extends StatefulWidget {
  final Function(PaymentMethod) onMethodSelected;
  final PaymentMethod? selectedMethod;

  const PaymentMethodSelector({
    super.key,
    required this.onMethodSelected,
    this.selectedMethod,
  });

  @override
  State<PaymentMethodSelector> createState() => _PaymentMethodSelectorState();
}

class _PaymentMethodSelectorState extends State<PaymentMethodSelector> {
  PaymentMethod? _selectedMethod;

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: 'stc_pay',
      name: 'STC Pay',
      subtitle: 'أكثر الطرق استخداماً',
      icon: Icons.account_balance_wallet,
      color: const Color(0xFF6B46C1),
      isPopular: true,
    ),
    PaymentMethod(
      id: 'mada_pay',
      name: 'mada Pay',
      subtitle: 'الدفع بدون تلامس',
      icon: Icons.contactless,
      color: const Color(0xFF059669),
    ),
    PaymentMethod(
      id: 'mada_card',
      name: 'mada Card',
      subtitle: 'بطاقة مدى المصرفية',
      icon: Icons.credit_card,
      color: const Color(0xFFDC2626),
    ),
    PaymentMethod(
      id: 'apple_pay',
      name: 'Apple Pay',
      subtitle: 'دفع آمن وسريع',
      icon: Icons.apple,
      color: const Color(0xFF1F2937),
    ),
    PaymentMethod(
      id: 'mastercard',
      name: 'Mastercard',
      subtitle: 'بطاقة ائتمانية دولية',
      icon: Icons.credit_card_outlined,
      color: const Color(0xFFEB1C26),
    ),
    PaymentMethod(
      id: 'visa',
      name: 'Visa',
      subtitle: 'بطاقة ائتمانية دولية',
      icon: Icons.credit_card_outlined,
      color: const Color(0xFF1A1F71),
    ),
    PaymentMethod(
      id: 'sadad',
      name: 'SADAD',
      subtitle: 'خدمة الدفع الإلكتروني',
      icon: Icons.account_balance,
      color: const Color(0xFF0F766E),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.selectedMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.payment_rounded,
                      color: Colors.grey[700],
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'اختر طريقة الدفع',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose your preferred payment method',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Divider
          Divider(height: 1, color: Colors.grey[200]),

          // Payment methods list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: _paymentMethods.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final method = _paymentMethods[index];
              final isSelected = _selectedMethod?.id == method.id;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMethod = method;
                  });
                  widget.onMethodSelected(method);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? method.color.withOpacity(0.08)
                            : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? method.color : Colors.grey[200]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: method.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(method.icon, color: method.color, size: 24),
                      ),

                      const SizedBox(width: 16),

                      // Method info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  method.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                if (method.isPopular) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'الأكثر شيوعاً',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.orange[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              method.subtitle,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Radio button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isSelected ? method.color : Colors.grey[400]!,
                            width: 2,
                          ),
                          color: isSelected ? method.color : Colors.transparent,
                        ),
                        child:
                            isSelected
                                ? Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                                : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Usage Example
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentMethod? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('الدفع - Checkout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Order Summary (optional)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'المجموع الكلي - Total',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        '299.99 ر.س',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Payment Method Selector
            PaymentMethodSelector(
              selectedMethod: selectedPaymentMethod,
              onMethodSelected: (method) {
                setState(() {
                  selectedPaymentMethod = method;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${method.name}'),
                    backgroundColor: method.color,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Continue Button
            if (selectedPaymentMethod != null)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to payment processing
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedPaymentMethod!.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'متابعة الدفع - Continue Payment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
