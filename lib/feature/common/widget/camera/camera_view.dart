
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/tenpu_provider.dart';
import 'package:kyoumutechou/feature/common/widget/toast_helper.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';

class CameraView extends ConsumerStatefulWidget  {

  const CameraView({
    required this.camera, super.key,
  });
  final CameraDescription camera;

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends ConsumerState<CameraView> {
  late final CameraController _controller;
  late final Future<void> _initializeControllerFuture;

  XFile? imageFile;

  // Initializes camera controller to preview on screen
  Future<void> _initializeCamera() async {
    final cameraController = CameraController(
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

  // 画像を表示する
  void _showFullImage(BuildContext context, String url) {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(url),
        );
      },
    );
  }

  Future<XFile?> takePicture() async {
    final cameraController = _controller;
    if (!cameraController.value.isInitialized) {
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      debugPrint('CameraException: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: const Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () {Navigator.of(context).pop();},
          // ),
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min, // 追加
              children: <Widget>[
                Icon(Icons.arrow_back, size: 20),
                Flexible(
                  child: Text('戻す', overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          title: const Text('カメラ'),
          centerTitle: true,
          
        ),
        body: ColoredBox(
          color: theme.colorScheme.surface,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Center(child: CameraPreview(_controller));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              if(ref.watch(tenpuListProvider).isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Wrap(
                  spacing: 8,
                  //runSpacing: 2,
                  children: ref
                      .watch(tenpuListProvider)
                      .map(
                        (e) => Stack(
                          alignment: Alignment.topRight,
                          children: [
                            // 画像
                            InkWell(
                              onTap: () => _showFullImage(context, e),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(e),
                              ),
                            ),
                            // 削除ボタン
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref.read(tenpuListProvider.notifier).remove(e);
                                ToastHelper.showToast(context, '写真を削除しました');
                              },
                            ),
                        ],),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              await _initializeControllerFuture;

              await takePicture().then((XFile? file) {
                if (file != null) {
                  ref.read(tenpuListProvider.notifier).add(file.path);
                  ToastHelper.showToast(context, '写真を撮りました');
                }
              });
            } catch (e) {
              debugPrint('Picture Error: Error: $e');
            }
          },
          child: const Icon(Icons.camera_alt),
        ),);
  }
}
