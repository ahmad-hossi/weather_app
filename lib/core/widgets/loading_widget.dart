import 'package:flutter/material.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
  return showDialog(
      context: context,
      useRootNavigator: true,
      builder: (_) => const SizedBox(
            width: 24,
            height: 24,
            child: Center(child: CircularProgressIndicator()),
          ));
}
