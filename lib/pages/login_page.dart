import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/regex.dart';
import '../providers/auth_providers.dart';
import '../providers/common_providers.dart';
import '../shared/router.dart';
import '../shared/ui_helper.dart';
import '../widgets/app_button.dart';
import '../widgets/app_password_field.dart';
import '../widgets/app_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final StreamSubscription<ConnectivityResult> _subscription;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _subscription = Connectivity().onConnectivityChanged.listen((result) => UiHelper.showConnectivityStatus(context: context, result: result));
  }

  @override
  Widget build(BuildContext context) {
    // For login state
    ref.listen(authProvider, (_, next) {
      // If loading
      if (next.isLoading) return;

      // For error
      if (next.hasError) {
        UiHelper.showSnackbar(
          context: context,
          message: next.error.toString(),
          type: SnackbarType.error,
        );
      }
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          centerTitle: true,
          title: const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AppTextField(
                  name: 'email',
                  labelText: 'Email',
                  regex: Regex.email,
                ),
                Gaps.vGap15,
                const AppPasswordField(
                  name: 'password',
                  labelText: 'Password',
                ),
                Gaps.vGap60,
                Consumer(builder: (context, ref, _) {
                  final loginState = ref.watch(authProvider);

                  return AppButton(
                    labelText: 'LOGIN',
                    isLoading: loginState.isLoading,
                    onPressed: () {
                      // Return if not valid
                      if (!_formKey.currentState!.saveAndValidate()) return;

                      //If valid
                      ref.read(authProvider.notifier).login(values: _formKey.currentState!.value);
                    },
                  );
                }),
                Gaps.vGap5,
                TextButton(
                  onPressed: () {
                    ref.invalidate(passwordVisibilityProvider);

                    context.goNamed(AppRoute.signUp.name);
                  },
                  child: const Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                      color: AppColors.textColor1,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }
}
