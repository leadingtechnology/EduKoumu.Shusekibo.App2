import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AwarenessTemplateSearchText extends StatelessWidget {
  AwarenessTemplateSearchText({
    required this.kizukiController, 
    required this.kizukiTemplate,
    super.key,
  });

  final TextEditingController kizukiController;

  final List<String> kizukiTemplate ;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: kizukiTemplate,
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
