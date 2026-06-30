import 'package:flutter/material.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/appbar.dart';

class AjustesPage extends StatelessWidget {
  const AjustesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(titulo: "Ajustes"),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('Cambiar correo'),
          ),
          ListTile(
            leading: Icon(Icons.password_outlined),
            title: Text('Cambiar contraseña'),
          ),
          ListTile(
            leading: Icon(Icons.video_camera_front_outlined),
            title: Text('Cambiar correo'),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
