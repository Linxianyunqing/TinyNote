import 'package:flutter/material.dart';

import 'home.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures the application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the `SettingsController` to the `MaterialApp`.
    //
    // The `ListenableBuilder` Widget listens to the `SettingsController` for
    // changes. Whenever the user updates their settings, the `MaterialApp` is
    // rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // Providing a `restorationScopeId` allows the Navigator built by the
          // `MaterialApp` to restore the navigation stack when a user leaves
          // and returns to the app after it has been killed while running in
          // the background.
          restorationScopeId: 'app',

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // `SettingsController` to display the correct theme.
          theme: ThemeData(
            colorSchemeSeed: settingsController.colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: settingsController.colorSelected.color,
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case Home.routeName:
                  default:
                    return const Home();
                }
              },
            );
          },
        );
      },
    );
  }
}
