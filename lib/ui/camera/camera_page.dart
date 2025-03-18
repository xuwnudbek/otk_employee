import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otk_employee/utils/theme/app_colors.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;

    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    isLoading = true;

    List cameras = await availableCameras();
    CameraDescription camera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back);
    controller = CameraController(camera, ResolutionPreset.medium);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rasmga olish"),
      ),
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
              child: SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(height: 16),
                Expanded(
                  flex: 7,
                  child: CameraPreview(controller),
                ),
                SizedBox(height: 16),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.light,
                            foregroundColor: AppColors.dark,
                            fixedSize: Size.fromRadius(40),
                          ),
                          onPressed: () async {
                            var res = await controller.takePicture();
                            Get.back(result: res.path);
                          },
                          icon: Icon(
                            Icons.camera,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
