import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends ConsumerState<SignInPage> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  final _emailController = TextEditingController(text: 'login0001');
  final _passwordController = TextEditingController(text: 'P@ssw0rd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        alignment: Alignment.topCenter,
        child: Wrap(
          alignment: WrapAlignment.center, // 中央揃え
          spacing: 8, // 水平方向のスペース
          runSpacing: 4, // 垂直方向のスペース
          children: [
            SizedBox(
                height: 334,
                width: 572,
                child: Image.asset('assets/images/login_page_picture.png'),
            ),
            Form(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    MySpacing.height(8),
                    SizedBox(
                      height: 61,
                      width: 353,
                      child: Image.asset('assets/images/login_page_logo.png'),
                    ),
                    MySpacing.height(8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                      child: MyText.bodyLarge('ログインID', fontWeight: 800),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 0, 8, 4),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          prefixIcon: Icon(
                            LucideIcons.user,
                            size: 20,
                          ),
                        ),
                        //cursorColor: customTheme.groceryPrimary,
                        autofocus: true,
                      ),
                    ),
                    MySpacing.height(8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                      child: MyText.bodyLarge('パスワード', fontWeight: 800),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          prefixIcon: Icon(
                            LucideIcons.lock,
                            size: 20,
                          ),
                        ),
                        //cursorColor: customTheme.groceryPrimary,
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
                      child: _widgetSignInButton(context, ref),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          ref
              .read(authNotifierProvider.notifier)
              .login(_emailController.text, _passwordController.text);
        },  
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: const BorderSide(color: Colors.black45),
          backgroundColor: Colors.grey[200],
        ),
        child: MyText.bodyLarge('ログイン'),
      ),
    );
  }
}
