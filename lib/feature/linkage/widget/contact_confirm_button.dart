
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/linkage/provider/contact_linkage_provider.dart';

class ContactConfirmButton extends ConsumerStatefulWidget {
  const ContactConfirmButton({
    required this.id,
    required this.processStatus,
    super.key,
  });

  final int id;
  final String processStatus;

  @override
  ContactConfirmButtonState createState() => ContactConfirmButtonState();
}

class ContactConfirmButtonState extends ConsumerState<ContactConfirmButton> {
  bool isConfirmed = false;
  bool isLoading = false;

  Future<void> confirmAction() async {
    setState(() {
      isLoading = true;
    });

    final response = await ref.read(contactLinkageListProvider.notifier).patch(
      widget.id,
    );

    setState(() {
      isConfirmed = true;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    isConfirmed = widget.processStatus == '1';
    isLoading = false;


    return ElevatedButton(
      onPressed: isLoading || isConfirmed ? null : confirmAction, 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.green.shade50; 
            }
            return isConfirmed ? Colors.green.shade50 : Colors.pink.shade50; 
          },
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text(
              isConfirmed ? '確認済' : '未確認', 
              style: const TextStyle(
                color: Colors.black,
            ),),
    );
  }
}
