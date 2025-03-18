import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otk_employee/main.dart';
import 'package:otk_employee/services/http_service.dart';
import 'package:otk_employee/ui/camera/camera_page.dart';
import 'package:otk_employee/ui/working/provider/working_provider.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';
import 'package:otk_employee/utils/widgets/custom_input.dart';
import 'package:otk_employee/utils/widgets/custom_snackbars.dart';
import 'package:provider/provider.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  Map selectedDescriptions = {};
  File? image;

  final TextEditingController commentController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    setState(() {});
  }

  Future<void> addQualityCheck(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    isLoading = true;

    inspect(data);

    var res = await HttpService.upload(
      Api.qualityCheck,
      body: data,
    );

    isLoading = false;

    if (res['status'] == Result.success) {
      CustomSnackbars(context).success("Muvaffaqiyatli bajarildi!");
      Navigator.pop(context, true);
    } else {
      CustomSnackbars(context).error("Qo'shishda xatolik yuz berdi!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Quality Check"),
      ),
      body: SafeArea(
        child: Consumer<WorkingProvider>(builder: (context, provider, _) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                        color: AppColors.light,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: provider.qualityDescriptions.length,
                        itemBuilder: (context, index) {
                          final Map description = provider.qualityDescriptions[index];
                          bool selected = selectedDescriptions[description['id']] ?? false;

                          return ListTile(
                            selectedTileColor: AppColors.light,
                            selected: selected,
                            onTap: () {
                              selectedDescriptions.addAll({description['id']: !selected});
                              setState(() {});
                            },
                            title: Text(
                              "${description['description'] ?? "Nomalum"}",
                            ),
                            trailing: Checkbox(
                              focusColor: AppColors.primary,
                              value: selected,
                              side: BorderSide(
                                color: AppColors.primary,
                              ),
                              onChanged: (value) {
                                selectedDescriptions.addAll({description['id']: !selected});
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                        color: AppColors.light,
                      ),
                      child: CustomInput(
                        lines: 3,
                        size: 90,
                        hint: "Izoh",
                        padding: EdgeInsets.all(8),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: image != null
                                ? GestureDetector(
                                    child: Image.file(image!),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog.fullscreen(
                                            child: Image.file(image!),
                                          );
                                        },
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("Rasm yo`q"),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              var res = await Get.to(() => CameraPage());

                              if (res != null) {
                                image = File(res);
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: AppColors.secondary,
                              ),
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                  ),
                                  Text(
                                    "Rasmga\nolish",
                                    style: TextTheme.of(context).bodySmall,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        Map? orderSubmodel = ((provider.order['order_model']?['submodels'] ?? []) as List).firstOrNull;

                        if (orderSubmodel == null) {
                          CustomSnackbars(context).error("Submodel mavjud emas!");
                          return;
                        }

                        if (image == null) {
                          CustomSnackbars(context).error("Rasmga olinmagan!");
                          return;
                        }

                        if (!selectedDescriptions.values.contains(true)) {
                          CustomSnackbars(context).warning("Birorta ham izoh tanlanmagan!");
                          return;
                        }

                        await addQualityCheck(
                          context,
                          {
                            "order_sub_model_id": orderSubmodel['id'],
                            "status": false,
                            "image": image?.path,
                            "comment": commentController.text,
                            "descriptions": [
                              ...(selectedDescriptions.entries.where((el) => el.value == true)).map((e) => e.key),
                            ],
                          },
                        );
                      },
                      child: Text("Qo'shish"),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: AppColors.dark.withValues(alpha: 0.4),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.light,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
