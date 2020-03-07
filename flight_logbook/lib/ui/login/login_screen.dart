import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/login/login_bloc.dart';
import 'package:flightlogbook/bloc/login/login_repository.dart';
import 'package:flightlogbook/generated/i18n.dart';
import 'package:flightlogbook/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginBloc = LoginBloc(repository: FirebaseLoginRepository());
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    final S s = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s.login)),
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
              Future.delayed(const Duration(milliseconds: 100),
                  () => authBloc.add(LoggedIn()));
              return Container();
            } else if (state is LoginFailure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(s.login_failure),
                    ),
                    _buildLoginButton(loginBloc),
                  ],
                ),
              );
            }

            // state == LoginInitial
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildLoginButton(loginBloc),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  RaisedButton _buildLoginButton(LoginBloc loginBloc) => RaisedButton.icon(
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
      );
}
