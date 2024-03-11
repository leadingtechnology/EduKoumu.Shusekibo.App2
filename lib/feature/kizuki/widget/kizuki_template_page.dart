import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/kizuki/provider/kizuki_template_provider.dart';
import 'package:kyoumutechou/feature/kizuki/widget/kizuki_template_dialog.dart';
import 'package:kyoumutechou/feature/kizuki/widget/kizuki_template_list_widget.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

// 気づきテンプレートページ
class KizukiTemplatePage extends ConsumerWidget {
  const KizukiTemplatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: Column(
            children: [
              MySpacing.height(10),
              const Row(
                children: [
                  Text(
                    '気づきテンプレートの設定',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    width: double.infinity,
                    color: Colors.white,

                    child: TextField(
                      onChanged: (value) {
                        kizukiGlobalKey.currentState?.filter(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: theme.colorScheme.onBackground.withAlpha(160),
                        ),
                        filled: true,
                        //fillColor: Colors.yellow[50],
                        hintStyle: TextStyle(
                          color: AppTheme.theme.colorScheme.onBackground
                              .withAlpha(200),
                        ),
                        hintText: '気づきを入力して検索',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: MySpacing.all(4),
                      ),
                      cursorColor: theme.colorScheme.primary,
                    ),
                  ),
                ),
                MySpacing.width(16),
                TextButton.icon(
                  onPressed: () async {
                    final result =  await showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return PopScope(
                          child: KizukiTemplateDialog(),
                        );
                      },
                    );

                    if (result != null && result == '1') {
                      ref.refresh(kizukiTemplateProvider);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('新規追加'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 自定义按钮的弧度
                    ),
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            MySpacing.height(16),
            Expanded(child: KizukiTemplateListWidget(),),
          ],
        ),
      ),
    );
  }
}
