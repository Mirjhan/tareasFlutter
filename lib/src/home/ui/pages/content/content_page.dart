import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/ajustes/ui/pages/ajustes_page.dart';
import 'package:tarea_flutter/src/home/ui/pages/content/content_controller.dart';
import 'package:tarea_flutter/src/home/ui/pages/content/content_options_enum.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/incidencias/incidencias_page.dart';

class ContentPage extends StatelessWidget {
  ContentPage({super.key});
  final List<Widget> pages = [
    IncidenciasPage(),
    IncidenciasPage(),
    IncidenciasPage(),
    AjustesPage(),
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
        bottomNavigationBar: _bottomNavigation(controller),
      ),
    );
  }

  Widget _bottomNavigation(ContentController controller) {
    List<BottomNavigationBarItem> items = ContentOptionsEnum.values
        .map((e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.title))
        .toList();

    return BottomNavigationBar(
      currentIndex: controller.indexPage,
      fixedColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      onTap: controller.onTap,
      items: items,
    );
  }
}
