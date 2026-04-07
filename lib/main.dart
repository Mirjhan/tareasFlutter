import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/app.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';

void main() {
  Get.put(LoadingService());
  runApp(const MyApp());
}
