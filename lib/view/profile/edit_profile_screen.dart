import 'package:provider/provider.dart';
import 'package:shoppe/core/constants/app_colors.dart';
import 'package:shoppe/core/package/package_export.dart';
import 'package:shoppe/core/package/utils.dart';
import 'package:shoppe/core/sharedpreferences/sharedpreferences.dart';
import 'package:shoppe/viewmodels/edit_profile_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EditProfileViewModel>().setupUserData();
    context.read<EditProfileViewModel>().changeValue(
      AppPreferences.getUserGender(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<EditProfileViewModel>();

    return DismissLoader(
      onBack: () => controller.resetAll(),
      child: Scaffold(
        backgroundColor: theme.canvasColor,
        body: CP(
          h: 16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizeH50(),
              text(text: AppStrings.edit_profile, fontSize: 45, fontWeight: 7),
              sizeH10(),
              text(text: AppStrings.edit_profile_title, fontSize: 18),
              sizeH10(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            sizeH25(),
                            Container(key: controller.group1),
                            // First name
                            textFormField(
                              context: context,
                              theme: theme,
                              controller: controller.firstNameCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup1,
                                  ),
                              hintText: AppStrings.firstName,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            // Last name
                            textFormField(
                              context: context,
                              theme: theme,
                              controller: controller.lastNameCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup1,
                                  ),
                              hintText: AppStrings.lastName,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            Container(key: controller.group2),
                            // Email
                            textFormField(
                              readOnly: true,
                              context: context,
                              theme: theme,
                              controller: controller.emailCtr,
                              textInputType: TextInputType.emailAddress,
                              funValidate:
                                  (val) => controller.validateEmail(val),
                              hintText: AppStrings.email,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            if (!AppPreferences.getIsEmailVerified())
                              Padding(
                                padding: EdgeInsets.only(top: 15, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap:
                                          () =>
                                              controller.onVerifyEmail(context),
                                      child: text(
                                        text: AppStrings.verify,
                                        fontSize: 18,
                                        textColor: AppColors.primaryColor,
                                        fontWeight: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            sizeH25(),
                            Container(key: controller.group3),
                            // Phone number
                            textFormField(
                              readOnly: true,
                              context: context,
                              theme: theme,
                              maxLength: 10,
                              controller: controller.phoneNumberCtr,
                              textInputType: TextInputType.number,
                              funValidate:
                                  (val) => controller.validatePhonenumber(val),
                              hintText: AppStrings.phone_number,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            if (!AppPreferences.getIsMobileVerified())
                              Padding(
                                padding: EdgeInsets.only(top: 15, right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.onVerifyMobile(context);
                                      },
                                      child: text(
                                        text: AppStrings.verify,
                                        fontSize: 18,
                                        textColor: AppColors.primaryColor,
                                        fontWeight: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            sizeH15(),
                            // Gender
                            Consumer(
                              builder: (context, value, child) {
                                return DropdownButtonFormField<String>(
                                  validator:
                                      (value) => controller
                                          .validateGenderSelected(value),
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: AppColors.primaryColor,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: getBorderColor(theme),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 20,
                                      left: 24,
                                      right: 10,
                                    ),
                                    errorStyle: const TextStyle(fontSize: 14),
                                    hintText: AppStrings.gender,
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700],
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: getBorderColor(theme),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: getBorderColor(theme),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: getBorderColor(theme),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: getBorderColor(theme),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: getBorderColor(theme),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  value: controller.selectedGender,
                                  items:
                                      controller.genders.map((String item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.changeValue(newValue);
                                  },
                                );
                              },
                            ),
                            sizeH25(),
                            Container(key: controller.group4),

                            // Country name
                            textFormField(
                              context: context,
                              theme: theme,
                              controller: controller.countryCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup4,
                                  ),
                              hintText: AppStrings.country,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            // State name
                            textFormField(
                              context: context,
                              theme: theme,
                              controller: controller.stateCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup4,
                                  ),
                              hintText: AppStrings.state,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            Container(key: controller.group5),
                            // City name
                            textFormField(
                              context: context,
                              theme: theme,
                              controller: controller.cityCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup5,
                                  ),
                              hintText: AppStrings.city,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            // Address
                            textFormField(
                              maxLines: 3,
                              context: context,
                              theme: theme,
                              controller: controller.addressCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup5,
                                  ),
                              hintText: AppStrings.address,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            Container(key: controller.group6),
                            // DOB
                            textFormField(
                              onTap: () => controller.pickDate(context),
                              readOnly: true,
                              context: context,
                              theme: theme,
                              controller: controller.dobCtr,
                              textInputType: TextInputType.text,
                              funValidate:
                                  (val) => controller.fieldIsRequired(
                                    val,
                                    controller.scrollToGroup6,
                                  ),
                              hintText: AppStrings.dob,
                              suffixIcon: Icon(
                                Icons.date_range,
                                color: AppColors.primaryColor,
                              ),
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                            sizeH25(),
                            // Pincode
                            textFormField(
                              context: context,
                              theme: theme,
                              maxLength: 6,
                              maxLines: 1,
                              onlyNumber: true,
                              controller: controller.pincodeCtr,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              funValidate:
                                  (val) => controller.validatePincode(val),
                              hintText: AppStrings.pin_code,
                              scrollPadding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).viewInsets.top +
                                    40.0,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                    20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              sizeH25(),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom == 0,
                child: Column(
                  children: [
                    simpleButton(
                      height: 55,
                      context,
                      onTap: () => controller.onUpdateClicked(context),
                      title: text(
                        text: AppStrings.update_profile,
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
      ),
    );
  }
}
