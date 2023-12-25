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
    
    theme = AppTheme.theme;
  }

  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(1)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 0),
              ),
            ],
          ),
          child: Wrap(
            alignment: WrapAlignment.center, // 中央揃え
            spacing: 8, // 水平方向のスペース
            runSpacing: 4, // 垂直方向のスペース
            children: [
              SizedBox(
                  child: Image.asset('assets/images/login_page_picture.png'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,20,20,0),
                child: Form(
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MySpacing.height(8),
                        SizedBox(
                          height: 61,
                          width: 353,
                          child: Image.asset('assets/images/login_page_logo2.png'),
                        ),
                        //MySpacing.height(8),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                          child: MyText.bodyLarge('ログインID', fontWeight: 800),
                        ),
                        Container(
                          height: 40,
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
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(12, 0, 8, 4),
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
                        const SizedBox(height: 36),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
                          child: _widgetSignInButton(context, ref),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetSignInButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 35,
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
