import 'dart:convert';

import 'package:tarea_flutter/src/usuario/domain/entities/usuario_entity.dart';
import 'package:tarea_flutter/src/usuario/domain/repositories/usuario_repository.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_http_manager.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/app_response.dart';
import 'package:tarea_flutter/src/utils/data/http%20manager/method_enum.dart';
import 'package:tarea_flutter/src/utils/domain/entities/error_entity.dart';

class UsuariosRepositoryImplementation implements UsuarioRepository {
  @override
  Future<Result<List<UsuarioEntity>>> listarUsuarios() async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.get(path: '/usuario/');
    if (response.isSuccess) {
      return Result.success(usuarioEntityFromJson(response.body));
    }
    return Result.error(ErrorEntity(
        title: 'Error en el servidor',
        description: "Eeror code${response.statusCode}"));
  }

  @override
  Future<Result<UsuarioEntity>> crearUsuarios(
      UsuarioEntity usuario, String pathFile) async {
    AppHttpManager appHttpManager = AppHttpManager();
    AppResponse response = await appHttpManager.sendFile(
      method: MethodEnum.post,
      path: '/usuario/create',
      fieldNameOfFile: "imagen",
      pathFile: pathFile,
      fields: usuario.toJsonFormDataCreate(),
    );
    if (response.isSuccess) {
      return Result.success(UsuarioEntity.fromJson(jsonDecode(response.body)));
    }
    return Result.error(ErrorEntity(
        title: 'Error en el servidor',
        description: "Error code${response.body}"));
  }

  @override
  Future<Result<UsuarioEntity>> editarUsuario(
      UsuarioEntity usuario, String? pathFile) {
    throw UnimplementedError();
  }

  @override
  Future<UsuarioEntity> eliminarUsuario() {
    throw UnimplementedError();
  }
}
