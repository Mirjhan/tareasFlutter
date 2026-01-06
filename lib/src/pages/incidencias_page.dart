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
              appBar: appBar('Lista de incidencias'),
              body: SafeArea(
                  child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: 20,
                itemBuilder: (context, index) => cards(),
              )),
            ));
  }

  AppBar appBar(String titulo) {
    return AppBar(
      title: Text(titulo),
      centerTitle: true,
    );
  }

  Widget cards() {
    return Card(
      elevation: 5,
      shadowColor: Colors.amber,
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Titulo....'), Text('Descripcion....')],
        ),
      ),
    );
  }
}
