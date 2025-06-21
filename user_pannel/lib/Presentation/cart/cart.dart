import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          child: LottieBuilder.asset(
                            "assets/lottie/empty_cart.json",
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Animated cart emoji
                            TweenAnimationBuilder<double>(
                              duration: const Duration(seconds: 2),
                              tween: Tween(begin: 0.8, end: 1.2),
                              builder: (context, scale, child) {
                                return Transform.scale(
                                  scale: scale > 1.0 ? 2.0 - scale : scale,
                                  child: const Text(
                                    '🛒',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(width: 12),

                            // Main text with styling
                            const Text(
                              'Your Cart Is Empty',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                letterSpacing: 0.5,
                              ),
                            ),

                            const SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  cartCardBuilder(state,context),
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
