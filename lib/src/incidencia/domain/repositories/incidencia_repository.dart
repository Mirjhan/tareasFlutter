import 'package:tarea_flutter/src/incidencia/data/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';

abstract class IncidenciaRepository {
  Future<Result<List<IncidenciaEntity>>> listarIncidencias();
  Future<Result<IncidenciaEntity>> crearIncidencias(
      IncidenciaEntity incidencia);
  Future<IncidenciaEntity> editarIncidencia(IncidenciaEntity incidencia);
  //Future<IncidenciaEntity> eliminarIncidencia(int id);
  Future<Result<IncidenciaEntity>> crearIncidenciaConImagen(
      IncidenciaEntity incidencia, String pathFile);
  Future<Result<IncidenciaEntity>> editarIncidenciaConImagen(
      IncidenciaEntity incidencia, String? pathFile);

  Future<Result<IncidenciaEntity>> eliminarIncidencia(int id);
}
