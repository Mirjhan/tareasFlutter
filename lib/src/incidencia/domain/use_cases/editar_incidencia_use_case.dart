import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';

class EditarIncidenciaUseCase {
  IncidenciaRepository repository;

  EditarIncidenciaUseCase(
    this.repository,
  );

  Future<Result<IncidenciaEntity>> execute(IncidenciaEntity incidencia) {
    return repository.editarIncidencia(incidencia);
  }
}
