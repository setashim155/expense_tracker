import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../constants/app_colors.dart';

class AppDropdown extends StatelessWidget {
  final String name;
  final String labelText;
  final dynamic initialValue;
  final List<dynamic> options;
  final bool isRequired;
  final void Function(dynamic)? onItemSelected;

  const AppDropdown({
    super.key,
    required this.name,
    required this.labelText,
    this.initialValue,
    required this.options,
    this.isRequired = true,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown(
      name: name,
      initialValue: initialValue,
      style: const TextStyle(
        color: AppColors.textColor1,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.bgColor2,
        border: const OutlineInputBorder(),
        focusColor: Colors.white70,
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.textColor1),
      ),
      dropdownColor: AppColors.bgColor1,
      items: options
          .map((option) => DropdownMenuItem(
                value: option,
                onTap: () {
                  if (onItemSelected != null) onItemSelected!(option);
                },
                child: Text(option is String ? option : option.text),
              ))
          .toList(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        if (isRequired) FormBuilderValidators.required(),
      ]),
    );
  }
}
