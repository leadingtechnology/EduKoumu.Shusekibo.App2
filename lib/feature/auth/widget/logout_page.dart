import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: Scaffold(
        backgroundColor: const Color(0xFFF0F0F0),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(100, 100, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ログアウト完了',
                style: TextStyle(
                  color: Color(0xFF8B0000),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansJP',
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  '正常にログアウトが完了しました。\nブラウザの [ x ] ボタンを押して、ウィンドウを閉じてください。',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'NotoSansJP',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
