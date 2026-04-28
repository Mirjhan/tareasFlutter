import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';

class EditarIncidenciaConImagenUseCase {
  IncidenciaRepository repository;

  EditarIncidenciaConImagenUseCase(
    this.repository,
  );

  Future<IncidenciaEntity> execute(
      IncidenciaEntity incidencia, String pathFile) {
    return repository.editarIncidenciaConImagen(incidencia, pathFile);
  }
}
