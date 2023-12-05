// Copyright 2021, Techaas.com. All rights reserved.
//

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraView extends StatefulWidget {

  const CameraView({
    required this.camera, super.key,
  });
  final CameraDescription camera;

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  late final CameraController _controller;
  late final Future<void> _initializeControllerFuture;

  // Initializes camera controller to preview on screen
  void _initializeCamera() async {
    final CameraController cameraController = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller = cameraController;
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('カメラ'),
          centerTitle: true,
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(child: CameraPreview(_controller));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // try {
            //   await _initializeControllerFuture;
            //   final image = await _controller.takePicture();
            //   debugPrint('Picture: ${image.path}');
            //   await Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => DetectView(
            //         imagePath: image.path,
            //       ),
            //     ),
            //   );
            // } catch (e) {
            //   // If an error occurs, log the error to the console.
            //   debugPrint('Picture Error: Error: ${e}');
            // }
          },
          child: const Icon(Icons.camera_alt),
        ),);
  }
}
