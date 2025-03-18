import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otk_employee/ui/check/check_page.dart';
import 'package:otk_employee/ui/working/provider/working_provider.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';
import 'package:provider/provider.dart';

class WorkingPage extends StatelessWidget {
  const WorkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<WorkingProvider>(
      create: (context) => WorkingProvider()..initialize(),
      builder: (context, snapshot) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Ish sahifasi"),
                elevation: 0,
              ),
              body: Consumer<WorkingProvider>(
                builder: (context, provider, _) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      provider.initialize();
                    },
                    child: provider.isLoading
                        ? Center(
                            child: SizedBox.square(
                              dimension: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : provider.order.isEmpty
                            ? ListView(
                                children: [
                                  SizedBox(
                                    height: constraints.maxHeight * .89,
                                    child: Center(
                                      child: Text("Buyurtma haqida ma'lumot yo'q"),
                                    ),
                                  ),
                                ],
                              )
                            : ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: AppColors.light,
                                          ),
                                          padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      text: 'Model:',
                                                      style: textTheme.bodyMedium,
                                                      children: [
                                                        TextSpan(
                                                          text: ' ${provider.order['order_model']?['model']?['name'] ?? "Unknown"}',
                                                          style: textTheme.titleMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                          text: 'Submodellar:',
                                                          style: textTheme.bodyMedium,
                                                        ),
                                                      ),
                                                      Wrap(
                                                        spacing: 4,
                                                        runSpacing: 4,
                                                        children: [
                                                          for (final submodel in provider.order['order_model']?['submodels'] ?? [])
                                                            Chip(
                                                              padding: EdgeInsets.all(4),
                                                              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                                                              label: Text(
                                                                submodel?['submodel']?['name'] ?? 'Unknown',
                                                                style: textTheme.bodyMedium?.copyWith(
                                                                  color: AppColors.primary,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                          text: 'O\'lchamlar:',
                                                          style: textTheme.bodyMedium,
                                                        ),
                                                      ),
                                                      Wrap(
                                                        spacing: 4,
                                                        runSpacing: 4,
                                                        children: [
                                                          for (final size in provider.order['order_model']?['sizes'] ?? [])
                                                            Chip(
                                                              padding: EdgeInsets.all(4),
                                                              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                                                              label: Text(
                                                                size?['size']?['name'] ?? 'Unknown',
                                                                style: textTheme.bodyMedium?.copyWith(
                                                                  color: AppColors.primary,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${provider.qualityCheckResults['qualityChecksTrue'] ?? 0}",
                                                            style: textTheme.titleLarge?.copyWith(
                                                              fontSize: 50,
                                                              color: AppColors.success,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Sifatli",
                                                            style: textTheme.titleSmall?.copyWith(
                                                              color: AppColors.success,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8),
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              backgroundColor: AppColors.success.withValues(alpha: 0.1),
                                                              fixedSize: Size.fromRadius((constraints.maxWidth / 2 - 32) / 2),
                                                            ),
                                                            onPressed: () async {
                                                              await provider.addQualityCheck(context);
                                                            },
                                                            child: Icon(
                                                              Icons.check_rounded,
                                                              size: (constraints.maxWidth / 2 - 32) / 3,
                                                              color: AppColors.success,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "${provider.qualityCheckResults['qualityChecksFalse'] ?? 0}",
                                                            style: textTheme.titleLarge?.copyWith(
                                                              fontSize: 50,
                                                              color: AppColors.danger,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Sifatsiz",
                                                            style: textTheme.titleSmall?.copyWith(
                                                              color: AppColors.danger,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8),
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              backgroundColor: AppColors.danger.withValues(alpha: 0.1),
                                                              fixedSize: Size.fromRadius((constraints.maxWidth / 2 - 32) / 2),
                                                            ),
                                                            onPressed: () async {
                                                              var res = await Get.to(() {
                                                                return ChangeNotifierProvider.value(
                                                                  value: provider,
                                                                  child: CheckPage(),
                                                                );
                                                              });

                                                              if (res == true) {
                                                                provider.initialize();
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.close_rounded,
                                                              size: (constraints.maxWidth / 2 - 32) / 3,
                                                              color: AppColors.danger,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 16),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: AppColors.light,
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                                child: Row(
                                                  children: [
                                                    Text("Quality Descriptions"),
                                                    Spacer(),
                                                    IconButton(
                                                      style: IconButton.styleFrom(),
                                                      onPressed: () async {
                                                        await provider.addQualityDescription(context);
                                                      },
                                                      icon: Icon(Icons.add),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ListView(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          children: provider.qualityDescriptions.map(
                                            (description) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: ListTile(
                                                  tileColor: AppColors.light,
                                                  title: Text(
                                                    "${description['description'] ?? "Nomalum"}",
                                                  ),
                                                ),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                  );
                },
              ),
              resizeToAvoidBottomInset: false,
            );
          },
        );
      },
    );
  }
}
