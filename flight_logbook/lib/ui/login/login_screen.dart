import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/login/login_bloc.dart';
import 'package:flightlogbook/bloc/login/login_event.dart';
import 'package:flightlogbook/bloc/login/login_state.dart';
import 'package:flightlogbook/generated/l10n.dart';
import 'package:flightlogbook/repository/login/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authBloc = context.bloc();
    final S s = S.of(context);

    return BlocProvider(
      create: (_) => LoginBloc(repository: FirebaseLoginRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text(s.login)),
        body: Container(
          child: Builder(
            builder: (BuildContext context) =>
                BlocBuilder<LoginBloc, LoginState>(
              bloc: context.bloc(),
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
                        _buildLoginButton(context),
                      ],
                    ),
                  );
                }

                // state == LoginInitial
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildLoginButton(context),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  RaisedButton _buildLoginButton(BuildContext context) => RaisedButton.icon(
        icon: Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
        ),
        label: const Text(
          'Login with google',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
        onPressed: () =>
            context.bloc<LoginBloc>().add(LoginWithGoogleOnPressed()),
      );
}
