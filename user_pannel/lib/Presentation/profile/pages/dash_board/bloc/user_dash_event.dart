import 'package:trendychef/core/services/data/models/user_model.dart';

class UserDashEvent {}


class UserDashFetchEvent extends UserDashEvent {
  final UserModel user;

  UserDashFetchEvent({required this.user});
}

class UserAddressEditEvent extends UserDashEvent {
  final UserModel user;

  UserAddressEditEvent({required this.user});
}
