import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_strings.dart';
import 'package:shoppe/core/package/PackageConstants.dart';
import 'package:shoppe/core/package/text.dart';
import 'package:shoppe/core/package/text_form_field.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/viewmodels/sigin_viewmodel.dart';
import 'package:shoppe/widgets/dismiss_loader.dart';
import 'package:shoppe/widgets/fill_background.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SiginViewModel>();
    final theme = Theme.of(context);
    return DismissLoader(
      onBack: () => controller.resetAll(),
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: Stack(
          children: [
            FillBackground(),
            CP(
              h: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text(text: AppStrings.login, fontSize: 50, fontWeight: 7),
                  sizeH10(),
                  text(text: AppStrings.login_message, fontSize: 20),
                  sizeH50(),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        textFormField(
                          context: context,
                          theme: theme,
                          controller: controller.emailCtr,
                          textInputType: TextInputType.emailAddress,
                          funValidate: (val) => controller.validateEmail(val),
                          hintText: AppStrings.email,
                        ),
                        sizeH25(),
                        Consumer<SiginViewModel>(
                          builder: (context, value, child) {
                            return textFormField(
                              context: context,
                              theme: theme,
                              obsecureText: value.isObsecure,
                              maxLines: 1,
                              controller: controller.passCtr,
                              textInputType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              funValidate:
                                  (val) => controller.validatePassword(val),
                              hintText: AppStrings.password,
                              suffixIcon: iconButton(
                                onTap: () => controller.toggleObsecure(),
                                icon: Icon(
                                  value.isObsecure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  sizeH50(),
                  Visibility(
                    visible: MediaQuery.of(context).viewInsets.bottom == 0,
                    child: Column(
                      children: [
                        simpleButton(
                          height: 55,
                          context,
                          onTap: () => controller.onNext(context),
                          title: text(
                            text: AppStrings.next,
                            fontSize: 18,
                            textColor: Colors.white,
                          ),
                        ),
                        sizeH20(),
                        simpleButton(
                          backgroundColor: Colors.transparent,
                          height: 55,
                          context,
                          onTap: () => controller.onCancel(context),
                          title: text(
                            text: AppStrings.cancel,
                            fontSize: 18,
                            textColor: theme.shadowColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  sizeH20(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
