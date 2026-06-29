import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/config/env_config.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const DigiNewsApp());
}

class DigiNewsApp extends StatelessWidget {
  const DigiNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isProd = EnvConfig.isProduction;
    return MaterialApp.router(
      debugShowCheckedModeBanner: !isProd,
      title: isProd ? 'UTD - 20123021' : 'DEV - M Rifky',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: isProd
            ? ColorScheme.dark(
                primary: const Color(0xFF0D47A1),
                secondary: const Color(0xFF1565C0),
              )
            : ColorScheme.dark(
                primary: Colors.blueAccent,
                secondary: Colors.blue,
              ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
