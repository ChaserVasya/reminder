import 'package:reminder/application/error/alert/alerts/common.dart';
import 'package:reminder/application/error/alert/content.dart';
import 'package:reminder/application/error/exception/custom.dart';
import 'package:reminder/application/error/switch/custom.dart';

AlertDialogContent switchExceptionAlert(Object e) {
  if (e is CustomException) {
    return switchCustomExceptionAlert(e);
  }

  return const DevErrorAlert();
}
