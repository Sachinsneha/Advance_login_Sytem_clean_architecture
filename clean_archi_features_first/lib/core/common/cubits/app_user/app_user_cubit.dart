import 'package:bloc/bloc.dart';
import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:meta/meta.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(UserProfile? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else
      emit(
        AppUserLoggedIn(user: user),
      );
  }
}
