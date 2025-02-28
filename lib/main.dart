import 'package:callmebuddy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initialRoute = await Routes.initialRoute;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    print("Firebase initialized successfully");
  }).catchError((error) {
    print("Firebase initialization failed: $error");
  });

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
