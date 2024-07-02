
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInAgainPage extends ConsumerWidget {
  const SignInAgainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('再度ログインしてください。',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              
              SizedBox(height: 12),
        
              Text('長時間操作をしていない、または、別のブラウザからログアウトした、等により再度ログインが必要です。',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ],
          ),),
      ),
    );
  }
}
