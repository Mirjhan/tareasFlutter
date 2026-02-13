import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/pages/agregar_incidencias_controller.dart';

class AgregarIncidenciasPage extends StatelessWidget {
  final AgregarIncidenciasController controller =
      AgregarIncidenciasController();
  AgregarIncidenciasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GetBuilder<AgregarIncidenciasController>(
        init: controller,
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(controller.estaEditando
                    ? 'Editar incidencia'
                    : 'Nueva incidencia'),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      cajaDeTexto(
                        hintext: 'Nombre',
                        onChanged: controller.onChangedNombre,
                        icon: Icon(Icons.abc),
                        initialValue: controller.nombre,
                      ),
                      cajaDeTexto(
                          hintext: 'Descripcion',
                          onChanged: controller.onChangedDescripcion,
                          icon: Icon(Icons.abc),
                          initialValue: controller.descripcion),
                      dropdownMenu(size.width),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: boton(),
            ));
  }

  Widget boton() {
    return GestureDetector(
      onTap: controller.estaEditando ? controller.editar : controller.guardar,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.amber),
        child: Text(
          'Guardar',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget cajaDeTexto({
    required String hintext,
    required void Function(String)? onChanged,
    String? initialValue,
    Icon? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintext,
          prefixIcon: icon,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget dropdownMenu(double width) {
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
