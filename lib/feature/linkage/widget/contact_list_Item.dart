import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/gakunen_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/provider/gakunens_provider.dart';
import 'package:kyoumutechou/feature/common/provider/shozokus_provider.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';
import 'package:kyoumutechou/feature/linkage/model/contact_linkage_model.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_confirm_button.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class ContactListItem extends ConsumerStatefulWidget {
  const ContactListItem({required this.item, super.key});
  final ContactLinkageModel item;

  @override
  ContactListItemState createState() => ContactListItemState();
}

class ContactListItemState extends ConsumerState<ContactListItem> {
  bool isExpanded = false;
  final shozokuBox = Boxes.getShozokus();
  final gakunenBox = Boxes.getGakunens();

  @override
  Widget build(BuildContext context) {
    final name = '${widget.item.studentName}:${widget.item.shozokuName}';
    final no = widget.item.shussekiNo!.isEmpty ? '' : '(${widget.item.shussekiNo})';
    final jyokyo = widget.item.renkeiJokyo ?? '';
    final text = widget.item.deleteFlg! == true ? 
    'の連絡が取消されました。': 'の連絡が登録されました。';
    


    return ListTile(
      leading: const Icon(Icons.campaign_outlined),
      title: InkWell(
        onTap: () {
          // 検索条件の取得
          final filter = ref.read(filterProvider);

          // 所属の取得
          var shozoku = ref.read(shozokuProvider);
          try{
            final shozokuId = widget.item.shozokuId ?? 0;
            shozoku = shozokuBox.values
              .toList()
              .where((e) => e.classId == shozokuId)
              .first;
          }catch(e){
            //
          }

          // 学年の取得
          var gakunen = ref.read(gakunenProvider);
          try{
            final organizationKbn = ref.watch(dantaiProvider).organizationKbn;
            final keys = gakunenBox.keys.toList().where(
              (element) => element.toString().startsWith('$organizationKbn-'),
            );
            gakunen = keys.map(gakunenBox.get).toList()
            .where((e) => e?.gakunenCode == shozoku.gakunenCode)
            .first ?? const GakunenModel();
          }catch(e){
            //
          }

          // 検索条件の設定
          ref.read(gakunenProvider.notifier).state = gakunen; 
          ref.read(shozokuProvider.notifier).state = shozoku;
          ref.read(filterProvider.notifier).reset();

          // メニューの遷移
          ref.read(menuProvider.notifier).state = Menu.health;

        },
        child: RichText(
          text:TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              TextSpan(
                text: no,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              const TextSpan(text: 'に'),
              TextSpan(
                text: jyokyo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900],
                ),
              ),
              TextSpan(text: text),
            ],
          ),
        
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(DateUtil.getStringDateWithTime(widget.item.registDateTime)),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ),
            ],
          ),
          
          if (isExpanded) ...[
            const Row(
              children: [
                Text('事由・備考：'),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text(widget.item.biko ?? '')),
              ],
            ),
            const Row(
              children: [
                Text(''),
              ],
            ),
          ],
        ],
      ),
      trailing: ContactConfirmButton(
        id: widget.item.id ?? 0,
        processStatus: '${widget.item.processStatus ?? 0}',
      ),
      isThreeLine: isExpanded,
    );
  }
}

