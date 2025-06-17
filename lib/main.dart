import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/providers.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/router/routes.dart';
import 'package:shoppe/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppPreferences.preference();
  runApp(
    MultiProvider(providers: MyProviders.getProviders(), child: const Shoppe()),
  );
}

class Shoppe extends StatelessWidget {
  const Shoppe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      routerConfig: router,
      theme: lightTheme(),
      darkTheme: darkTheme(),
    );
  }
}
