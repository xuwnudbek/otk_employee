import 'package:flutter/material.dart';
import 'package:otk_employee/services/http_service.dart';
import 'package:otk_employee/services/storage_service.dart';
import 'package:otk_employee/utils/widgets/custom_snackbars.dart';

class AuthProvider extends ChangeNotifier {
  var loginController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLoading = false;

  Future<bool> authLogin(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    var res = await HttpService.post(Api.login, {
      'username': loginController.text,
      'password': passwordController.text,
    });

    if (res['status'] == Result.success) {
      if (res['data']?['user']?['role']?['name'] != "qualityController") {
        CustomSnackbars(context).warning("Bu dastur faqat \"OTK\" uchun!");
        isLoading = false;
        notifyListeners();
        return false;
      }

      await StorageService.write('token', res['data']['token']);
      await StorageService.write('user', res['data']['user']);

      CustomSnackbars(context).success('Xush kelibsiz!');

      isLoading = false;
      notifyListeners();

      return true;
    } else {
      CustomSnackbars(context).error('Login yoki parol noto\'g\'ri!');

      isLoading = false;
      notifyListeners();

      return false;
    }
  }
}
