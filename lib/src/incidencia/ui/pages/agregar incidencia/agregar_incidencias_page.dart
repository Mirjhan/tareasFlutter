import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      dropdownMenu(size.width, controller),
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
          ? controller.editarIncidencia
          : controller.crearIncidencia,
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
      helperText: 'Estado',
      width: width,
      hintText: 'Elija su opción',
    );
  }
}
