enum EstadosIncidenciaEnum {
  espera(valor: 'E', descripcion: 'En espera'),
  proceso(valor: 'P', descripcion: 'En proceso'),
  resuelto(valor: 'R', descripcion: 'Resuelto');

  const EstadosIncidenciaEnum({
    required this.valor,
    required this.descripcion,
  });

  final String valor;
  final String descripcion;
}
