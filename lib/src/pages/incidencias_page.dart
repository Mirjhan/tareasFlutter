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
        builder: (controller) => SafeArea(
              child: Scaffold(
                appBar: appBar('Lista de incidencias'),
                body: RefreshIndicator(
                  onRefresh: controller.getIncidencias,
                  child: listViewBuilder(),
                ),
              ),
            ));
  }

  AppBar appBar(String titulo) {
    return AppBar(
      title: Text(titulo),
      centerTitle: true,
    );
  }

  Widget listViewBuilder() {
    final incidencias = controller.incidencias;
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: incidencias.length,
      itemBuilder: (context, index) => _itemCard(
          nombre: incidencias[index].nombre,
          descripcion: incidencias[index].descripcion),
    );
  }

  Widget _itemCard({
    required String nombre,
    required String descripcion,
  }) {
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
          children: [Text(nombre), Text(descripcion)],
        ),
      ),
    );
  }
}
