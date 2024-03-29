import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/awareness/weidget/dialog/awareness_template_search_text.dart';
import 'package:kyoumutechou/feature/kizuki/model/kizuki_template_model.dart';
import 'package:kyoumutechou/feature/kizuki/provider/kizuki_template_provider.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class AwarenessDialogRightWidget extends ConsumerWidget {
  const AwarenessDialogRightWidget({
    required this.kizukiController,
    super.key,
  });

  final TextEditingController kizukiController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kizukiTemplateProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: (list) {
        if (list.isEmpty) {
          return Container();
        }

        return _build(context, ref, list);
      },
    );
  }

  Widget _build(
    BuildContext context,
    WidgetRef ref,
    List<KizukiTemplateModel> list,
  ) {
    final kizukiCommon = list
        .where(
          (e) => e.commonFlg! == true,
        )
        .toList();

    final kizukiPersonal = list
        .where(
          (e) => e.commonFlg! != true,
        )
        .toList();

    return Container(
      width: 300,
      height: 320,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'テンプレート文(学校共通)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          AwarenessTemplateSearchText(
            kizukiController: kizukiController,
            kizukiTemplate:
                kizukiCommon.map((e) => '${e.kizukiTemplate}').toList(),
          ),
          MySpacing.height(12),
          const Text(
            'テンプレート文(個人)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: kizukiPersonal
                    .map(
                      (e) => Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                kizukiController.text = '${e.kizukiTemplate}';
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 0, 4),
                                child: Text(
                                  '${e.title}',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
