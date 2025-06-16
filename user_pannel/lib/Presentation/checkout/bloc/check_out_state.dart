part of 'check_out_bloc.dart';

@immutable
sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutLoading extends CheckOutState {}

final class CheckOutLoaded extends CheckOutState {
  final List<CartItemModel> items;
  final UserModel user;
  final double totalAmount;
  final double totalKg;
  final double shippingCost;

  CheckOutLoaded(this.items, this.user)
    : totalAmount = items.fold(
        0,
        (sum, item) => sum + (item.productSalePrice * item.quantity),
      ),
      totalKg = items.fold(
        0,
        (sum, item) => sum + (item.weight * item.quantity),
      ),
      shippingCost = _calculateShippingCost(
        items.fold(0, (sum, item) => sum + (item.weight * item.quantity)),
      );

  static double _calculateShippingCost(double kg) {
    if (kg == 0) return 0;
    return ((kg / 30).ceil()) * 30;
  }
}

final class CheckOutError extends CheckOutState {
  final String message;

  CheckOutError(this.message);
}
