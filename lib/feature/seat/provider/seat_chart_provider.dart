import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/feature/seat/provider/seat_setting_provider.dart';
import 'package:kyoumutechou/feature/seat/repository/seat_chart_repository.dart';
import 'package:kyoumutechou/feature/seat/widget/seat_chart_seito_for_stack_widget.dart';

// 一覧表示 or 座席表表示
final seatChartPageTypeProvider = StateProvider<PageType>((ref) {
  return PageType.list; // 初始值
});

// 座席表設定ID(一覧画面から登録したID)
final seatSettingIdProvider = StateProvider<int>((ref) {
  return 0;
});
// 展開フラグ
final isSeatExpandedProvider = StateProvider<bool>((ref) {
  return true;
});
// 教卓フラグ
final lecternPositionProvider = StateProvider<LecternPosition>((ref) {
  return LecternPosition.top;
});

// フォーカスON座席
final seatChartListFocusProvider = StateProvider<int>((ref) {
  return -1;
});
// フォーカスON設定値
final seatChartStackFocusProvider = StateProvider<int>((ref) {
  return 0;
});

// 選択用生徒リスト
final scMeibosListProvider = StateProvider<List<AttendanceMeiboModel>>(
  (ref) {
    return [];
  },
);
// 設定用座席表リスト
final scMeibosStackProvider = StateProvider<List<SeatChartSeitoForStackWidget>>(
  (ref) {
    return [];
  },
);

// final seatChartProvider =
// StateProvider<SeatChartModel>((ref) => const SeatChartModel());

final seatChartListProvider =
    StateNotifierProvider<SeatChartListProvider, ApiState>((ref) {

  return SeatChartListProvider(ref);
});

class SeatChartListProvider extends StateNotifier<ApiState> {
  SeatChartListProvider(
    this.ref, 
  ) : super(const ApiState.loading()) {
    _init();
  }

  final Ref ref;
  late final _seatChartRep = ref.read(seatChartRepositoryProvider);
  late final _meiboRep = ref.read(attendanceMeiboRepositoryProvider);

  final seatSettingBox = Boxes.getSeatSetting();

  Future<void> _init() async {
    //await _fetch(seatSettingId);
    state = const ApiState.loaded();
  }

  // 生徒一覧の操作ファンクション) DB検索処理
  Future<void> fetch(int seatSettingId) async {
    final response = await _seatChartRep.fetch(seatSettingId);
    if (mounted) {
      state = response;
    }
  }

  // 生徒一覧の操作ファンクション) DB更新処理
  Future<void> patch() async {
    final id = ref.read(seatSettingIdProvider);
    final scMeibos = ref.read(scMeibosStackProvider);

    var json = '[';
    for (final w in scMeibos) {
      // ignore: use_string_buffers
      json += '''
{
  "SeatIndex": ${w.seatIndex},
  "SeatNumber": ${w.seatNumber},
  "SeitoSeq": "${w.meibo.studentSeq}"
},
''';
    }
    json += ']';

    await _seatChartRep.patch(id, json);
  }

  // 生徒一覧の操作ファンクション) 設定対象生徒一覧の取得
  Future<List<AttendanceMeiboModel>> getMeibos(
    FilterModel filter,
    DateTime targetDate,
  ) async {
    final response = await _meiboRep.fetch(
      filter,
      0,
      targetDate,
    );

    var meibos = <AttendanceMeiboModel>[];

    response.when(
      loaded: () {
        meibos = Boxes.getAttendanceMeibo().values.toList();
      },
      error: (e) {},
      loading: () {},
    );

    return meibos;
  }

  // 生徒Stackの操作ファンクション) 席無しからStackへの設から
  Future<void> setStackSeatWithNoSeat() async {
    final seatSettingId = ref.read(seatSettingIdProvider);

    // 010）フォーカスの取得
    final index = ref.read(seatChartStackFocusProvider);
    if (index < 0) {
      return;
    }

    // 020）設定先座席Widgetの取得先
    final scMeibos = ref.read(scMeibosStackProvider);
    final sc = scMeibos.where((e) => e.seatIndex == index).first;
    if (sc.seatNumber == 0) {
      return;
    }

    // 030）リストのリセット
    if (sc.meibo.studentKihonId! > 0) {
      await addMeibos(sc.meibo);
    }

    // 席無し名簿モデルの取得
    const meibo = AttendanceMeiboModel(
      studentKihonId: -1,
      studentSeq: '-1',
      name: '席無し',
    );

    // 040）Stack席の設定
    scMeibos[index] = SeatChartSeitoForStackWidget(
      seatIndex: index,
      seatNumber: 0,
      meibo: meibo,
    );

    // 050）座席番号の再設定
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;

    // 060）リストのリセット
    //await resetStackFoucse(index: index);
  }

