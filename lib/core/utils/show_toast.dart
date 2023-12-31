import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

CancelFunc showToastMessage(String message) {
  return BotToast.showCustomNotification(
    align: Alignment.bottomCenter,
    animationDuration: const Duration(milliseconds: 700),
    animationReverseDuration: const Duration(milliseconds: 700),
    duration: const Duration(seconds: 1),
    toastBuilder: (cancel) {
      return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12)),
          child: Text(message,style: const TextStyle(color: Colors.white),));
    },
  );
}
