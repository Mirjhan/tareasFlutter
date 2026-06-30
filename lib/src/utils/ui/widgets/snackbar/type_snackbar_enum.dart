import 'package:flutter/material.dart';

enum TypeSnackbarEnum {
  success(titulo: 'Éxito', color: Colors.green),
  error(titulo: 'Error', color: Colors.red),
  warning(titulo: 'Advertencia', color: Colors.amber);

  const TypeSnackbarEnum({
    required this.titulo,
    required this.color,
  });

  final String titulo;
  final Color color;
}
