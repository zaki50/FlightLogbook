import 'package:flightlogbook/bloc/settings/settings_bloc.dart';
import 'package:flightlogbook/bloc/settings/settings_event.dart';
import 'package:flightlogbook/bloc/settings/settings_state.dart';
import 'package:flightlogbook/generated/l10n.dart';
import 'package:flightlogbook/repository/settings/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prefs_config/prefs_config.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final S s = S.of(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      bloc: context.bloc(),
      builder: (context, state) {
        if (state is LoadingSettings) {
          return Scaffold(
            appBar: AppBar(title: Text(s.settings)),
            body: Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (state is LoadSettingsSuccess) {
          return _buildSettingsList(context, s, state.settings);
        } else if (state is LoadSettingsFailure) {
          return Scaffold(
            appBar: AppBar(title: Text(s.settings)),
            body: Container(
              child: const Center(
                child: Text('設定を読み込めませんでした。'),
              ),
            ),
          );
        }

        // state == SettingsInitial
        final SettingsBloc bloc = context.bloc();
        bloc.add(LoadAllSettings());
        return Container();
      },
    );
  }

  Widget _buildSettingsList(
    BuildContext context,
    S s,
    Map<String, Object> settings,
  ) {
    final p = Prefs(preferences: <Pref>[
      Pref(
        prefKey: SettingsRepository.KEY_COLOR_SCHEME,
        type: Pref.TYPE_LIST,
        defVal: 0,
        label: s.settingLabel_colorScheme,
        description: "This is a Text Setting",
        listItems: {
          SettingsRepository.VALUE_COLOR_SCHEME_ANA:
              s.settingValue_colorScheme_ana,
          SettingsRepository.VALUE_COLOR_SCHEME_JAL:
              s.settingValue_colorScheme_jal,
        },
      ),
    ]);

    return PreferenceContainer(preferences: p.preferences, title: s.settings);
  }
}
