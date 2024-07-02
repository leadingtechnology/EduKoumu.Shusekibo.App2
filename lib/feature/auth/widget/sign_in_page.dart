import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/auth/widget/dantai_selection_dialog.dart';
import 'package:kyoumutechou/helpers/theme/app_theme.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/string_util.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLoginTypeDialog(context);
    });
  }
  Future<void> _showLoginTypeDialog(BuildContext context,) async{
    
    final dantaiId =
        int.parse(Hive.box<String>('shusekibo').get('dantaiId') ?? '0');

    final userDantaisString =
        Hive.box<String>('shusekibo').get('dantaiList') ?? '';

    final userDantais =
        StringUtil.parseStringToKeyValueList(userDantaisString) ?? [];

    if (userDantais.isNotEmpty && userDantais.length > 1) {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return DantaiSelectionDialog(
            dantaiId: dantaiId,
            dantais: userDantais,
          );
        },
      );
    }
  }  

  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _focusUserId = FocusNode();
  final _focusPassword = FocusNode();
  final _focusLogin = FocusNode();

  bool isProcess = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                    child: Form(
                      key: _formKey,
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            MySpacing.height(8),
                            SizedBox(
                              height: 61,
                              width: 353,
                              child: Image.asset(
                                  'assets/images/login_page_logo2.png',),
                            ),
                            
                            // フォームチェックエラー
                            if (_errorMessage != null)
                            Container(
                              color: Colors.red[50],  
                              padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                              child: Row(
                                children: [
                                    const Icon(Icons.error_outline,
                                        color: Color(0xFFBA1A1A),),
                                    MyText.bodyLarge(
                                      _errorMessage!,
                                      color: const Color(0xFFBA1A1A),
                                      fontSize: 16,
                                    ),
                                ],
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                              child:
                                  MyText.bodyLarge('ログインID', fontWeight: 800),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(12, 0, 8, 4),
                              child: TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: '',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  prefixIcon: Icon(
                                    LucideIcons.user,
                                    size: 20,
                                  ),
                                ),
                                focusNode: _focusUserId,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                // onFieldSubmitted: (value) {
                                //   FocusScope.of(context)
                                //       .requestFocus(_focusPassword);
                                // },
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'ログインIDフィールドが必要です。';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            MySpacing.height(8),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                              child: MyText.bodyLarge('パスワード', fontWeight: 800),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(12, 0, 8, 4),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: '',
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  prefixIcon: Icon(
                                    LucideIcons.lock,
                                    size: 20,
                                  ),
                                ),
                                focusNode: _focusPassword,
                                textInputAction: TextInputAction.next,
                                // onFieldSubmitted: (value) {
                                //   FocusScope.of(context)
                                //       .requestFocus(_focusLogin);
                                // },

                                //cursorColor: customTheme.groceryPrimary,
                                autofocus: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'パスワードフィールドが必要です。';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 26),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 8, 8),
                              child: SizedBox(
                                height: 35,
                                width: double.infinity,
                                child: OutlinedButton(
                                  focusNode: _focusLogin,
                                  onPressed: () {
                                    _errorMessage = null;
                                    setState(() {
                                      isProcess = true;
                                    });

                                    _submitForm(context, ref);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    side:
                                        const BorderSide(color: Colors.black45),
                                    backgroundColor: Colors.grey[200],
                                  ),
                                  child: MyText.bodyLarge('ログイン'),
                                ),
                              ),
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
          if(isProcess)
            ColoredBox(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _submitForm(BuildContext context, WidgetRef ref) async{
    _errorMessage = null;

    if (!_formKey.currentState!.validate()) {
      setState(() {
        isProcess = false;
      });
      return;
    }

    final response = await ref
        .read(authNotifierProvider.notifier)
        .login(_emailController.text, _passwordController.text);
    
    response.when(
      error: (value) {
        if (value is AppExceptionUnauthorized) {
          _errorMessage = 'ログインIDまたはパスワードが無効です。';
        } else {
          _errorMessage = 'システム管理者に問い合わせてください。';
        }
      },
      initial: () {},
      loading: () {},
      loggedIn: () {},
      loggedOut: () {},
      multipleDantai: () {
        _showLoginTypeDialog(context);
      },
      errorPage: () {},
    );
    setState(() {
      isProcess = false;
    });
  }
}
