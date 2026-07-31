import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';

class EditarImagenUseCase {
  IncidenciaRepository repository;

  EditarImagenUseCase(
    this.repository,
  );

  Future<Result<IncidenciaEntity>> execute(int id, String pathFile) {
    return repository.editarImagen(id, pathFile);
  }
}
