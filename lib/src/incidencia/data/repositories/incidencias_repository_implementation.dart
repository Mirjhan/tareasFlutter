import 'dart:convert';

import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_http_manager.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_response.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/method_enum.dart';

class IncidenciasRepositoryImplementation implements IncidenciaRepository {
  @override
  Future<IncidenciaEntity> crearIncidencias(IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.post(
      path: '/incidencia/create',
      body: incidencia.toJson(),
    );
    if (response.isSuccess) {
      return IncidenciaEntity.fromJson(jsonDecode(response.body));
    }
    throw UnimplementedError();
  }

  @override
  Future<IncidenciaEntity> editarIncidencia(IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.put(
      path: '/incidencia/update',
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
    AppResponse response = await appHttpManager.delete(
      path: '/incidencia/delete/$id',
    );
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

  @override
  Future<IncidenciaEntity> crearIncidenciaConImagen(
      IncidenciaEntity incidencia, String pathFile) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.sendFile(
      method: MethodEnum.post,
      path: '/incidencia/createConImagen',
      fieldNameOfFile: 'imagen',
      pathFile: pathFile,
      fields: incidencia.toJsonFormDataCreateImage(),
    );

    if (response.isSuccess) {
      return IncidenciaEntity.fromJson(jsonDecode(response.body));
    }

    throw UnimplementedError();
  }

  @override
  Future<IncidenciaEntity> editarIncidenciaConImagen(
      IncidenciaEntity incidencia, String pathFile) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.sendFile(
      method: MethodEnum.put,
      path: '/incidencia/updateConImagen',
      fieldNameOfFile: 'imagen',
      pathFile: pathFile,
      fields: incidencia.toJsonFormDataIpdateImage(),
    );
    if (response.isSuccess) {
      return IncidenciaEntity.fromJson(jsonDecode(response.body));
    }

    throw UnimplementedError();
  }
}
