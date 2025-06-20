import 'package:go_router/go_router.dart';
import 'package:shoppe/view/home/home_screen.dart';
import 'package:shoppe/view/onboarding/on_boarding_screen.dart';
import 'package:shoppe/view/signin/signin_screen.dart';
import 'package:shoppe/view/signup/signup_screen.dart';
import 'package:shoppe/view/splash/splash_screen.dart';
import 'package:shoppe/view/verify_otp/verify_otp_screen.dart';
import 'package:shoppe/view/welcome/welcome_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: "/splash",
      name: "splash",
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: "/home",
      name: "home",
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: "/onboarding",
      name: "onboarding",
      builder: (context, state) => OnBoardingScreen(),
    ),
    GoRoute(
      path: "/welcome",
      name: "welcome",
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      path: "/signin",
      name: "signin",
      builder: (context, state) => SigninScreen(),
    ),
    GoRoute(
      path: "/signup",
      name: "signup",
      builder: (context, state) => SignupScreen(),
    ),
    GoRoute(
      path: "/verify",
      name: "verify",
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return VerifyOtpScreen(
          verificationPlatfrom: args["verificationPlatfrom"],
          isEmailVerification: args["isEmailVerification"],
        );
      },
    ),
  ],
);
