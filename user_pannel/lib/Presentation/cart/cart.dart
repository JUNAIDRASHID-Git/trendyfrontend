import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_event.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_state.dart';
import 'package:trendychef/Presentation/cart/widgets/cart_card_builder.dart';
import 'package:trendychef/Presentation/cart/widgets/check_out_btn.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => CartBloc()..add(LoadCartItems()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return Column(
                children: [
                  cartCardBuilder(state),
                  CheckoutButton(state: state),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
