import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/providers.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/router/routes.dart';
import 'package:shoppe/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  AppPreferences.preference();
  runApp(
    MultiProvider(providers: MyProviders.getProviders(), child: const Shoppe()),
  );
}

class Shoppe extends StatelessWidget {
  const Shoppe({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: true,
        routerConfig: router,
        themeMode: ThemeMode.light,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        builder: EasyLoading.init(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
