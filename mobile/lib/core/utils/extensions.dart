import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/utils/validator.dart';
import 'package:mobile/generated/assets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_utils/shared_utils.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get localizer => AppLocalizations.of(this)!;

  void showFeatureUnderDevSheet() async {
    showBarModalBottomSheet(
      context: this,
      backgroundColor: colorScheme.background,
      useRootNavigator: true,
      bounce: true,
      builder: (context) => AnimatedColumn(
        animateType: AnimateType.slideUp,
        children: [
          Lottie.asset(Assets.animRealEstate,
                  frameRate: FrameRate(90),
                  height: height * 0.25,
                  width: width * 0.7)
              .bottom(24),
          EmptyContentPlaceholder(
              title: localizer.underMaintenanceHeader,
              subtitle: localizer.underMaintenanceSubhead),
          SafeArea(
            top: false,
            child: AppRoundedButton(
                    backgroundColor: colorScheme.secondary,
                    text: localizer.gotIt,
                    onTap: context.navigator.pop)
                .top(40),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showLoginWithEmailSheet() async {
    final formKey = GlobalKey<FormState>(),
        emailAddressController = TextEditingController(),
        passwordController = TextEditingController();

    var loading = false;
    return await showBarModalBottomSheet(
      context: this,
      backgroundColor: colorScheme.background,
      useRootNavigator: true,
      bounce: true,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => LoadingIndicator(
                isLoading: loading,
                message: localizer.authenticating,
                loadingAnimIsAsset: true,
                lottieAnimResource: Assets.animLoading,
                child: Form(
                  key: formKey,
                  child: AnimatedListView(
                    padding: const EdgeInsets.only(top: 24),
                    animateType: AnimateType.slideUp,
                    children: [
                      Assets.imgAppLogo
                          .asAssetImage(height: context.height * 0.1)
                          .centered(),
                      localizer.appName
                          .h5(this,
                              color: colorScheme.onSurface,
                              alignment: TextAlign.center)
                          .centered()
                          .top(16),
                      localizer.signInWithEmail
                          .subtitle1(context)
                          .centered()
                          .bottom(24),
                      AppTextField(
                        localizer.username,
                        enabled: !loading,
                        controller: emailAddressController,
                        inputType: TextInputType.emailAddress,
                        validator: (input) =>
                            Validators.validateEmail(context, input),
                        onChange: (input) {
                          if (input == null) return;
                        },
                        floatLabel: true,
                        prefixIcon: const Icon(TablerIcons.mail),
                      ),
                      AppTextField(
                        localizer.password,
                        enabled: !loading,
                        controller: passwordController,
                        textFieldType: AppTextFieldType.password,
                        validator: (input) =>
                            Validators.validatePassword(context, input),
                        onChange: (input) {
                          if (input == null) return;
                        },
                        floatLabel: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      SafeArea(
                        top: false,
                        child: AppRoundedButton(
                          backgroundColor: colorScheme.secondary,
                          text: localizer.gotIt,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              // TODO login with email
                              Timer(const Duration(seconds: 2), () {
                                setState(() => loading = false);
                                context.navigator.pop(true);
                              });
                            }
                          },
                        ).centered().top(40),
                      ),
                    ],
                  ).horizontal(24),
                ),
              )),
    );
  }

  Future<String?> showPasswordSetupSheet(String fullName) async {
    final formKey = GlobalKey<FormState>(),
        confirmPasswordController = TextEditingController(),
        passwordController = TextEditingController();

    return await showBarModalBottomSheet(
      context: this,
      backgroundColor: colorScheme.background,
      useRootNavigator: true,
      bounce: true,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => Form(
                key: formKey,
                child: AnimatedListView(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  animateType: AnimateType.slideUp,
                  children: [
                    Assets.imgAppLogo.asAssetImage(
                        height: height * 0.15, fit: BoxFit.contain),
                    localizer
                        .greetUser(fullName)
                        .h5(this,
                            weight: FontWeight.bold,
                            color: colorScheme.onSurface,
                            alignment: TextAlign.center)
                        .centered()
                        .bottom(8),
                    localizer.createYourPassword
                        .subtitle1(context)
                        .centered()
                        .bottom(24),
                    AppTextField(
                      localizer.password,
                      controller: passwordController,
                      textFieldType: AppTextFieldType.password,
                      validator: (input) =>
                          Validators.validatePassword(context, input),
                      onChange: (input) {
                        if (input == null) return;
                      },
                      floatLabel: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    AppTextField(
                      localizer.confirmPassword,
                      controller: confirmPasswordController,
                      textFieldType: AppTextFieldType.password,
                      validator: (input) => Validators.validatePassword(
                          context, input, passwordController.text),
                      onChange: (input) {
                        if (input == null) return;
                      },
                      floatLabel: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    SafeArea(
                      top: false,
                      child: AppRoundedButton(
                        backgroundColor: colorScheme.secondary,
                        text: localizer.gotIt,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.navigator.pop(passwordController.text);
                          }
                        },
                      ).centered().top(40),
                    ),
                  ],
                ),
              )),
    );
  }

  /// show new update dialog
  /*void showUpdateAppDialog(AppVersion appVersion) async {
    if (appVersion.version == getIt<String>(instanceName: 'app_version')) {
      return;
    }
    await showBarModalBottomSheet(
      context: this,
      backgroundColor: colorScheme.background,
      useRootNavigator: true,
      bounce: true,
      isDismissible: false,
      builder: (context) => AnimatedColumn(
        animateType: AnimateType.slideDown,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Lottie.asset(Assets.animUpdateAvailable)),
              Icon(Icons.arrow_right_alt,
                  color: colorScheme.onSurface, size: 40),
              Expanded(child: Assets.imgAppLogoAnimated.asAssetImage()),
            ],
          ).fillMaxHeight(context, 0.2).horizontal(40).bottom(24),
          EmptyContentPlaceholder(
              title: localizer.updateAvailableHeader(appVersion.version),
              subtitle: localizer.updateAvailableSubhead),
          AppRoundedButton(
            text: localizer.okay,
            onTap: () => _showInAppBrowser(
                Platform.isAndroid ? appVersion.androidUrl : appVersion.iosUrl),
          ).top(40),
          SafeArea(
            top: false,
            child: TextButton(
              onPressed: context.navigator.pop,
              child: localizer.updateLater
                  .button(context, alignment: TextAlign.center),
            ).top(8),
          ),
        ],
      ),
    );
  }*/

  /// used for custom error messages / prompts
  void showMessageDialog(
    String message, {
    bool showAsError = true,
    String? title,
    String? actionLabel,
    String? animationAsset,
    VoidCallback? onTap,
  }) async {
    showBarModalBottomSheet(
      context: this,
      backgroundColor: colorScheme.background,
      useRootNavigator: true,
      isDismissible: showAsError,
      enableDrag: false,
      bounce: true,
      builder: (context) => AnimatedColumn(
        animateType: AnimateType.slideRight,
        children: [
          Lottie.asset(
                  animationAsset ??
                      (showAsError ? Assets.animError : Assets.animSuccess),
                  frameRate: FrameRate(90),
                  repeat: false,
                  height: height * 0.1,
                  width: width * 0.7)
              .bottom(24),
          EmptyContentPlaceholder(
              title: title ?? localizer.errorHeader, subtitle: message),
          SafeArea(
            top: false,
            child: AppRoundedButton(
              text: actionLabel ?? localizer.okay,
              onTap: () {
                context.navigator.pop();
                onTap?.call();
              },
            ).top(40),
          ),
        ],
      ).top(24),
    );
  }

  /// show a list of locales supported by the app
  Future<String?> showLocalesSheet() async {
    var locales = [localizer.english, localizer.french];
    return await showBarModalBottomSheet(
      context: this,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SafeArea(
          top: false,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            children: [
              localizer.changeLanguageHeader.subtitle1(context).bottom(16),
              ...locales
                  .map(
                    (e) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () => context.navigator
                          .pop(e == locales.first ? 'en' : 'fr'),
                      minLeadingWidth: 48,
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color:
                              (context.colorScheme.secondary).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          TablerIcons.language,
                          color: context.colorScheme.secondary,
                        ),
                      ),
                      title: Text(e),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  /// show a list of account types supported by the app
  Future<String?> showAccountPickerBottomSheet() async {
    var locales = [localizer.individual, localizer.agent];
    return await showBarModalBottomSheet(
      context: this,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SafeArea(
          top: false,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            children: [
              localizer.accountType.subtitle1(context).bottom(16),
              ...locales
                  .map(
                    (e) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () => context.navigator.pop(e),
                      minLeadingWidth: 48,
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color:
                              (context.colorScheme.secondary).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          TablerIcons.user_exclamation,
                          color: context.colorScheme.secondary,
                        ),
                      ),
                      title: Text(e),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
