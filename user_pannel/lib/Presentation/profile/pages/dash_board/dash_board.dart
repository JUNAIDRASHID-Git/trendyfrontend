import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_event.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_state.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_row_container.dart';
import 'package:trendychef/core/services/data/models/user_model.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              UserDashBloc()..add(
                UserDashFetchEvent(
                  user: UserModel(
                    id: "123",
                    name: "John Doe",
                    phone: '',
                    address: Address(
                      street: "123 Main St",
                      city: "Springfield",
                      state: "IL",
                      postalCode: "62701",
                      country: "USA",
                    ),
                  ),
                ),
              ),
      child: BlocBuilder<UserDashBloc, UserDashState>(
        builder: (context, state) {
          if (state is UserDashLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDashLoaded) {
            final user = state.user;
            final address = user.address;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  ExpandableAddressRow(
                    address: address,
                    phone: state.user.phone ?? "",
                  ),
                  const SizedBox(height: 5),

                  _buildRow(
                    "Total Carted Products",
                    "${state.items.length}",
                    Colors.deepPurple,
                    Icons.shopping_cart,
                  ),
                  const SizedBox(height: 5),

                  _buildRow(
                    "Total Purchased",
                    "${state.totalPurchased.toStringAsFixed(2)} SAR",
                    Colors.green,
                    Icons.monetization_on,
                  ),
                ],
              ),
            );
          } else if (state is UserDashError) {
            return Center(child: Text("❌ ${state.message}"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildRow(
    String title,
    String value,
    Color valueColor,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: valueColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: valueColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Remove or implement buildAddressRow if needed.
}
