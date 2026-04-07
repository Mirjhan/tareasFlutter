import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';

class EditarIncidenciaUseCase {
  IncidenciaRepository repository;

  EditarIncidenciaUseCase(
    this.repository,
  );

  Future<IncidenciaEntity> execute(IncidenciaEntity incidencia) {
    return repository.editarIncidencia(incidencia);
  }
}
