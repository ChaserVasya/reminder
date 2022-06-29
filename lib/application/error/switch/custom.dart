import 'package:reminder/application/error/alert/alerts/common.dart';
import 'package:reminder/application/error/alert/content.dart';
import 'package:reminder/application/error/exception/custom.dart';

AlertDialogContent switchCustomExceptionAlert(CustomException e) {
  return const DevErrorAlert();
}
