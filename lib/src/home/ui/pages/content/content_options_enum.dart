import 'package:flutter/material.dart';

enum ContentOptionsEnum {
  home(icon: Icons.home, title: 'Inicio'),
  incidencias(icon: Icons.abc_sharp, title: 'Incidencias'),
  usuarios(icon: Icons.people, title: 'Usuarios'),
  ajustes(icon: Icons.settings, title: 'Ajustes');

  const ContentOptionsEnum({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
}
