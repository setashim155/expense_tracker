import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/app_colors.dart';
import '../constants/gaps.dart';
import '../constants/regex.dart';
import '../providers/auth_providers.dart';
import '../providers/common_providers.dart';
import '../shared/ui_helper.dart';
import '../widgets/app_button.dart';
import '../widgets/app_password_field.dart';
import '../widgets/app_text_field.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor1,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.textColor1,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              ref.invalidate(passwordVisibilityProvider);
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: const Text(
            'Sign Up',
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
    XFile? profileImage;

    return FormBuilder(
      key: _formKey,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Image
              InkWell(
                onTap: () => ref.read(imageNotifierProvider.notifier).pickImage(),
                child: Consumer(builder: (context, ref, _) {
                  profileImage = ref.watch(imageNotifierProvider);

                  return CircleAvatar(
                    backgroundColor: AppColors.buttonColor,
                    radius: 94,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: (profileImage == null ? const AssetImage('assets/images/user_default.png') : FileImage(File(profileImage!.path))) as ImageProvider,
                    ),
                  );
                }),
              ),
              Gaps.vGap30,
              AppTextField(
                name: 'fullName',
                labelText: 'Full Name',
                regex: Regex.name,
              ),
              Gaps.vGap15,
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
              Gaps.vGap40,
              Consumer(
                builder: (context, ref, _) {
                  final signUpState = ref.watch(authProvider);

                  return AppButton(
                    labelText: 'SIGN UP',
                    isLoading: signUpState.isLoading,
                    onPressed: () {
                      // For profile image validity
                      if (profileImage == null) {
                        UiHelper.showSnackbar(
                          context: context,
                          message: 'Provide a profile image.',
                          type: SnackbarType.error,
                        );

                        return;
                      }

                      // If fields are not valid
                      if (!_formKey.currentState!.saveAndValidate()) return;

                      // If everything is okay
                      ref.read(authProvider.notifier).signUp(
                            profileImage: profileImage!,
                            values: _formKey.currentState!.value,
                          );
                    },
                  );
                },
              ),
              Gaps.vGap5,
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Already have an account? Login',
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
    );
  }
}
