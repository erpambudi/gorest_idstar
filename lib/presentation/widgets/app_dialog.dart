import 'package:flutter/material.dart';
import 'package:gorest_idstar/common/constants/app_values.dart';
import 'package:gorest_idstar/common/styles/app_text_styles.dart';

class AppDialog {
  static void showMainLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              width: 100,
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  static void hideMainLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showMainSnackbar(BuildContext context, String message,
      {bool isError = false, bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyle.snackbar,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isSuccess
            ? Colors.green
            : isError
                ? Colors.red
                : Colors.black,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppValues.radius))),
      ),
    );
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    String message, {
    String? positiveButtonText,
    String? negativeButtonText,
    Function? positiveButtonCallback,
    Function? negativeButtonCallback,
  }) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppTextStyle.title.copyWith(fontSize: 18),
          ),
          content: Text(
            message,
          ),
          actions: [
            if (negativeButtonText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (negativeButtonCallback != null) {
                    negativeButtonCallback();
                  }
                },
                child: Text(
                  negativeButtonText,
                  style: AppTextStyle.actionDialog,
                ),
              ),
            if (positiveButtonText != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (positiveButtonCallback != null) {
                    positiveButtonCallback();
                  }
                },
                child: Text(
                  positiveButtonText,
                  style: AppTextStyle.actionDialog,
                ),
              ),
          ],
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppValues.halfPadding,
            horizontal: AppValues.largePadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        );
      }),
    );
  }
}
