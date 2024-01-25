import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../constants/app_colors.dart';
import '../providers/common_providers.dart';

class AppPasswordField extends ConsumerWidget {
  final String name;
  final String labelText;

  const AppPasswordField({
    super.key,
    required this.name,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordVisibility = ref.watch(passwordVisibilityProvider);

    return SizedBox(
      width: double.infinity,
      child: FormBuilderTextField(
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: name,
        style: const TextStyle(color: AppColors.textColor1),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.bgColor2,
          border: const OutlineInputBorder(),
          focusColor: Colors.white70,
          labelText: labelText,
          labelStyle: const TextStyle(color: AppColors.textColor1),
          suffixIcon: IconButton(
            onPressed: () => ref.read(passwordVisibilityProvider.notifier).toggle(),
            icon: Icon(
              passwordVisibility ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: AppColors.textColor1,
            ),
          ),
        ),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        obscureText: !passwordVisibility,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(8),
          FormBuilderValidators.maxLength(20),
        ]),
      ),
    );
  }
}