  // 生徒Stackの操作ファンクション) リストからStackへの設から
  Future<void> setStackSeatWithMeibo({
    required AttendanceMeiboModel meibo, // 設定先生徒基本ID
  }) async {
    final seatSettingId = ref.read(seatSettingIdProvider);

    // 010）フォーカスの取得
    final index = ref.read(seatChartStackFocusProvider);
    if (index < 0) {
      return;
    }

    // 020）設定先座席Widgetの取得先
    final scMeibos = ref.read(scMeibosStackProvider);
    final sc = scMeibos.where((e) => e.seatIndex == index).first;

    // 030）リストのリセット
    if (sc.meibo.studentKihonId! > 0) {
      await deleteMeibos(
        kihonId: meibo.studentKihonId!,
        meibo: sc.meibo,
      );
    } else {
      await deleteMeibos(
        kihonId: meibo.studentKihonId!,
      );
    }

    // 040）Stack席の設定
    scMeibos[index] = SeatChartSeitoForStackWidget(
      seatIndex: index,
      seatNumber: sc.seatNumber,
      meibo: meibo,
    );

    // 050）座席番号の再設定
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;

    // 060）リストフォーカスのリセット
  }

  // 生徒Stackの操作ファンクション) Stack席の交換
  Future<void> changeStackSeatWithId({
    required int fromSeatIndex, // 席Index
    required int toSeatIndex, // 席Index
  }) async {
    final seatSettingId = ref.read(seatSettingIdProvider);

    // 010）交換元交換先座席Widgetの取得
    final scMeibos = ref.read(scMeibosStackProvider);

    final scFrom = scMeibos[fromSeatIndex];
    final scTo = scMeibos[toSeatIndex];

    // 020）交換元交換先座席の交換
    scMeibos[toSeatIndex] = SeatChartSeitoForStackWidget(
      seatIndex: scFrom.seatIndex,
      seatNumber: scFrom.seatNumber,
      meibo: scFrom.meibo,
    );

    scMeibos[fromSeatIndex] = SeatChartSeitoForStackWidget(
      seatIndex: scTo.seatIndex,
      seatNumber: scTo.seatNumber,
      meibo: scTo.meibo,
    );

    // 030）座席番号の再設定
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;
    ref.read(seatChartStackFocusProvider.notifier).state = toSeatIndex;
  }
  
  // 生徒Stackの操作ファンクション) Stack席のダブルクリック
  Future<void> doubleClickStackSeat() async {
    final seatSettingId = ref.read(seatSettingIdProvider);

    // 010）フォーカスの取得
    final index = ref.read(seatChartStackFocusProvider);
    if (index < 0) {
      return;
    }

    // 020）設定先座席Widgetの取得先
    final scMeibos = ref.read(scMeibosStackProvider);
    final sc = scMeibos.where((e) => e.seatIndex == index).first;

    // 030）リストのリセット
    if (sc.meibo.studentKihonId! > 0 || sc.meibo.studentKihonId! < 0) {
      if (sc.meibo.studentKihonId! > 0) {
        await addMeibos(sc.meibo);
      }

      // 040）空席の追加
      scMeibos[index] = getStackClearChair(
        index: index,
        seatNumber: sc.seatNumber,
      );
    } else {
      final kihonId = ref.read(seatChartListFocusProvider);

      if (kihonId <= 0) {
        // 040）Stack席の設定
        scMeibos[index] = getStackNoChair(
          index: index,
          seatNumber: sc.seatNumber,
        );
      } else {
        final meibos = ref.read(scMeibosListProvider);
        final meibo = meibos.where((e) => e.studentKihonId == kihonId).first;

        // 040）Stack席の設定
        scMeibos[index] = SeatChartSeitoForStackWidget(
          seatIndex: index,
          seatNumber: sc.seatNumber,
          meibo: meibo,
        );

        // 利用された場合、リストから削除する
        await deleteMeibos(
          kihonId: meibo.studentKihonId!,
        );
      }
    }

    // 050）座席番号の再設定
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;
  }

