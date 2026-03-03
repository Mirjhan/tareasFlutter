import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/widgets/loading_overlay.dart';

class LoadingService extends GetxService {
  bool isShowing = false;
  OverlayEntry? _overlayEntry;

  void show() {
    if (isShowing) return;
    isShowing = true;

    _overlayEntry = OverlayEntry(
      builder: (context) => LoadingOverlay(),
    );

    final overlay = Navigator.of(Get.context!).overlay;
    overlay?.insert(_overlayEntry!);
  }

  void hide() {
    if (!isShowing) return;

    isShowing = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

void showLoading() => Get.find<LoadingService>().show();
void hideLoading() => Get.find<LoadingService>().hide();
