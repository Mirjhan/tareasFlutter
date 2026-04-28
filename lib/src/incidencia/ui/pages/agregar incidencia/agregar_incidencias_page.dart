import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/core/config.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/agregar%20incidencia/agregar_incidencias_controller.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/appbar.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/input_widget.dart';

class AgregarIncidenciasPage extends StatelessWidget {
  const AgregarIncidenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GetBuilder<AgregarIncidenciasController>(
        init: AgregarIncidenciasController(),
        builder: (controller) => Scaffold(
              appBar: appbarWidget(
                  titulo: controller.estaEditando
                      ? 'Editar incidencia'
                      : 'Nueva incidencia'),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InputWidget(
                        hintText: 'Nombre',
                        prefixIconData: Icons.abc,
                        onChanged: controller.onChangedNombre,
                        initialValue: controller.nombre,
                      ),
                      InputWidget(
                        hintText: 'Descripción',
                        prefixIconData: Icons.abc,
                        onChanged: controller.onChangedDescripcion,
                        initialValue: controller.descripcion,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      dropdownMenu(size.width, controller),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: controller.picker,
                        child: mostrarImagen(controller),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: boton(controller),
            ));
  }

  Widget boton(AgregarIncidenciasController controller) {
    return GestureDetector(
      onTap: controller.estaEditando
          ? controller.editarIncidenciaConImagen
          : controller.crearIncidenciaConImagen,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlueAccent),
        child: Text(
          'Guardar',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget dropdownMenu(double width, AgregarIncidenciasController controller) {
    return DropdownMenu<String>(
      initialSelection: controller.estado,
      dropdownMenuEntries: [
        DropdownMenuEntry(value: 'E', label: 'En espera'),
        DropdownMenuEntry(value: 'P', label: 'En proceso'),
        DropdownMenuEntry(value: 'R', label: 'Resuelto'),
      ],
      onSelected: (value) => controller.changeDropdownMenu(value),
      label: Text('Estado'),
      width: width,
      hintText: 'Elija su opción',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget mostrarImagen(AgregarIncidenciasController controller) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
      child: cuadroImagen(controller),
    );
  }

  Widget cuadroImagen(AgregarIncidenciasController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: (controller.pathSelected != null)
          ? Image.file(File(controller.pathSelected!))
          : (controller.incidenciaSeleccionada?.imagen == null)
              ? Image.asset('assets/images/camara.jpg')
              : Image.network(
                  '$urlServerPublic/incidencia/${controller.incidenciaSeleccionada?.imagen}'),
    );
  }
}
