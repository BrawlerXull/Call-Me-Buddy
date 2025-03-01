import 'package:callmebuddy/firebase_options.dart';
import 'package:callmebuddy/infrastructure/navigation/bindings/controllers/initial_bindings.dart';
import 'package:callmebuddy/infrastructure/theme/shad_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    if (kDebugMode) {
      print("✅ Firebase initialized successfully");
    }
  }).catchError((error) {
    if (kDebugMode) {
      print("❌ Firebase initialization failed: $error");
    }
  });

  String initialRoute = await Routes.getInitialRoute();

  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      theme: ShadAppTheme.lightTheme,
      darkTheme: ShadAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      appBuilder: (context, theme) => GetMaterialApp(
        theme: theme,
        getPages: Nav.routes,
        initialRoute: initialRoute,
        initialBinding: InitialBinding(),
        builder: (context, child) {
          return ShadToaster(child: child!);
        },
      ),
    );
  }
}
