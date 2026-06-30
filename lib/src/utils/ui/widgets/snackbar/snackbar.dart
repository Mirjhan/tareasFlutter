import 'package:get/get.dart';
import 'package:tarea_flutter/src/utils/ui/widgets/snackbar/type_snackbar_enum.dart';

void showSnackbarError({
  required String message,
  String? title,
}) {
  _showSnackbar(type: TypeSnackbarEnum.error, message: message, title: title);
}

void showSnackbarSuccess({
  required String message,
  String? title,
}) {
  _showSnackbar(type: TypeSnackbarEnum.success, message: message, title: title);
}

void _showSnackbar({
  required TypeSnackbarEnum type,
  required String message,
  String? title,
}) {
  Get.snackbar(
    title ?? type.titulo,
    message,
    backgroundColor: type.color,
  );
}
