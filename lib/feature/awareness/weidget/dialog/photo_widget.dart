import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_photo_provider.dart';
import 'package:kyoumutechou/feature/awareness/provider/tenpu_provider.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class PhotoWidget extends ConsumerWidget {
  const PhotoWidget({required this.kizukiId, super.key});

  final int kizukiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(awarenessPhotoListProvider);

    return state.when(
      loading: () {
        return Container();
      },
      error: (AppException error) {
        return Text('$error');
      },
      loaded: () {
        return _buildPhotoWidget(context, ref);
      },
    );
  }
  
  Widget _buildPhotoWidget(BuildContext context, WidgetRef ref) {
    final tenpuList = ref.watch(tenpuListProvider);

    return Column(
      children: [
        const SizedBox(height: 8),
        if (tenpuList.isNotEmpty)
          Row(
            children: [
              Container(
                width: 88,
                alignment: Alignment.centerRight,
                child: const Text(
                  '写真',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: tenpuList
                      .map(
                        (e) => InkWell(
                          onTap: () => _showFullImage(context, e),
                          child: SizedBox(
                            height: 50,
                            width: 100,
                            child: Image.network(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
      ],
    );
  }

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
}
