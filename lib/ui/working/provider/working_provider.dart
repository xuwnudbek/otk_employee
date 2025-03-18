import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otk_employee/services/http_service.dart';
import 'package:otk_employee/services/storage_service.dart';
import 'package:otk_employee/ui/camera/camera_page.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';
import 'package:otk_employee/utils/widgets/custom_input.dart';
import 'package:otk_employee/utils/widgets/custom_snackbars.dart';

class WorkingProvider extends ChangeNotifier {
  Map _order = {};
  Map get order => _order;
  set order(value) {
    _order = value;
    notifyListeners();
  }

  Map _qualityCheckResults = {};
  Map get qualityCheckResults => _qualityCheckResults;
  set qualityCheckResults(value) {
    _qualityCheckResults = value;
    notifyListeners();
  }

  List _qualityDescriptions = [];
  List get qualityDescriptions => _qualityDescriptions;
  set qualityDescriptions(value) {
    _qualityDescriptions = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void initialize() async {
    isLoading = true;

    await getOrder();
    await getQualityDescriptions();
    await getQualityCheckResults();

    isLoading = false;
  }

  Future<void> getOrder() async {
    int? orderId = StorageService.read("order_id");

    if (orderId == null) return;

    var res = await HttpService.get("${Api.orders}/$orderId");

    if (res['status'] == Result.success) {
      order = res['data'] ?? {};
    }
  }

  Future<void> getQualityDescriptions() async {
    var res = await HttpService.get(Api.qualityDescription);

    if (res['status'] == Result.success) {
      qualityDescriptions = res['data'];
    }
  }

  Future<bool> addQualityDescription(BuildContext context) async {
    final TextEditingController controller = TextEditingController();

    var res = await showDialog<bool>(
      context: context,
      traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return AlertDialog(
            title: Text("Yangi izoh qo'shish"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomInput(
                  controller: controller,
                ),
              ],
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size.fromHeight(40),
                  backgroundColor: AppColors.light,
                  foregroundColor: AppColors.danger,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Bekor qilish"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size.fromHeight(40),
                  backgroundColor: AppColors.light,
                  foregroundColor: AppColors.primary,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Qo'shish"),
              ),
            ],
          );
        });
      },
    );

    if (res ?? false) {
      var res = await HttpService.post(Api.qualityDescription, {
        "description": controller.text,
      });

      if (res['status'] == Result.success) {
        CustomSnackbars(context).success("Izoh qo'shildi");
        getQualityDescriptions();
        return true;
      } else {
        CustomSnackbars(context).error("Izoh qo'shilmadi");
        return false;
      }
    }

    return res ?? false;
  }

  Future<void> addQualityCheck(
    BuildContext context,
  ) async {
    var can = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Tasdiqlash"),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.light,
                      foregroundColor: AppColors.danger,
                    ),
                    onPressed: () async {
                      Navigator.pop(context, false);
                    },
                    child: Text("Bekor qilish"),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.success.withValues(alpha: 0.1),
                      foregroundColor: AppColors.success,
                    ),
                    onPressed: () async {
                      Navigator.pop(context, true);
                    },
                    child: Text("Tasdiqlash"),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (can != true) return;

    Map? orderSubmodel = ((order['order_model']?['submodels'] ?? []) as List).firstOrNull;

    if (orderSubmodel == null) return;

    var res = await HttpService.post(Api.qualityCheck, {
      "data": jsonEncode({
        "order_sub_model_id": orderSubmodel['id'],
        "status": true,
      }),
    });

    if (res['status'] == Result.success) {
      CustomSnackbars(context).success("Muvaffaqiyatli bajarildi!");
      getQualityCheckResults();
    } else {
      CustomSnackbars(context).error("Qo'shishda xatolik yuz berdi!");
    }
  }

  Future<void> getQualityCheckResults() async {
    Map? orderSubmodel = ((order['order_model']?['submodels'] ?? []) as List).firstOrNull;

    if (orderSubmodel == null) {
      return;
    }

    var res = await HttpService.get(
      Api.qualityCheck,
      param: {
        "order_sub_model_id": orderSubmodel['id'].toString(),
      },
    );

    if (res['status'] == Result.success) {
      qualityCheckResults = res['data'];
    }
  }
}
