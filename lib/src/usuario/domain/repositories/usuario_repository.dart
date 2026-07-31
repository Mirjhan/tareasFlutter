import 'package:tarea_flutter/src/usuario/domain/entities/usuario_entity.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';

abstract class UsuarioRepository {
  Future<Result<List<UsuarioEntity>>> listarUsuarios();
  Future<Result<UsuarioEntity>> crearUsuarios(
      UsuarioEntity usuario, String pathFile);
  Future<Result<UsuarioEntity>> editarUsuario(
      UsuarioEntity usuario, String pathFile);
  Future<UsuarioEntity> eliminarUsuario();
}
