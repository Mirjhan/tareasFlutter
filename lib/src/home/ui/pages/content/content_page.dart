import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/home/ui/pages/content/content_controller.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/incidencias/incidencias_page.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});
  final List<Widget> pages = [
    IncidenciasPage(),
    IncidenciasPage(),
    IncidenciasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentController>(
      init: ContentController(),
      builder: (controller) => Scaffold(
        body: PageView(
          controller: controller.pageController,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.indexPage,
          onTap: controller.onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment_late_outlined),
                label: "Incidencias"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "Usuarios"),
          ],
        ),
      ),
    );
  }
}
