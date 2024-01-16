
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
        
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        decoration: BoxDecoration(
          color: Colors.grey[700], 
          borderRadius: BorderRadius.circular(10), 
        ),
        child: Text(
          message ?? '該当データがありません',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
