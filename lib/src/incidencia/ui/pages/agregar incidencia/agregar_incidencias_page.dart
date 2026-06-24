import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/core/config.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/agregar%20incidencia/agregar_incidencias_controller.dart';
import 'package:tarea_flutter/src/incidencia/ui/pages/agregar%20incidencia/incidencias_estados_enum.dart';
import 'package:tarea_flutter/src/utils/core/strings.dart';
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
              appBar: _appBar(controller),
              body: _body(controller, size),
              bottomNavigationBar: boton(controller),
            ));
  }

  AppBar _appBar(AgregarIncidenciasController controller) {
    String title = controller.estaEditando
        ? editarIncidenciaString
        : nuevaIncidenciaString;

    return appbarWidget(titulo: title);
  }

  Widget _body(AgregarIncidenciasController controller, Size size) {
    return SingleChildScrollView(
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
            dropdownMenu(size.width, controller),
            _elegirImagenWidget(controller),
          ],
        ),
      ),
    );
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
    List<DropdownMenuEntry<String>> entries = EstadosIncidenciaEnum.values
        .map((e) => DropdownMenuEntry(value: e.valor, label: e.descripcion))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: DropdownMenu<String>(
        initialSelection: controller.estado,
        dropdownMenuEntries: entries,
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
      ),
    );
  }

  Widget _elegirImagenWidget(AgregarIncidenciasController controller) {
    return GestureDetector(
      onTap: controller.picker,
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: cuadroImagen(controller),
      ),
    );
  }

  Widget cuadroImagen(AgregarIncidenciasController controller) {
    Image imagenDefaultOrNetwork = (controller.incidenciaSeleccionada?.imagen ==
            null)
        ? Image.asset(sinImagenUrl)
        : Image.network(
            '$urlServerPublic/incidencia/${controller.incidenciaSeleccionada?.imagen}');

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: (controller.pathSelected != null)
          ? Image.file(File(controller.pathSelected!))
          : imagenDefaultOrNetwork,
    );
  }
}
