import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shoppe/viewmodels/onboarding_viewmodel.dart';

import '../../viewmodels/splash_viewmodel.dart';

class MyProviders {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ChangeNotifierProvider(create: (_) => OnBoardingViewModel()),
    ];
  }
}
