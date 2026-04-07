import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/incidencias/incidencias_controller.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/appbar.dart';

class IncidenciasPage extends StatelessWidget {
  const IncidenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IncidenciasController>(
        init: IncidenciasController(),
        builder: (controller) => SafeArea(
              child: Scaffold(
                appBar: appbarWidget(titulo: 'Lista de incidencias'),
                body: RefreshIndicator(
                  onRefresh: controller.getIncidencias,
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: controller.incidencias.length,
                    itemBuilder: (context, index) => _itemCard(
                      controller: controller,
                      nombre: controller.incidencias[index].nombre,
                      descripcion: controller.incidencias[index].descripcion,
                      index: index,
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    controller.goToAgregarIncidencia();
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ));
  }

  Widget _itemCard({
    required IncidenciasController controller,
    required String nombre,
    required String descripcion,
    required int index,
    String? imagen,
  }) {
    return GestureDetector(
      onTap: () => controller.goToEditarIncidencia(index),
      child: Card(
        elevation: 5,
        shadowColor: Colors.amber,
        color: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                  //image: DecorationImage(image: AssetImage("notFound.jpg")),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombre),
                    Text(descripcion),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => controller.confirmarDelete(index),
                  icon: Icon(Icons.delete_forever_rounded))
            ],
          ),
        ),
      ),
    );
  }
}
