import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/core/config/theme/typography.dart';
import 'package:pet_adoption_assignment/features/settings/presentation/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: 'Settings'.h2(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: 'Change Theme'.text16Regular(),
            subtitle: themeSubtitle(context).text14Regular(),
            trailing: Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (bool value) {
                context.read<SettingsCubit>().changeTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String themeSubtitle(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark ? 'Dark' : 'Light';
}
