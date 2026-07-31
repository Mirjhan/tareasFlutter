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
  Future<Result<IncidenciaEntity>> crearIncidencias(
      IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    IncidenciaRequest request = IncidenciaRequest(
        nombre: incidencia.nombre,
        descripcion: incidencia.descripcion,
        estado: incidencia.estado);
    AppResponse response = await appHttpManager.post(
      path: '/incidencia/create',
      body: request.toJson(),
    );
    if (response.isSuccess) {
      IncidenciaResponse incidenciaResponse =
          IncidenciaResponse.fromJson(jsonDecode(response.body));
      return Result.success(
        IncidenciaEntity(
          id: incidenciaResponse.id,
          nombre: incidenciaResponse.nombre,
          descripcion: incidenciaResponse.descripcion,
          estado: incidenciaResponse.estado,
          imagen: incidenciaResponse.imagen,
        ),
      );
    }
    return Result.error(ErrorEntity(
        title: 'Error en el servidor',
        description: "Error code ${response.statusCode}"));
  }

  @override
  Future<Result<IncidenciaEntity>> editarIncidencia(
      IncidenciaEntity incidencia) async {
    AppHttpManager appHttpManager = AppHttpManager();
    IncidenciaRequest request = IncidenciaRequest(
        id: incidencia.id,
        nombre: incidencia.nombre,
        descripcion: incidencia.descripcion,
        estado: incidencia.estado);
    AppResponse response = await appHttpManager.put(
      path: '/incidencia/update',
      body: request.toJson(),
    );
    if (response.isSuccess) {
      IncidenciaResponse incidenciaResponse =
          IncidenciaResponse.fromJson(jsonDecode(response.body));
      return Result.success(
        IncidenciaEntity(
          id: incidenciaResponse.id,
          nombre: incidenciaResponse.nombre,
          descripcion: incidenciaResponse.descripcion,
          estado: incidenciaResponse.estado,
          imagen: incidenciaResponse.imagen,
        ),
      );
    }
    return Result.error(ErrorEntity(
        title: 'Error en el servidor',
        description: "Error code ${response.statusCode}"));
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
      return Result.success(
        IncidenciaEntity(
          id: incidenciaResponse.id,
          nombre: incidenciaResponse.nombre,
          descripcion: incidenciaResponse.descripcion,
          estado: incidenciaResponse.estado,
          imagen: incidenciaResponse.imagen,
        ),
      );
    }
    return Result.error(ErrorEntity(
        title: "Error en el servidor",
        description: "Error code${response.statusCode}"));
  }

  @override
  Future<Result<IncidenciaEntity>> editarImagen(int id, String pathFile) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.sendFile(
      method: MethodEnum.put,
      path: '/incidencia/updateConImagen',
      fieldNameOfFile: 'imagen',
      pathFile: pathFile,
      fields: {'id': id.toString()},
    );

    if (response.isSuccess) {
      return Result.success(
          IncidenciaEntity.fromJson(jsonDecode(response.body)));
    }

    return Result.error(ErrorEntity(
        title: "Error en el servidor",
        description: "Error code ${response.statusCode}"));
  }
}