  // 生徒Stackの操作ファンクション) すべてクリア
  Future<void> clearAll() async {
    final seatSettingId = ref.read(seatSettingIdProvider);

    // すべてのStack設定を取得する
    final scMeibos = ref.read(scMeibosStackProvider);
    for (var i = 0; i < scMeibos.length; i++) {
      final sc = scMeibos[i];

      if (sc.meibo.studentKihonId! > 0) {
        await addMeibos(sc.meibo);

        // 040）空席の追加
        scMeibos[i] = getStackClearChair(
          index: i,
          seatNumber: sc.seatNumber,
        );
      }
    }

    // 050）座席番号の再設定
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;
    ref.read(seatChartStackFocusProvider.notifier).state = 0;

  }

  // 生徒Stackの操作ファンクション) すべて設定
  Future<void> setAll() async {
    final seatSettingId = ref.read(seatSettingIdProvider);
    final scMeibos = ref.read(scMeibosStackProvider);
    final meibos = ref.read(scMeibosListProvider);

    // すべての生徒をリストに追加する
    for (var i = 0; i < scMeibos.length; i++) {
      final sc = scMeibos[i];

      if (sc.meibo.studentKihonId! > 0) {
        meibos.add(sc.meibo);
      }
    }

    meibos.sort((AttendanceMeiboModel a, AttendanceMeiboModel b) {
      var inta = 0;
      try {
        inta = int.parse(a.studentNumber!);
      } catch (e) {
        inta = 0;
      }

      if (inta == 0) {
        return -1;
      }

      var intb = 0;
      try {
        intb = int.parse(b.studentNumber!);
      } catch (e) {
        intb = 0;
      }

      return inta.compareTo(intb);
    });

    for (var i = 0; i < scMeibos.length; i++) {
      if (meibos.length > i) {
        scMeibos[i] = SeatChartSeitoForStackWidget(
          seatIndex: i,
          seatNumber: i + 1,
          meibo: meibos[i],
        );
      }else{
        scMeibos[i] = getStackClearChair(
          index: i,
          seatNumber: i + 1,
        );
      }
    }

    // 050）座席番号の再設定
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    ref.read(scMeibosStackProvider.notifier).state = newScMeibos;
    ref.read(seatChartStackFocusProvider.notifier).state = 0;


    final maxLength =
        meibos.length > scMeibos.length ? scMeibos.length : meibos.length; 
    meibos.removeRange(0, maxLength);
    ref.read(scMeibosListProvider.notifier).state = meibos.toList();
    ref.read(seatChartListFocusProvider.notifier).state = 0;

  }

  // 生徒Stackの操作ファンクション) 座席番号のリセット
  Future<List<SeatChartSeitoForStackWidget>> resetSeatNumber(
    int seatSettingId,
    List<SeatChartSeitoForStackWidget> scMeibos,
  ) async {
    final newScMeibos = <SeatChartSeitoForStackWidget>[];

    // 010) 座席表パターン情報の取得
    final setting = seatSettingBox.get(seatSettingId)!;
    final m = setting.row ?? 0;
    final n = setting.column ?? 0;
    final seatOrder = setting.seatOrder ?? 0;

    // 020) 席無しのインデックスリストを取得する。
    final noSeatList = scMeibos
        .where(
          (e) => e.meibo.studentKihonId! < 0,
        )
        .toList()
        .map((e) => e.seatIndex)
        .toList();

    // 030) 座席番号のリセット
    for (var i = 0; i < m * n; i++) {
      // 031) 座席番号の設定
      var seatNumber = 0;

      switch (seatOrder) {
        case 1: // 横方向：左から右
          seatNumber = i + 1;
        case 2: // 横方向：右から左
          seatNumber = (i / n).floor() * n + n - (i % n);
        case 3: // 縦方向：上から下
          seatNumber = (i % n) * m + (i / n).floor() + 1;
        case 4: // 縦方向：下から上
          seatNumber = (i % n) * m + m - (i / n).floor();
      }

      // 戻り値作成する
      if (scMeibos.length > i) {
        if (noSeatList.isNotEmpty && noSeatList.contains(i)) {
          newScMeibos.add(
            SeatChartSeitoForStackWidget(
              seatIndex: i,
              seatNumber: 0,
              meibo: scMeibos[i].meibo,
            ),
          );
        } else {
          newScMeibos.add(
            SeatChartSeitoForStackWidget(
              seatIndex: i,
              seatNumber: seatNumber,
              meibo: scMeibos[i].meibo,
            ),
          );
        }
      } else {
        newScMeibos.add(
          getStackClearChair(
            index: i,
            seatNumber: seatNumber,
          ),
        );
      }
    }

    newScMeibos.sort((a, b) => a.seatNumber.compareTo(b.seatNumber));
    var seatNumber = 0;
    for (var i = 0; i < newScMeibos.length; i++) {
      if (newScMeibos[i].seatNumber > 0 ||
          newScMeibos[i].meibo.studentKihonId! > 0) {
        seatNumber++;

        final nsc = newScMeibos[i];
        newScMeibos[i] = SeatChartSeitoForStackWidget(
          seatIndex: nsc.seatIndex,
          seatNumber: seatNumber,
          meibo: nsc.meibo,
        );
      }
    }

    newScMeibos.sort((a, b) => a.seatIndex.compareTo(b.seatIndex));
    return newScMeibos;
  }

