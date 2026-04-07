import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';

class EliminarIncidenciaUseCase {
  IncidenciaRepository repository;

  EliminarIncidenciaUseCase(
    this.repository,
  );

  Future<IncidenciaEntity> execute(int id) {
    return repository.eliminarIncidencia(id);
  }
}
