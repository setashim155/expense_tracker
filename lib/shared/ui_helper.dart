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
    if (result == ConnectivityResult.none || result == ConnectivityResult.bluetooth) {
      showSnackbar(context: context, message: 'You\'re offline.', type: SnackbarType.error);
    }
  }
}
