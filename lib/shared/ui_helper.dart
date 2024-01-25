import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

// Snackbar type
enum SnackbarType {
  success,
  error,
}

abstract final class UiHelper {
  /// For showing snackbar
  static void showSnackbar({
    required BuildContext context,
    required String message,
    required SnackbarType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.textColor1,
            fontSize: 17,
          ),
        ),
        backgroundColor: type == SnackbarType.success ? Colors.green : Colors.redAccent,
      ),
    );
  }

  /// For showing alert
  static void showAlert({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onOk,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),

            // For alert with two buttons
            if (onOk != null)
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                  onOk();
                },
              ),
          ],
        );
      },
    );
  }

  /// For displaying connectivity status
  static void showConnectivityStatus({
    required BuildContext context,
    required ConnectivityResult result,
  }) {
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.ethernet || result == ConnectivityResult.mobile) {
      showSnackbar(context: context, message: 'You\'re online now.', type: SnackbarType.success);
    } else {
      showSnackbar(context: context, message: 'You\'re offline now.', type: SnackbarType.error);
    }
  }

// /// For showing filter options as a modal bottom sheet
// static void showFilterOptions({
//   required BuildContext context,
//   required FilterOption filterOption,
//   required VoidCallback onClose,
//   required VoidCallback onFilter,
// }) {
//   final formKey = GlobalKey<FormBuilderState>();
//
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: AppColors.bgColor1,
//     isDismissible: false,
//     isScrollControlled: true,
//     builder: (context) {
//       return SizedBox(
//         width: double.infinity,
//         child: Consumer(builder: (context, ref, _) {
//           final _ = ref.watch(filterProvider);
//
//           return FormBuilder(
//             key: formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   // Header section
//                   SizedBox(
//                     height: 36,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Filter Options',
//                           style: TextStyle(
//                             color: AppColors.textColor2,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//
//                         // Closing icon
//                         Row(
//                           children: [
//                             // Clear button
//                             IconButton(
//                               onPressed: () {
//                                 FocusScope.of(context).unfocus();
//
//                                 UiHelper.showAlert(
//                                     context: context,
//                                     title: 'Confirm Clear',
//                                     message: 'Do you want to clear the filter options?',
//                                     onOk: () {
//                                       // Resetting all the filter option
//                                       filterOption.fromDate = '';
//                                       filterOption.toDate = '';
//                                       filterOption.type = null;
//                                       filterOption.tag = null;
//                                       filterOption.filterCondition = null;
//                                       filterOption.amount = '';
//
//                                       // Resetting filter option
//                                       ref.read(filterProvider.notifier).clear();
//                                     });
//                               },
//                               icon: const Icon(
//                                 Icons.clear_all_outlined,
//                                 color: AppColors.textColor2,
//                               ),
//                             ),
//
//                             // Close button
//                             IconButton(
//                               onPressed: onClose,
//                               icon: const Icon(
//                                 Icons.close_rounded,
//                                 color: AppColors.buttonColor,
//                                 size: 26,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // For filter options
//                   Expanded(
//                     child: ListView(
//                       padding: const EdgeInsets.symmetric(vertical: 20),
//                       children: [
//                         // Filter by date
//                         const Text(
//                           'By Date',
//                           style: TextStyle(
//                             color: AppColors.textColor2,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Gaps.vGap15,
//
//                         // From date
//                         AppDatePicker(
//                           name: 'fromDate',
//                           labelText: 'From',
//                           initialValue: filterOption.fromDate,
//                           isRequired: false,
//                         ),
//                         Gaps.vGap10,
//
//                         // To date
//                         AppDatePicker(
//                           name: 'toDate',
//                           labelText: 'To',
//                           initialValue: filterOption.toDate,
//                           isRequired: false,
//                         ),
//                         Gaps.vGap10,
//
//                         const Divider(color: AppColors.bgColor2, thickness: 2),
//                         Gaps.vGap10,
//
//                         // Filter by type
//                         const Text(
//                           'By Type',
//                           style: TextStyle(
//                             color: AppColors.textColor2,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Gaps.vGap15,
//
//                         // Type
//                         AppDropdown(
//                           name: 'type',
//                           labelText: 'Type',
//                           options: ExpenseType.values,
//                           initialValue: filterOption.type,
//                           isRequired: false,
//                         ),
//                         Gaps.vGap10,
//                         const Divider(color: AppColors.bgColor2, thickness: 2),
//                         Gaps.vGap10,
//
//                         // Filter by tag
//                         const Text(
//                           'By Tag',
//                           style: TextStyle(
//                             color: AppColors.textColor2,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Gaps.vGap15,
//
//                         // Tag
//                         AppDropdown(
//                           name: 'tag',
//                           labelText: 'Tag',
//                           initialValue: filterOption.tag,
//                           options: ExpenseTag.values,
//                           isRequired: false,
//                         ),
//                         Gaps.vGap10,
//                         const Divider(color: AppColors.bgColor2, thickness: 2),
//                         Gaps.vGap10,
//
//                         // Filter by amount
//                         const Text(
//                           'By Amount',
//                           style: TextStyle(
//                             color: AppColors.textColor2,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Gaps.vGap15,
//
//                         // Conditions
//                         AppDropdown(
//                           name: 'filterCondition',
//                           labelText: 'Filter Condition',
//                           initialValue: filterOption.filterCondition,
//                           options: FilterCondition.values,
//                           isRequired: false,
//                         ),
//                         Gaps.vGap15,
//
//                         // Amount
//                         AppTextField(
//                           name: 'amount',
//                           labelText: 'Amount',
//                           initialValue: filterOption.amount,
//                           regex: Regex.currency,
//                           isRequired: false,
//                         ),
//                         Gaps.vGap30,
//
//                         // Filter button
//                         AppButton(
//                           labelText: 'FILTER',
//                           onPressed: () {
//                             FocusScope.of(context).unfocus();
//
//                             // Return if not valid
//                             if (!formKey.currentState!.saveAndValidate()) {
//                               return;
//                             }
//
//                             //If valid
//                             final values = formKey.currentState!.value;
//
//                             // Updating the filter option
//                             filterOption.fromDate = values['fromDate'];
//                             filterOption.toDate = values['toDate'];
//                             filterOption.type = values['type'];
//                             filterOption.tag = values['tag'];
//                             filterOption.filterCondition = values['filterCondition'];
//                             filterOption.amount = values['amount'];
//
//                             // For filtering the list
//                             onFilter();
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       );
//     },
//   );
// }
}
