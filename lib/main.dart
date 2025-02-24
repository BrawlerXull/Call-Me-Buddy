import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = await Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: ShadColorScheme.fromName(
          'green',
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ShadThemeData(
        colorScheme: ShadColorScheme.fromName(
          'slate',
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      appBuilder: (context, theme) => GetMaterialApp(
        theme: theme,
        getPages: Nav.routes,
        initialRoute: initialRoute,
        builder: (context, child) {
          return ShadToaster(child: child!);
        },
      ),
    );
  }
}
