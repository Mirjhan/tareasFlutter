import 'dart:convert';

import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_http_manager.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_response.dart';

class IncidenciasRepositoryImplementation implements IncidenciaRepository {
  @override
  Future<IncidenciaEntity> crearIncidencias(IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.post(
        path: '/incidencia/create', body: incidencia.toJson());
    if (response.isSuccess) {
      return IncidenciaEntity.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<IncidenciaEntity> editarIncidencia(IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.put(
      path: '/incidencia/create',
      body: incidencia.toJson(),
    );
    if (response.isSuccess) {
      return IncidenciaEntity.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<IncidenciaEntity> eliminarIncidencia(int id) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response =
        await appHttpManager.delete(path: '/incidencia/delete/$id');

    if (response.isSuccess) {
      return IncidenciaEntity.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<List<IncidenciaEntity>> listarIncidencias() async {
    AppHttpManager appHttpManager = AppHttpManager();

    AppResponse response = await appHttpManager.get(path: '/incidencia/');
    if (response.isSuccess) {
      return incidenciaEntityFromJson(response.body);
    }
    throw UnimplementedError();
  }
}
