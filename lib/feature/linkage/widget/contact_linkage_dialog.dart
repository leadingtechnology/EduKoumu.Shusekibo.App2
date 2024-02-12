
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/linkage/model/contact_linkage_model.dart';
import 'package:kyoumutechou/feature/linkage/provider/contact_linkage_provider.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_confirm_button.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_list_Item.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class ContactLinkageDialog extends  ConsumerWidget {
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
        return _build(context, ref, list);
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
              MySpacing.width(8),
              MyText.bodyLarge(
                '${DateUtil.getJpMonthDayWeek(selectedDate)}の保護者からの連絡',
              ),
              Expanded(child: Container()),
              IconTextButton(
                icon: Icons.arrow_back,
                text: '前の日',
                textPosition: TextPosition.after,
                onPressed: () {
                  ref.read(contactDateProvider.notifier).state =
                      selectedDate.subtract(const Duration(days: 1));
                },
              ),
              MySpacing.width(4),
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
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return ContactListItem(item: item);
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
          borderRadius: BorderRadius.circular(10), // 设置角的弧度为20
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
