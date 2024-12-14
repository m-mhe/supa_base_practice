import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> bottomPopUpMessage(
    {required BuildContext context, required bool isError, required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(
        message,
        textAlign: TextAlign.center,
      )));
}
