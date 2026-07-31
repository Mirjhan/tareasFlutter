import 'package:tarea_flutter/src/usuario/domain/entities/usuario_entity.dart';
import 'package:tarea_flutter/src/usuario/domain/repositories/usuario_repository.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';

class CrearUsuariosUseCase {
  UsuarioRepository repository;

  CrearUsuariosUseCase(
    this.repository,
  );

  Future<Result<UsuarioEntity>> execute(
      UsuarioEntity usuario, String pathFile) {
    return repository.crearUsuarios(usuario, pathFile);
  }
}
