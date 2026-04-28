import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';

abstract class IncidenciaRepository {
  Future<List<IncidenciaEntity>> listarIncidencias();
  Future<IncidenciaEntity> crearIncidencias(IncidenciaEntity incidencia);
  Future<IncidenciaEntity> editarIncidencia(IncidenciaEntity incidencia);
  Future<IncidenciaEntity> eliminarIncidencia(int id);
  Future<IncidenciaEntity> crearIncidenciaConImagen(
      IncidenciaEntity incidencia, String pathFile);
  Future<IncidenciaEntity> editarIncidenciaConImagen(
      IncidenciaEntity incidencia, String pathFile);
}
