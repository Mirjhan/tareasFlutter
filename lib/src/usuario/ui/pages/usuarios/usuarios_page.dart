import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarea_flutter/src/incidencia/core/config.dart';
import 'package:tarea_flutter/src/usuario/ui/pages/usuarios/usuarios_controller.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/appbar.dart';

class UsuariosPage extends StatelessWidget {
  const UsuariosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsuariosController>(
      init: UsuariosController(),
      builder: (controller) => Scaffold(
          appBar: appbarWidget(titulo: 'Usuarios'),
          body: RefreshIndicator(
            onRefresh: controller.getUsuarios,
            child: ListView.builder(
              itemCount: controller.usuarios.length,
              itemBuilder: (context, index) => itemCard(controller, index),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.goToAgregarUsuario,
            child: Icon(Icons.add),
          )),
    );
  }

  Card itemCard(UsuariosController controller, int index) {
    return Card(
        color: Colors.lightBlue,
        shadowColor: Colors.grey,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: itemListTile(
          title: controller.usuarios[index].nombre,
          subtitle: controller.usuarios[index].apellidos,
        ));
  }

  Widget itemListTile({
    required String title,
    required String subtitle,
    String? imagen,
  }) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: _pickImage(imagen)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.delete_forever_rounded),
    );
  }

  ImageProvider _pickImage(String? imagen) {
    return (imagen != null)
        ? NetworkImage('$urlServerPublic/usuario/$imagen')
        : AssetImage('assets/images/users.jpg');
  }
}
