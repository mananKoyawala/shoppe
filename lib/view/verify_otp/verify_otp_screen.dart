import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/verify_otp_viewmodel.dart';
import 'package:shoppe/widgets/fill_background_secondary.dart';

import '../../core/package/package_export.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({
    super.key,
    required this.isEmailVerification,
    required this.verificationPlatfrom,
  });

  final bool isEmailVerification;
  final String verificationPlatfrom;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  Timer? _timer;
  int _start = 90;

  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void cancelTimer() {
    _timer!.cancel();
  }

  timer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // email or mobile
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.read<VerifyOtpViewModel>();
    return DismissLoader(
      onBack: () => controller.resetAll(),
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: Stack(
          children: [
            FillBackgroundSecondary(),
            CP(
              h: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizeH(getScreenHeight(context) * .25),
                  text(
                    text: AppStrings.verify_otp,
                    fontSize: 40,
                    fontWeight: 7,
                  ),
                  sizeH10(),
                  text(
                    text: controller.getFormattedOTPSent(
                      widget.isEmailVerification,
                      widget.verificationPlatfrom,
                    ),
                    fontSize: 16,
                  ),
                  sizeH50(),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        textFormField(
                          context: context,
                          theme: theme,
                          controller: controller.otpCtr,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          funValidate: (val) => controller.validateEmail(val),
                          onlyNumber: true,
                          maxLength: 6,
                          hintText: AppStrings.enter_otp,
                        ),
                        // sizeH25(),
                      ],
                    ),
                  ),
                  _start > 0
                      ? Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.alarm),
                            sizeW(5),
                            text(
                              text: formatTime(_start),
                              fontSize: 17,
                              textColor: AppColors.primaryColor,
                              fontWeight: 5,
                            ),
                          ],
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          text(
                            text: AppStrings.otp_not_received,
                            fontSize: 16,
                            textColor: theme.shadowColor,
                          ),
                          simpleButton(
                            width: 70,
                            context,
                            onTap: () {
                              setState(() {
                                _start = 90;
                              });
                              timer();
                              controller.onResendOTP(
                                widget.verificationPlatfrom,
                              );
                            },
                            backgroundColor: Colors.transparent,
                            title: text(
                              text: "Resend",
                              fontSize: 16,
                              textColor: AppColors.primaryColor,
                              fontWeight: 5,
                            ),
                          ),
                        ],
                      ),
                  Expanded(child: Container()),
                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: simpleButton(
                      height: 55,
                      context,
                      onTap:
                          () => controller.onContinue(
                            context,
                            widget.isEmailVerification,
                            widget.verificationPlatfrom,
                          ),
                      title: text(
                        text: AppStrings.verify_otp,
                        fontSize: 18,
                        textColor: Colors.white,
                      ),
                    ),
                  ),

                  sizeH40(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
