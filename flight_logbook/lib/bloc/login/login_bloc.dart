import 'package:flightlogbook/bloc/login/login_event.dart';
import 'package:flightlogbook/bloc/login/login_repository.dart';
import 'package:flightlogbook/bloc/login/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _repository;
  LoginBloc({
    @required LoginRepository repository,
  })  : assert(repository != null),
        _repository = repository;

  @override
  LoginState get initialState => LoginEmpty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGoogleOnPressed) {
      yield* _mapLoginWithGoogleOnPressedToState();
    }
  }

  Stream<LoginState> _mapLoginWithGoogleOnPressedToState() async* {
    yield LoginLoading();
    try {
      await _repository.loginWithGoogle();
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailure();
    }
  }
}
