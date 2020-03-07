import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/login/login_bloc.dart';
import 'package:flightlogbook/bloc/login/login_event.dart';
import 'package:flightlogbook/bloc/login/login_repository.dart';
import 'package:flightlogbook/bloc/login/login_state.dart';
import 'package:flightlogbook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final _appBar = AppBar(title: const Text('Login'));

  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc(repository: FirebaseLoginRepository());
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: _appBar,
      body: Container(
        color: const Color(MOHICAN_BLUE),
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoginSuccess) {
              Future.delayed(const Duration(milliseconds: 10),
                  () => authBloc.add(LoggedIn()));
              return Container();
            } else if (state is LoginFailure) {
              return const Center(
                child: Text('Failure'),
              );
            }

            // state == LoginInitial
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Login with google',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(TRITON_BLUE),
                    onPressed: () => loginBloc.add(LoginWithGoogleOnPressed()),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
