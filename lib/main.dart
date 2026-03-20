import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/app.dart';
import 'package:tarea_flutter/src/widgets/loading_service.dart';

void main() {
  Get.put(LoadingService());
  runApp(const MyApp());
}
