import 'package:clean_archi_features_first/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_archi_features_first/core/usecase/usecase.dart';
import 'package:clean_archi_features_first/core/entities/user_profile.dart';
import 'package:clean_archi_features_first/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:clean_archi_features_first/features/auth/domain/usecases/user_login_usecase.dart';
import 'package:clean_archi_features_first/features/auth/domain/usecases/user_singup_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSingupUsecase _userSingupUsecase;
  final UserLoginUsecase _userLoginUsecase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSingupUsecase userSingupUsecase,
    required UserLoginUsecase userLoginUsecase,
    required GetCurrentUserUsecase getCurrentUserUsecase,
    required AppUserCubit appUserCubit,
  })  : _userSingupUsecase = userSingupUsecase,
        _userLoginUsecase = userLoginUsecase,
        _getCurrentUserUsecase = getCurrentUserUsecase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(Authloading()));
    on<AuthSingUp>(_onSinupEvent);
    on<AuthLogIn>(_onLoginEvent);
    on<CurrentUserLogedIn>(_onCurrentUserLogedIn);
  }

  void _onCurrentUserLogedIn(
      CurrentUserLogedIn event, Emitter<AuthState> emit) async {
    final res = await _getCurrentUserUsecase(NoParams());
    res.fold(
      (l) => emit(AuthFaliure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onSinupEvent(AuthSingUp event, Emitter<AuthState> emit) async {
  

    final res = await _userSingupUsecase(
      UserSingupParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) {
        emit(AuthFaliure(failure.message)); // Emit the failure state
        // print('BLoC Failure: ${failure.message}'); // Log the failure
      },
      (user) => _emitAuthSuccess(user, emit),
      // print('BLoC Success: $user'); // Log the success
    );
  }

  void _onLoginEvent(AuthLogIn event, Emitter<AuthState> emit) async {
    final response = await _userLoginUsecase(UserLoginParams(
      email: event.email,
      password: event.password,
    ));
    response.fold(
      (l) => emit(AuthFaliure(l.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(UserProfile user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
