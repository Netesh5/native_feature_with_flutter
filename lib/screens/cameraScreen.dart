import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_feature/screens/gallaryScreen.dart';

class cameraScreen extends StatefulWidget {
  List<CameraDescription>? camera;
  cameraScreen({this.camera});

  @override
  State<cameraScreen> createState() => _cameraScreenState();
}

class _cameraScreenState extends State<cameraScreen> {
  late CameraController cameraController;
  late Future<void> _initilizeCameraController;
  Color darkthemeColor = Color(0XFF121212);
  XFile? pictureFile;
  List<File> CapturedImage = [];

  int selectedCamera = 0;

  void initializeCamera(selectedCamera) {
    cameraController =
        CameraController(widget.camera![selectedCamera], ResolutionPreset.max);
    _initilizeCameraController = cameraController.initialize();
  }

  @override
  void initState() {
    // TODO: implement initState
    // cameraController = CameraController(
    //   widget.camera![0],
    //   ResolutionPreset.max,
    // );
    initializeCamera(selectedCamera);

    // cameraController.initialize().then((value) {
    //   if (mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!cameraController.value.isInitialized) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // } else {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "camera",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkthemeColor,
      ),
      body: FutureBuilder<void>(
        future: _initilizeCameraController,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              cameraController,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.camera!.length > 1) {
                        setState(() {
                          selectedCamera =
                              selectedCamera == 0 ? 1 : 0; //Switch camera
                          initializeCamera(selectedCamera);
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('No secondary camera found'),
                        ));
                      }
                    },
                    icon: const Icon(Icons.switch_camera_rounded,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () async {
                      pictureFile = await cameraController.takePicture();
                      setState(() {
                        CapturedImage.add(File(pictureFile!.path));
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => gallaryScreen()));
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        image: CapturedImage.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(CapturedImage.last),
                                fit: BoxFit.cover)
                            : null,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      // body: Column(
      //   children: [
      //     SizedBox(
      //       child: CameraPreview(cameraController),
      //       height: MediaQuery.of(context).size.height * 0.8,
      //       width: MediaQuery.of(context).size.width,
      //     ),
      //     InkWell(
      //       onTap: () async {
      //         pictureFile = await cameraController.takePicture();
      //       },
      //       child: Container(
      //         height: 60,
      //         width: 60,
      //         decoration: const BoxDecoration(
      //           shape: BoxShape.circle,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
