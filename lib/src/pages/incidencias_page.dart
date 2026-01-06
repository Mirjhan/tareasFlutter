import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/pages/incidencias_controller.dart';

class IncidenciasPage extends StatelessWidget {
  final IncidenciasController controller = IncidenciasController();
  IncidenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IncidenciasController>(
        init: controller,
        builder: (controller) => Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Text('Hola'),
                  ],
                ),
              ),
            ));
  }
}
