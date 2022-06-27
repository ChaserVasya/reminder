import 'package:firebase_core/firebase_core.dart';

import '../alert/common.dart';
import '../alert/content.dart';
import 'firebase.dart';

AlertDialogContent switchExceptionAlert(Object e) {
  if (e is FirebaseException) {
    return switchFirebaseExceptionAlert(e);
  }

  return const DevErrorAlert();
}
