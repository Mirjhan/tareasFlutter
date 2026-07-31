import 'package:get/get.dart';
import 'package:tarea_flutter/src/usuario/data/repositories/usuarios_repository_implementation.dart';
import 'package:tarea_flutter/src/usuario/domain/entities/usuario_entity.dart';
import 'package:tarea_flutter/src/usuario/domain/use_cases/crear_usuarios_use_case.dart';
import 'package:tarea_flutter/src/utils/core/result_type.dart';
import 'package:tarea_flutter/src/utils/domain/entities/error_entity.dart';
import 'package:tarea_flutter/src/utils/ui/services/loading/loading_service.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/snackbar/snackbar.dart';

class AgregarUsuarioController extends GetxController {
  CrearUsuariosUseCase crearUsuariosUseCase =
      CrearUsuariosUseCase(UsuariosRepositoryImplementation());

  int? idTipoDocumento;
  int? idTipoUsuario;
  String? nombre;
  String? apellidos;
  String? documento;
  String? direccion;
  String? telefono;
  String? email;
  String? password;
  String? pathSelected;

  /*@override
  void onInit() {
    super.onInit();
  }*/

  String? validar() {
    if (nombre == null || nombre!.trim().isEmpty) {
      return 'Nombre es obligatorio';
    }
    if (apellidos == null || apellidos!.trim().isEmpty) {
      return 'Apellidos son obliatorios';
    }
    if (direccion == null || direccion!.trim().isEmpty) {
      return 'Direccion es obligatorio';
    }
    if (telefono == null || telefono!.trim().isEmpty) {
      return 'Telefono es obligatorio';
    }
    if (email == null || email!.trim().isEmpty) {
      return 'Email es obligatorio';
    }
    if (password == null || password!.trim().isEmpty) {
      return 'Password es obligatorio';
    }
    return null;
  }

  void onChangedNombre(String value) {
    nombre = value;
  }

  void onChangedApellidos(String value) {
    apellidos = value;
  }

  void onChangedDocumento(String value) {
    documento = value;
  }

  void onChangedDireccion(String value) {
    direccion = value;
  }

  void onChangedTelefono(String value) {
    telefono = value;
  }

  void onChangedEmail(String value) {
    email = value;
  }

  void onChangedPassword(String value) {
    password = value;
  }

  Future<void> crearUsuario() async {
    String? mensaje = validar();
    if (mensaje != null) {
      showSnackbarError(message: mensaje);
      return;
    } else {
      showLoading();
      final usuario = UsuarioEntity(
          idTipoDocumento: idTipoDocumento!,
          idTipoUsuario: idTipoUsuario!,
          nombre: nombre!,
          apellidos: apellidos!,
          documento: documento!,
          direccion: direccion!,
          telefono: telefono!,
          email: email!,
          password: password!);
      Result<UsuarioEntity> resultType =
          await crearUsuariosUseCase.execute(usuario, pathSelected!);
      hideLoading();

      switch (resultType) {
        case Success<UsuarioEntity>():
          Get.back(result: resultType.value);
          break;
        case Error<UsuarioEntity>():
          ErrorEntity error = resultType.error;
          Get.snackbar(error.title, error.description);
      }
    }
  }
}
