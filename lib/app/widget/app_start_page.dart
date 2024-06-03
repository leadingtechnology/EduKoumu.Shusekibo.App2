import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/app/provider/app_start_provider.dart';
import 'package:kyoumutechou/feature/auth/widget/sign_in_page.dart';
import 'package:kyoumutechou/feature/home/widget/home_page.dart';
import 'package:kyoumutechou/shared/widget/connection_unavailable_widget.dart';
import 'package:kyoumutechou/shared/widget/loading_widget.dart';

class AppStartPage extends ConsumerWidget {
  const AppStartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appStartNotifierProvider);
  
    return state.when(
        data: (data) {
          return data.maybeWhen(
            initial: () => const LoadingWidget(),
            authenticated: () {
              return const HomePage();
            },
            unauthenticated: SignInPage.new,
            internetUnAvailable: () => const ConnectionUnavailableWidget(),
            orElse: () => const LoadingWidget(),
          );
        },
        error: (e, st) => const LoadingWidget(),
        loading: () => const LoadingWidget());
  }
}
