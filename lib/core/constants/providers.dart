import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shoppe/viewmodels/dashboard_viewmodel.dart';
import 'package:shoppe/viewmodels/edit_profile_viewmodel.dart';
import 'package:shoppe/viewmodels/onboarding_viewmodel.dart';
import 'package:shoppe/viewmodels/sigin_viewmodel.dart';
import 'package:shoppe/viewmodels/signup_viewmodel.dart';
import 'package:shoppe/viewmodels/user_profile_viewmodel.dart';
import 'package:shoppe/viewmodels/verify_otp_viewmodel.dart';

import '../../viewmodels/splash_viewmodel.dart';

class MyProviders {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(create: (_) => SplashViewModel()),
      ChangeNotifierProvider(create: (_) => OnBoardingViewModel()),
      ChangeNotifierProvider(create: (_) => SigninViewModel()),
      ChangeNotifierProvider(create: (_) => VerifyOtpViewModel()),
      ChangeNotifierProvider(create: (_) => SignupViewModel()),
      ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
      ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
    ];
  }
}
