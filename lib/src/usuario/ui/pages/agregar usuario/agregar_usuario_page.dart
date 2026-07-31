import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/usuario/ui/pages/agregar%20usuario/agregar_usuario_controller.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/appbar.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/input_widget.dart';

class AgregarUsuarioPage extends StatelessWidget {
  const AgregarUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgregarUsuarioController>(
        init: AgregarUsuarioController(),
        builder: (controller) => Scaffold(
              appBar: appbarWidget(titulo: 'Agregar usuario'),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    InputWidget(
                      hintText: 'Nombre',
                      prefixIconData: Icons.abc,
                      onChanged: controller.onChangedNombre,
                    ),
                    InputWidget(
                      hintText: 'Apellidos',
                      prefixIconData: Icons.abc,
                      onChanged: controller.onChangedApellidos,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: DropdownMenu(
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                              value: 1,
                              label: 'Documento de Identidad Nacional'),
                          DropdownMenuEntry(
                              value: 2, label: 'Carnet de Extranjeria'),
                        ],
                        hintText: 'Tipo de documento:',
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        width: double.infinity,
                      ),
                    ),
                    InputWidget(
                      hintText: 'Documento',
                      prefixIconData: Icons.badge_outlined,
                      onChanged: controller.onChangedDocumento,
                    ),
                    InputWidget(
                      hintText: 'Direccion',
                      prefixIconData: Icons.location_on,
                      onChanged: controller.onChangedDireccion,
                    ),
                    InputWidget(
                      hintText: 'Telefono',
                      prefixIconData: Icons.phone_android,
                      onChanged: controller.onChangedTelefono,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: DropdownMenu(
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: 1, label: 'Administrador'),
                          DropdownMenuEntry(value: 2, label: 'Empleado'),
                        ],
                        leadingIcon: Icon(Icons.person),
                        hintText: 'Tipo de Usuario:',
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)))),
                        width: double.infinity,
                      ),
                    ),
                    InputWidget(
                      hintText: 'Email',
                      prefixIconData: Icons.email,
                      onChanged: controller.onChangedEmail,
                    ),
                    InputWidget(
                      hintText: 'Password',
                      prefixIconData: Icons.lock_outline,
                      onChanged: controller.onChangedPassword,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: GestureDetector(
                onTap: controller.crearUsuario,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.lightBlueAccent),
                  child: Text(
                    'Guardar',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ));
  }
}
