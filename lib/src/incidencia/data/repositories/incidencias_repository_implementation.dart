import 'dart:convert';

import 'package:tarea_flutter/src/utils/domain/entities/error_entity.dart';
import 'package:tarea_flutter/src/incidencia/data/requests/incidencia_request.dart';
import 'package:tarea_flutter/src/incidencia/data/responses/incidencia_response.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/incidencia/domain/entities/incidencia_entity.dart';
import 'package:tarea_flutter/src/incidencia/domain/repositories/incidencia_repository.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_http_manager.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_response.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/method_enum.dart';

class IncidenciasRepositoryImplementation implements IncidenciaRepository {
  @override
  Future<Result<IncidenciaEntity>> crearIncidencias(
      IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    IncidenciaRequest request = incidencia.toData();
    AppResponse response = await appHttpManager.post(
      path: '/incidencia/create',
      body: request.toJson(),
    );
    if (response.isSuccess) {
      IncidenciaResponse incidenciaResponse =
          IncidenciaResponse.fromJson(jsonDecode(response.body));
      return Result.success(incidenciaResponse.toDomain());
    }
    return Result.error(ErrorEntity(
        title: 'Error en el servidor',
        description: "Error code ${response.statusCode}"));
  }

  @override
  Future<IncidenciaEntity> editarIncidencia(IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    IncidenciaRequest request = incidencia.toData();
    AppResponse response = await appHttpManager.put(
      path: '/incidencia/update',
      body: request.toJson(),
    );
    if (response.isSuccess) {
      IncidenciaResponse incidenciaResponse =
          IncidenciaResponse.fromJson(jsonDecode(response.body));
      return incidenciaResponse.toDomain();
    }
    throw UnimplementedError();
  }

  @override
  Future<Result<IncidenciaEntity>> eliminarIncidencia(int id) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.delete(
      path: '/incidencia/delete/$id',
    );
    if (response.isSuccess) {
      IncidenciaResponse incidenciaResponse =
          IncidenciaResponse.fromJson(jsonDecode(response.body));
      return Result.success(incidenciaResponse.toDomain());
    }
    return Result.error(ErrorEntity(
        title: "Error en el servidor",
        description: "Error code${response.statusCode}"));
  }

  @override
  Future<Result<List<IncidenciaEntity>>> listarIncidencias() async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.get(path: '/incidencia/');
    if (response.isSuccess) {
      return Result.success(incidenciaEntityFromJson(response.body));
    }
    return Result.error(ErrorEntity(
        title: "Error en el servidor",
        description: "Error code${response.statusCode}"));
  }

  @override
  Future<Result<IncidenciaEntity>> crearIncidenciaConImagen(
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
      return Result.success(
          IncidenciaEntity.fromJson(jsonDecode(response.body)));
    }
    return Result.error(ErrorEntity(
        title: 'Error en el servidor',
        description: "Error code${response.statusCode}"));
  }

  @override
  Future<Result<IncidenciaEntity>> editarIncidenciaConImagen(
      IncidenciaEntity incidencia, String? pathFile) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response;
    if (pathFile == null) {
      response = await appHttpManager.put(
        path: '/incidencia/update',
        body: incidencia.toJsonFormDataIpdateImage(),
      );
    } else {
      response = await appHttpManager.sendFile(
        method: MethodEnum.put,
        path: '/incidencia/updateConImagen',
        fieldNameOfFile: 'imagen',
        pathFile: pathFile,
        fields: incidencia.toJsonFormDataIpdateImage(),
      );
    }

    if (response.isSuccess) {
      return Result.success(
          IncidenciaEntity.fromJson(jsonDecode(response.body)));
    }

    return Result.error(ErrorEntity(
        title: "Error en el servidor",
        description: "Error code ${response.statusCode}"));
  }
}
