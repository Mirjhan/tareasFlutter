import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';

class ListarIncidenciasUseCase {
  IncidenciaRepository repository;

  ListarIncidenciasUseCase(
    this.repository,
  );

  Future<List<IncidenciaEntity>> execute() {
    return repository.listarIncidencias();
  }
}