  // 生徒Stackの操作ファンクション) フォーカスのリセット
  Future<void> resetStackFoucse_misiyo({int? index}) async {
    //final index = _ref.read(seatChartStackFocusProvider);
    final scMeibos = ref.read(scMeibosStackProvider);

    final scMeibo = scMeibos.where((e) => e.seatIndex == index).first;


    // ignore: cascade_invocations
    if (scMeibo.seatNumber > 0){
      scMeibos.removeWhere((e) => e.seatNumber < scMeibo.seatNumber);
    }else{
      scMeibos.removeWhere((e) => e.seatNumber <= 0);
    }
    scMeibos.sort((a, b) => a.seatNumber.compareTo(b.seatNumber));

    if (scMeibos.isEmpty) {
      ref.read(seatChartStackFocusProvider.notifier).state = 0;
    } else {
      ref.read(seatChartStackFocusProvider.notifier).state =
          scMeibos[0].seatIndex;
    }
  }

  /*
   * 生徒一覧の操作ファンクション
   */

  // 生徒一覧の操作ファンクション) 削除
  Future<void> deleteMeibos({
    required int kihonId,
    AttendanceMeiboModel? meibo,
  }) async {
    final meibos = ref.read(scMeibosListProvider);

    if (meibo != null) {
      meibos.add(meibo);
    }

    meibos.removeWhere((e) => e.studentKihonId == kihonId);
    ref.read(scMeibosListProvider.notifier).state = meibos.toList();

    await resetMeibosFoucse(kihonId);
  }

  // 生徒一覧の操作ファンクション) 追加
  Future<void> addMeibos(AttendanceMeiboModel meibo) async {
    final meibos = ref.read(scMeibosListProvider);

    // ignore: cascade_invocations
    meibos.add(meibo);
    ref.read(scMeibosListProvider.notifier).state = meibos.toList();

    await resetMeibosFoucse(meibo.studentKihonId!);
  }

  // 生徒一覧の操作ファンクション) フォーカスのリセット
  Future<void> resetMeibosFoucse(int kihonId) async {
    final meiboIndex = ref.read(seatChartListFocusProvider);

    // 席無しの場合、処理を終了する
    if (meiboIndex == -1) return;

    final meibos = ref.read(scMeibosListProvider);

    // ignore: cascade_invocations
    meibos.sort((AttendanceMeiboModel a, AttendanceMeiboModel b) {
      var inta = 0;
      try {
        inta = int.parse(a.studentNumber!);
      } catch (e) {
        inta = 0;
      }

      if (inta == 0) {
        return -1;
      }

      var intb = 0;
      try {
        intb = int.parse(b.studentNumber!);
      } catch (e) {
        intb = 0;
      }

      return inta.compareTo(intb);
    });

    var meibo = const AttendanceMeiboModel(
      studentKihonId: 0,
      studentSeq: '0',
      name: '空席',
    );

    try {
      meibo = meibos.first;
    } catch (e) {
      //
    }

    if (meibo.studentKihonId! > 0) {
      ref.read(seatChartListFocusProvider.notifier).state =
          meibo.studentKihonId!;
    } else {
      ref.read(seatChartListFocusProvider.notifier).state = 0;
    }
  }
}
