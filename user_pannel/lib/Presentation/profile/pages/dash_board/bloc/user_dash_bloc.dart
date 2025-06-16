import 'package:bloc/bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_event.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_state.dart';
import 'package:trendychef/core/services/api/cart/get.dart';
import 'package:trendychef/core/services/api/user/get.dart';
import 'package:trendychef/core/services/api/user/put.dart';

class UserDashBloc extends Bloc<UserDashEvent, UserDashState> {
  UserDashBloc() : super(UserDashInitial()) {
    on<UserDashFetchEvent>((event, emit) async {
      emit(UserDashLoading());
      try {
        final user = await fetchUser();
        final items =
            await fetchCartItems();
        emit(UserDashLoaded(user: user, items: items));
      } catch (e) {
        emit(UserDashError(e.toString()));
      }
    });

    on<UserAddressEditEvent>((event, emit) async {
      if (state is UserDashLoaded) {
        emit(UserDashLoading());
        // Add your address edit logic here
        try {
          await updateUser(event.user);

          final updatedUser = await fetchUser();
          final items = await fetchCartItems();
          emit(UserDashLoaded(user: updatedUser, items: items));
        } catch (e) {
          emit(UserDashError(e.toString()));
        }
      }
    });
  }
}
