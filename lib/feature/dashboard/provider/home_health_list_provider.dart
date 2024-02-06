import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';
import 'package:kyoumutechou/feature/dashboard/model/home_health_model.dart';
import 'package:kyoumutechou/feature/dashboard/repository/home_health_repository.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_health_list_state.dart';
import 'package:kyoumutechou/feature/dashboard/state/home_health_state.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_health_list_provider.g.dart';

final homeTargetDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

@riverpod
class HomeHealthListNotifier extends _$HomeHealthListNotifier {
  
  late final _rep = ref.read(homeHealthRepositoryProvider);
  final box = Boxes.getTokobis();

  @override
  HomeHealthListState build() {
    _fetch();
    return const HomeHealthListState.loading();
  }

  Future<void> _fetch() async {
    final dantaiId = ref.watch(dantaiProvider).id??0;
    if (dantaiId == 0) {
      return;
    }

    // 登校日の取得
    final tokobis = ref.watch(lastTokobisProvider);

    // 非同期処理で最大３日間の生徒情報を取得する。
    final responses = await Future.wait(
      List.generate(tokobis.length, (index) {
        try {
          return _rep.fetch(dantaiId, tokobis[index]);
        } catch (e) {
          return Future.value(
            APIError<String>(
              AppException.errorWithMessage(e.toString()),
            ),
          );
        }
      }),
    );

    // エラー、ローディングの場合、エラーを表示する。
    var isError = false;
    var isLoading = false;
    var errorMessage = '';
    final healthLists = <List<HomeHealthModel>>[[],[],[]];
    for (int i = 0; i < responses.length; i++) {
      final response = responses[i];
      if (response is HomeHealthState) {
        response.when(
          error: (e) {
            isError = true;
            errorMessage = '$errorMessage {e};';
          },
          loading: () {
            isLoading = true;
          },
          loaded: (healthList) {
            healthLists[i] = healthList;
          },
        );
      }
    }
    state = HomeHealthListState.loaded(healthLists);
  }
}
