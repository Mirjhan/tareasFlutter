import 'package:get/get.dart';
import 'package:tarea_flutter/src/usuario/data/repositories/usuarios_repository_implementation.dart';
import 'package:tarea_flutter/src/usuario/domain/entities/usuario_entity.dart';
import 'package:tarea_flutter/src/usuario/domain/use_cases/listar_usuarios_use_case.dart';
import 'package:tarea_flutter/src/usuario/ui/pages/agregar%20usuario/agregar_usuario_page.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/utils/domain/entities/error_entity.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';

class UsuariosController extends GetxController {
  ListarUsuariosUseCase listarUsuariosUseCase =
      ListarUsuariosUseCase(UsuariosRepositoryImplementation());
  List<UsuarioEntity> usuarios = [];

  @override
  void onReady() async {
    super.onReady();
    getUsuarios();
  }

  void goToAgregarUsuario() async {
    final result = await Get.to<UsuarioEntity>(() => AgregarUsuarioPage());
    if (result != null) {
      usuarios.add(result);
      update();
    }
  }

  Future<void> getUsuarios() async {
    showLoading();
    Result<List<UsuarioEntity>> resultType =
        await listarUsuariosUseCase.execute();
    switch (resultType) {
      case Success<List<UsuarioEntity>>():
        usuarios = resultType.value;
        update();
        break;
      case Error():
        ErrorEntity error = resultType.error;
        Get.snackbar(error.title, error.description);
    }
    hideLoading();
    update();
  }
}
