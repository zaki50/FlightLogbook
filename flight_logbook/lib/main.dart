import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/authentication/authentication_repository.dart';
import 'package:flightlogbook/bloc/authentication/authentication_state.dart';
import 'package:flightlogbook/pages.dart';
import 'package:flightlogbook/ui/add_flight/add_flight_screen.dart';
import 'package:flightlogbook/ui/flights/flights_screen.dart';
import 'package:flightlogbook/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final authenticationRepository = FirebaseAuthenticationRepository();
  runApp(
    BlocProvider.value(
      value: AuthenticationBloc(
        repository: authenticationRepository,
      )..add(AppStarted()),
      child: MyApp(),
    ),
  );
}

//const Color TRITON_BLUE = Color(0xff000099);
const int TRITON_BLUE = 0xff002596;
const int MOHICAN_BLUE = 0xff00A0DF;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: const MaterialColor(
          TRITON_BLUE,
          <int, Color>{
            50: Color(0xFFE3F2FD),
            100: Color(0xFFBBDEFB),
            200: Color(0xFF90CAF9),
            300: Color(0xFF64B5F6),
            400: Color(0xFF42A5F5),
            500: Color(TRITON_BLUE),
            600: Color(0xFF1E88E5),
            700: Color(0xFF1976D2),
            800: Color(0xFF1565C0),
            900: Color(0xFF0D47A1),
          },
        ),
        //primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: context.bloc(),
        builder: (context, state) {
          if (state is AuthenticationInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthenticationSuccess) {
            return FlightListScreen();
          } else if (state is AuthenticationFailure) {
            return LoginScreen();
          } else {
            return Container();
          }
        },
      ),
      routes: {
        Pages.ADD_FLIGHT: (_) => AddFlightScreen(),
      },
    );
  }
}
