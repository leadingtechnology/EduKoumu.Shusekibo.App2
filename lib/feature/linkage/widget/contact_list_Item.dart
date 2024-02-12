
import 'package:flutter/material.dart';
import 'package:kyoumutechou/feature/linkage/model/contact_linkage_model.dart';
import 'package:kyoumutechou/feature/linkage/widget/contact_confirm_button.dart';
import 'package:kyoumutechou/shared/util/date_util.dart';

class ContactListItem extends StatefulWidget {
  const ContactListItem({required this.item, super.key});
  final ContactLinkageModel item;

  @override
  ContactListItemState createState() => ContactListItemState();
}

class ContactListItemState extends State<ContactListItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final name = '${widget.item.studentName}:${widget.item.shozokuName}';
    final no = '(${widget.item.shussekiNo})';
    const text = 'の連絡が登録されました。';


    return ListTile(
      leading: const Icon(Icons.campaign_outlined),
      title: RichText(
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
            const TextSpan(text: 'に'),
            TextSpan(
              text: no,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
            ),
            const TextSpan(text: text),
          ],
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
                Text('${widget.item.biko}'),
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
