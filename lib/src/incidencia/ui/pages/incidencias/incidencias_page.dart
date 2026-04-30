import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/core/config.dart';
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
                      imagen: controller.incidencias[index].imagen,
                      index: index,
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: controller.goToAgregarIncidencia,
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
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: _pickImage(imagen),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nombre),
                    Text(
                      descripcion,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () => controller
                      .confirmarDelete(controller.incidencias[index].id!),
                  icon: Icon(Icons.delete_forever_rounded))
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _pickImage(String? imagen) {
    return (imagen != null)
        ? NetworkImage('$urlServerPublic/incidencia/$imagen')
        : AssetImage('assets/images/not_found.png');
  }
}
