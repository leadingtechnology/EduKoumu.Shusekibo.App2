import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/app/provider/app_start_provider.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/auth/provider/saml_service_provider.dart';
import 'package:kyoumutechou/feature/auth/widget/logout_page.dart';
import 'package:kyoumutechou/feature/auth/widget/sign_in_again_page.dart';
import 'package:kyoumutechou/feature/auth/widget/sign_in_page.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/home/widget/home_page.dart';
import 'package:kyoumutechou/shared/widget/connection_unavailable_widget.dart';
import 'package:kyoumutechou/shared/widget/loading_widget.dart';

class AppStartPage extends ConsumerStatefulWidget  {
  const AppStartPage({super.key});

  @override
  ConsumerState<AppStartPage> createState() => _AppStartPageState();
}

class _AppStartPageState extends ConsumerState<AppStartPage> {
  bool _isInitializing = true;
  
  @override
  void initState() {
    super.initState();
    
    samlLogin();    
  }

  Future<void> samlLogin() async {
    final saml = Boxes.getBox().get('saml').toString();
    if (saml.isNotEmpty && saml == 'saml') {
      await ref.read(authNotifierProvider.notifier).setStateToLoading();

      // Azure Saml ログイン場合、ログインページへ遷移
      var azureTenantID = '';
      if (dotenv.env['Saml_Tenant_ID'] != null) {
        azureTenantID = dotenv.env['Saml_Tenant_ID']!;
      }
      if(azureTenantID.isNotEmpty){
        await ref.read(samlServiceProvider).azureLogin();
      }
    
      // Google Saml ログイン場合、ログインページへ遷移
      var idpid = '';
      if (dotenv.env['idpid'] != null) {
        idpid = dotenv.env['idpid']!;
      }
      if (idpid.isNotEmpty) {
        await ref.read(samlServiceProvider).googleLogin();
      }
    }
    
    //4-2)コールバック関数の実行
    final secret = Boxes.getBox().get('secret').toString();
    if (secret.isNotEmpty && secret != 'null') {
      await ref.read(authNotifierProvider.notifier).samlLogin(secret);
    }    

    setState(() {
      _isInitializing = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const LoadingWidget();
    }

    final state = ref.watch(appStartNotifierProvider);
  
    return state.when(
      data: (data) {
        return data.maybeWhen(
          initial: () => const LoadingWidget(),
          authenticated: () {
            return const HomePage();
          },
          unauthenticated: SignInPage.new,
          
          multipleDantai: SignInPage.new,
          logout: () => const LogoutPage(),
          appErrorPage: () => const SignInAgainPage(),
          
          internetUnAvailable: () => const ConnectionUnavailableWidget(),
          orElse: () => const LoadingWidget(),
        );
      },
      error: (e, st) => const LoadingWidget(),
      loading: () => const LoadingWidget(),
    );
  }
}
