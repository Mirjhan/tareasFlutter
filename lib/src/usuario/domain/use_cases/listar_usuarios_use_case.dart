import 'package:tarea_flutter/src/usuario/domain/entities/usuario_entity.dart';
import 'package:tarea_flutter/src/usuario/domain/repositories/usuario_repository.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';

class ListarUsuariosUseCase {
  UsuarioRepository repository;

  ListarUsuariosUseCase(
    this.repository,
  );

  Future<Result<List<UsuarioEntity>>> execute() {
    return repository.listarUsuarios();
  }
}
