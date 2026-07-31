import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';

abstract class IncidenciaRepository {
  Future<Result<List<IncidenciaEntity>>> listarIncidencias();
  Future<Result<IncidenciaEntity>> crearIncidencias(
      IncidenciaEntity incidencia);
  Future<Result<IncidenciaEntity>> editarIncidencia(
      IncidenciaEntity incidencia);

  Future<Result<IncidenciaEntity>> eliminarIncidencia(int id);
  Future<Result<IncidenciaEntity>> editarImagen(int id, String pathFile);
}
