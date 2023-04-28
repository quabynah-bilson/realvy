import 'package:flutter/material.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/actions.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/core/utils/session.dart';
import 'package:mobile/core/utils/validator.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({Key? key}) : super(key: key);

  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final _formKey = GlobalKey<FormState>(),
      _userTypeController = TextEditingController(),
      _phoneNumberController = TextEditingController(),
      _usernameController = TextEditingController(),
      _fullNameController = TextEditingController();
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    var isAgent = _userTypeController.text == context.localizer.agent;
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: LoadingIndicator(
        isLoading: _loading,
        message: context.localizer.authenticating,
        loadingAnimIsAsset: true,
        lottieAnimResource: Assets.animLoading,
        child: Form(
          key: _formKey,
          child: AnimatedListView(
            duration: 350,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            children: [
              SafeArea(
                bottom: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedColumn(
                        animateType: AnimateType.slideRight,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          context.localizer.createAccount.h5(context),
                          context.localizer.enterYourDetails.subtitle1(context),
                        ],
                      ),
                    ),
                    Assets.imgAppLogo
                        .asAssetImage(height: context.height * 0.05)
                        .centered(),
                  ],
                ).bottom(40),
              ),
              AppTextField(
                context.localizer.accountType,
                controller: _userTypeController,
                textFieldType: AppTextFieldType.select,
                enabled: !_loading,
                readOnly: true,
                validator: Validators.validate,
                onTap: () async {
                  var accountType =
                      await context.showAccountPickerBottomSheet();
                  if (accountType == null) return;
                  setState(() => _userTypeController.text = accountType);
                },
              ),
              AppTextField(
                context.localizer.fullName,
                controller: _fullNameController,
                enabled: !_loading,
                validator: Validators.validate,
                capitalization: TextCapitalization.words,
                prefixIcon: const Icon(TablerIcons.id_badge),
              ),
              AppTextField(
                context.localizer.username,
                controller: _usernameController,
                enabled: !_loading,
                validator: (input) => Validators.validateEmail(context, input),
                prefixIcon: const Icon(TablerIcons.mail),
              ),
              AppTextField(
                context.localizer.phoneNumber,
                controller: _phoneNumberController,
                enabled: !_loading,
                textFieldType: AppTextFieldType.phone,
                validator: (input) => Validators.validatePhone(context, input),
                prefixIcon: const Icon(TablerIcons.phone_plus),
                maxLength: 10,
              ),
              AppRoundedButton(
                      text: isAgent
                          ? context.localizer.next
                          : context.localizer.signUp,
                      backgroundColor: context.colorScheme.secondary,
                      textColor: context.colorScheme.onSecondary,
                      enabled: !_loading,
                      onTap: _validateAndSubmit)
                  .centered(),
              TextButton(
                onPressed: openTermsOfService,
                child: Text.rich(
                  TextSpan(
                    style: context.textTheme.labelLarge?.copyWith(
                        color: context.colorScheme.onSurface
                            .withOpacity(kEmphasisHigh)),
                    children: [
                      TextSpan(text: '${context.localizer.tos1} '),
                      TextSpan(
                          text: context.localizer.termsOfService,
                          style:
                              TextStyle(color: context.colorScheme.secondary)),
                      TextSpan(text: ' ${context.localizer.and} '),
                      TextSpan(
                          text: context.localizer.privacyPolicy,
                          style:
                              TextStyle(color: context.colorScheme.secondary)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ).top(24),
            ],
          ),
        ),
      ),
    );
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      var password =
          await context.showPasswordSetupSheet(_fullNameController.text);
      if (password == null) return;
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => _loading = false);
      UserSession.kIsAgent =
          _userTypeController.text == context.localizer.agent;
      context.navigator.pushNamed(AppRouter.phoneVerificationRoute, arguments: _phoneNumberController.text);
    }
  }
}
