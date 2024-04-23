import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/widget/camera/camera_view.dart';
import 'package:kyoumutechou/feature/common/widget/dialog_util.dart';
import 'package:kyoumutechou/feature/common/widget/media/speech_input.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

class AwarenessDialogLeftWidget extends ConsumerWidget {
  const AwarenessDialogLeftWidget({
    required this.kizukiController,
    super.key,
  });

  final TextEditingController kizukiController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            '気づき',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          MySpacing.height(24),
          
          if (ref.watch(isMicrophoneProvider))
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.microphone),
            onPressed: () async {
              await _handleMic(context, kizukiController);
            },
          ),

          MySpacing.height(24),
          if (ref.watch(isCameraProvider))
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.image),
            onPressed: () async {
              await _handleCamera(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<void> _handleMic(
  BuildContext context, 
  TextEditingController kizukiController,
) async {

  await DialogUtil.show(
    context: context,
    builder: (BuildContext context) {
      return SpeechInput(kizukiController: kizukiController);
    },
  );
}
Future<void> _handleCamera(BuildContext context) async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  await DialogUtil.show(
    context: context,
    builder: (BuildContext context) {
      return CameraView(cameras:cameras);
    },
  );
}
