import 'package:expense_tracker/providers/common_providers.dart';
import 'package:expense_tracker/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../constants/app_colors.dart';

class AppDatePicker extends ConsumerStatefulWidget {
  final String name;
  final String labelText;
  final String? initialValue;
  final bool isRequired;

  const AppDatePicker({
    super.key,
    required this.name,
    required this.labelText,
    this.initialValue,
    this.isRequired = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends ConsumerState<AppDatePicker> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();

    textController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(editStatusProvider(id: widget.name));

    return SizedBox(
      width: double.infinity,
      child: FormBuilderTextField(
        name: widget.name,
        controller: textController,
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: AppColors.textColor1),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.bgColor2,
          prefixIcon: const Icon(
            Icons.calendar_month_rounded,
            color: AppColors.textColor2,
          ),
          border: const OutlineInputBorder(),
          focusColor: Colors.white70,
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: AppColors.textColor1),

          // Clear icon
          suffixIcon: isEditing
              ? IconButton(
                  onPressed: () => textController.clear(),
                  icon: const Icon(
                    Icons.cancel,
                    color: AppColors.textColor2,
                  ),
                )
              : null,
        ),
        validator: FormBuilderValidators.compose([
          if (widget.isRequired) FormBuilderValidators.required(),
        ]),
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            barrierDismissible: false,
          );

          // If no date is picked
          if (pickedDate == null) return;

          textController.text = Helper.formatDate(pickedDate);

          ref.read(editStatusProvider(id: widget.name).notifier).change(true);
        },
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
          ref.read(editStatusProvider(id: widget.name).notifier).change(false);
        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }
}
