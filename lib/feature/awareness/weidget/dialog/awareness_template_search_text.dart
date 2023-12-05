import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AwarenessTemplateSearchText extends StatelessWidget {
  AwarenessTemplateSearchText({required this.kizukiController, super.key});

  final TextEditingController kizukiController;

  final List<String> _kizukiSchool = [
    '学習している中身に興味を持って、楽しみながら取り組んでいました。',
    '学習に集中することの持続力が、だんだんついてきました。',
    'みんなの前で、自分の考えをしっかりと言えるようになってきました。',
    '友だちと励まし合いながら学習する姿が、数多く見られました。',
    '人の話をじっくりと聞いて、積極的（主体的・自主的）に発言していました。',
    '友だちにやさしい心づかいを見せてくれることが、いっぱいありました。',
    '正直で誠実なくらしぶりには、学級のみんなも見習っていました。',
    '人への思いやりのある言動は、みんなにもよい影響を与えていました。',
    '小さい子のめんどう見もよく、思いやりのある心をいっぱい見せてくれました。',
    '生活全般に、気力の充実と、精神的なたくましさが増してきました。',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: _kizukiSchool,
      onChanged: (String? value){ kizukiController.text = '$value'; },
      //selectedItem: "",
      popupProps: const PopupProps.menu(
        searchFieldProps: TextFieldProps(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
          ),
        ),
        showSearchBox: true,
      ),
    );
  }
}
