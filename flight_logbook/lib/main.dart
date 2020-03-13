import 'package:flightlogbook/bloc/authentication/authentication_bloc.dart';
import 'package:flightlogbook/bloc/authentication/authentication_event.dart';
import 'package:flightlogbook/bloc/authentication/authentication_state.dart';
import 'package:flightlogbook/bloc/settings/settings_bloc.dart';
import 'package:flightlogbook/bloc/settings/settings_event.dart';
import 'package:flightlogbook/bloc/settings/settings_state.dart';
import 'package:flightlogbook/pages.dart';
import 'package:flightlogbook/repository/authentication/authentication_repository.dart';
import 'package:flightlogbook/repository/settings/settings_repository.dart';
import 'package:flightlogbook/ui/add_flight/add_flight_screen.dart';
import 'package:flightlogbook/ui/flights/flights_screen.dart';
import 'package:flightlogbook/ui/login/login_screen.dart';
import 'package:flightlogbook/ui/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: AuthenticationBloc(
            repository: FirebaseAuthenticationRepository(),
          )..add(AppStarted()),
        ),
        BlocProvider.value(
          value: SettingsBloc(
            repository: SharedPrefSettingsRepository(),
          )..add(LoadAllSettings()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

//const Color TRITON_BLUE = Color(0xff000099);
const int TRITON_BLUE = 0xff002596;
const int MOHICAN_BLUE = 0xff00A0DF;

const ANA_COLOR = const MaterialColor(
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
);

// from https://www.jal.co.jp/jalcard/service/img/agora/brand.pdf
const JAL_RED = 0xffc80019;
const JAL_SILVER = 0xffc8c8c8;
const JAL_COLOR = const MaterialColor(
  JAL_RED,
  <int, Color>{
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(JAL_RED),
    600: Color(0xFFE53935),
    700: Color(0xFFD32F2F),
    800: Color(0xFFC62828),
    900: Color(0xFFB71C1C),
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: BlocProvider.of(context),
      condition: (previous, current) =>
          current is LoadSettingsSuccess || current is UpdateSettingSuccess,
      builder: (BuildContext context, SettingsState state) {
        int colorScheme = SettingsRepository.DEFAULT_VALUE_COLOR_SCHEME;
        if (state is LoadSettingsSuccess) {
          colorScheme = state.settings[SettingsRepository.KEY_COLOR_SCHEME];
        } else if (state is UpdateSettingSuccess) {
          colorScheme = state.settings[SettingsRepository.KEY_COLOR_SCHEME];
        }

        return MaterialApp(
          title: 'Flight Logbook',
          theme: ThemeData(
            primarySwatch:
                colorScheme == SettingsRepository.VALUE_COLOR_SCHEME_JAL
                    ? JAL_COLOR
                    : ANA_COLOR,
            accentColor:
                colorScheme == SettingsRepository.VALUE_COLOR_SCHEME_JAL
                    ? const Color(JAL_RED)
                    : const Color(MOHICAN_BLUE),
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
            Pages.SETTINGS: (_) => BlocProvider(
                create: (_) =>
                    SettingsBloc(repository: SharedPrefSettingsRepository()),
                child: SettingsScreen()),
          },
        );
      },
    );
  }
}
