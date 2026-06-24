import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/home/ui/pages/content/content_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de Incidencias',
      home: ContentPage(),
    );
  }
}
