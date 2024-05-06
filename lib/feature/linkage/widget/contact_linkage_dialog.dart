import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/common/widget/clip_shozoku_all.dart';
import 'package:kyoumutechou/feature/linkage/model/contact_linkage_model.dart';
import 'package:kyoumutechou/feature/linkage/provider/contact_linkage_provider.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_list_item.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class ContactLinkageDialog extends ConsumerWidget {
  const ContactLinkageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(contactLinkageListProvider);

    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (AppException e) {
        return Text(e.toString());
      },
      loaded: (list) {
        final contactItems = list.toList();

        // 抽出条件で絞り込む
        final isAll = ref.watch(shozokuAllProvider);
        final shozokuList = ref.watch(shozokuListProvider);
        if (!isAll && contactItems.isNotEmpty ){
          for(final shozoku in shozokuList){
            contactItems.removeWhere((item) => item.shozokuId != shozoku.id);
          }
        }

        // ソート順
        contactItems
          .sort((a, b) {
          // registDateTime 降順
          final dateCompare = b.registDateTime!.compareTo(a.registDateTime!);
          if (dateCompare != 0) return dateCompare;

          // shozokuName 昇順
          final nameCompare = '${a.shozokuName}'.compareTo('${b.shozokuName}');
          if (nameCompare != 0) return nameCompare;

          // shozokuId 昇順
          final idCompare = a.shozokuId!.compareTo(b.shozokuId!);
          if (idCompare != 0) return idCompare;

          // shussekiNo 昇順
            final noCompare =
                (a.shussekiNo ?? '').compareTo(b.shussekiNo ?? '');
            if (noCompare != 0) return noCompare;

          // memberId 昇順
          return a.memberId!.compareTo(b.memberId!);
        });
        return _build(context, ref, contactItems);
      },
    );
  }

  Widget _build(
    BuildContext context,
    WidgetRef ref,
    List<ContactLinkageModel> list,
  ) {
    final selectedDate = ref.watch(contactDateProvider);

    return Dialog(
      surfaceTintColor: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MySpacing.height(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MySpacing.width(4),
              IconTextButton(
                icon: Icons.arrow_back,
                text: '前の日',
                textPosition: TextPosition.after,
                onPressed: () {
                  ref.read(contactDateProvider.notifier).state =
                      selectedDate.subtract(const Duration(days: 1));
                },
                
              ),
              Text(
                '${DateUtil.getJpMonthDayWeek(selectedDate)}の保護者からの連絡',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconTextButton(
                icon: Icons.arrow_forward,
                text: '次の日',
                textPosition: TextPosition.before,
                onPressed: () {
                  ref.read(contactDateProvider.notifier).state =
                      selectedDate.add(const Duration(days: 1));
                },
              ),
              MySpacing.width(4),
            ],
          ),
          const Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(16,8,16,8),
            alignment: Alignment.centerLeft,
            child: ClipShozokuAll(),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return ContactListItem(item: item);
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum TextPosition { before, after }

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    required this.icon,
    required this.text,
    required this.textPosition,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String text;
  final TextPosition textPosition;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Icon(icon),
      const SizedBox(width: 8),
      Text(text),
    ];

    if (textPosition == TextPosition.before) {
      children = children.reversed.toList();
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), 
        ),
        backgroundColor: theme.colorScheme.surface,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}
