import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/attendance/model/attendance_meibo_model.dart';
import 'package:kyoumutechou/feature/attendance/repository/attendance_meibo_repository.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/filter_model.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
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
  SeatChartListProvider(this._ref) : super(const ApiState.loading()) {
    _init();
  }

  final Ref _ref;
  late final _seatSettingRep = _ref.read(seatChartRepositoryProvider);
  late final _meiboRep = _ref.read(attendanceMeiboRepositoryProvider);

  final seatSettingBox = Boxes.getSeatSetting();

  Future<void> _init() async {
    //await _fetch(seatSettingId);
    state = const ApiState.loaded();
  }

  Future<void> fetch(int seatSettingId) async {
    final response = await _seatSettingRep.fetch(seatSettingId);
    if (mounted) {
      state = response;
    }
  }

  Future<void> patch() async {
    final id = _ref.read(seatSettingIdProvider);
    final scMeibos = _ref.read(scMeibosStackProvider);

    var json = '[';
    for (final w in scMeibos) {
      json += '''
{
  "SeatIndex": ${w.seatIndex},
  "SeatNumber": ${w.seatNumber},
  "SeitoSeq": "${w.meibo.studentSeq}"
},
''';
    }
    json += ']';

    await _seatSettingRep.patch(id, json);
  }

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
  Future<void> setStackSeatWithNoSeat () async {
    final seatSettingId = _ref.read(seatSettingIdProvider);

    // 010）フォーカスの取得
    final index = _ref.read(seatChartStackFocusProvider);
    if (index < 0) {
      return;
    }

    // 020）設定先座席Widgetの取得先
    final scMeibos = _ref.read(scMeibosStackProvider);
    final sc = scMeibos[index];
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
    _ref.read(scMeibosStackProvider.notifier).state = newScMeibos;

    // 060）リストのリセット

  }
  
  // 生徒Stackの操作ファンクション) リストからStackへの設から
  Future<void> setStackSeatWithMeibo({
    required AttendanceMeiboModel meibo, // 設定先生徒基本ID
  }) async {
    final seatSettingId = _ref.read(seatSettingIdProvider);

    // 010）フォーカスの取得
    final index = _ref.read(seatChartStackFocusProvider);
    if (index < 0) {
      return;
    }

    // 020）設定先座席Widgetの取得先
    final scMeibos = _ref.read(scMeibosStackProvider);
    final sc = scMeibos[index];

    // 030）リストのリセット
    if (sc.meibo.studentKihonId! > 0) {
      await deleteMeibos(
        kihonId: meibo.studentKihonId!,
        meibo: sc.meibo,
      );
    }else{
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
    _ref.read(scMeibosStackProvider.notifier).state = newScMeibos;

    // 060）リストフォーカスのリセット


  }  
  
  // 生徒Stackの操作ファンクション) Stack席の交換
  Future<void> changeStackSeatWithId({
    required int fromSeatIndex, // 席Index
    required int toSeatIndex, // 席Index
  }) async {

  }    
  // 生徒Stackの操作ファンクション) Stack席のダブルクリック
  Future<void> doubleClickStackSeat({
    required int seatSettingId, // 座席表設定ID　席番号の再設定に使用する
    required int seatIndex, // 設定された席Index
  }) async {

  }
  // 生徒Stackの操作ファンクション) Stack席のクリック



  // Stackの設定
  Future<void> setStackSeat({
    required int seatSettingId, // 座席表設定ID　席番号の再設定に使用する
    required int toKihonId, // 設定先生徒基本ID
    required int? fromKihonId, // 設定元生徒基本ID
  }) async {
    // 生徒一覧
    final meibos = _ref.read(scMeibosListProvider);

    // stack 座席表
    final scMeibos = _ref.read(scMeibosStackProvider);
    final seatIndex = _ref.read(seatChartStackFocusProvider);

    // 座席表stackのfocusが設定されていない場合、処理を終了する
    if (seatIndex < 0) {
      return;
    }

    // 010) 設定先座席Widgetの取得
    final sc = scMeibos[seatIndex];

    // クリアの場合
    if (toKihonId <= 0) {
      if (sc.meibo.studentKihonId! > 0) {
        // 生徒一覧に追加
        meibos
          ..add(sc.meibo)
          ..sort((a, b) => a.studentKihonId!.compareTo(b.studentKihonId!));
        _ref.read(scMeibosListProvider.notifier).state = meibos.toList();

        // 座席クリア
        scMeibos[seatIndex] = getStackClearChair(
          index: seatIndex,
          seatNumber: sc.seatNumber,
        );
      } else {
        // 席無しに変更する
        scMeibos[seatIndex] = getStackNoChair(
          index: seatIndex,
          seatNumber: 0,
        );
      }
    } else {
      // 基本IDにより、生徒情報を取得する
      final meibo = meibos.firstWhere(
        (e) => e.studentKihonId == toKihonId,
        orElse: () => const AttendanceMeiboModel(
          studentKihonId: 0,
          studentSeq: '0',
          name: '空席',
        ),
      );

      // 座席情報を設定する
      scMeibos[seatIndex] = SeatChartSeitoForStackWidget(
        seatIndex: seatIndex,
        seatNumber: sc.seatNumber,
        meibo: meibo,
      );
    }

    // 生徒一覧から削除する
    meibos.removeWhere((e) => e.studentKihonId == toKihonId);
    _ref.read(scMeibosListProvider.notifier).state = meibos.toList();

    await resetMeibosFoucse(toKihonId);

    // 席無し設定された場合、座席番号の再設定を行う
    final newScMeibos = await resetSeatNumber(
      seatSettingId,
      scMeibos,
    );
    _ref.read(scMeibosStackProvider.notifier).state = newScMeibos;

    // フォーカスのリセット
    await resetStackFoucse(seatIndex);
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
        newScMeibos[i].seatNumber = seatNumber;
      }
    }

    newScMeibos.sort((a, b) => a.seatIndex.compareTo(b.seatIndex));
    return newScMeibos;
  }

  // 生徒Stackの操作ファンクション) フォーカスのリセット
  Future<void> resetStackFoucse(int? index) async {
    final index = _ref.read(seatChartStackFocusProvider);
    final scMeibos = _ref.read(scMeibosStackProvider);

    // インデックスが指定された場合、そのインデックスにフォーカスを設定する
    // if (index != null && index >= 0 ) {
    //   if(index < scMeibos.length){
    //     _ref.read(seatChartStackFocusProvider.notifier).state = index;
    //   }else{
    //     _ref.read(seatChartStackFocusProvider.notifier).state = 0;
    //   }
    //   return;
    // }

    // ignore: cascade_invocations
    scMeibos.sort((a, b) => a.seatNumber.compareTo(b.seatNumber));

    // 空席フォーカスの設定
    var scMeibo = SeatChartSeitoForStackWidget(
      seatIndex: -1,
      seatNumber: 0,
      meibo: const AttendanceMeiboModel(
        studentKihonId: 0,
        studentSeq: '0',
        name: '空席',
      ),
    );

    // 空席場合、処理を終了する
    // try{
    //   scMeibo = scMeibos.where(
    //     (e) => e.seatIndex == index && e.meibo.studentKihonId == 0,
    //   ) .first;
    // }catch(e){
    //   //
    // }

    // scIndexが空席ではない場合、次の席番号を取得する
    if (scMeibo.seatIndex == -1) {
      try {
        final scms = scMeibos
            .where(
              (e) =>
                  e.seatIndex >= index &&
                  e.meibo.studentKihonId == 0 &&
                  e.seatNumber > 0,
            )
            .toList()
          ..sort((a, b) => a.seatNumber.compareTo(b.seatNumber));

        if (scms.isNotEmpty) {
          scMeibo = scms.first;
        }
      } catch (e) {
        //
      }
    }

    // 最初から席番号を取得する
    if (scMeibo.seatIndex == -1) {
      try {
        final scms = scMeibos
            .where(
              (e) => e.meibo.studentKihonId == 0,
            )
            .toList()
          ..sort((a, b) => a.seatNumber.compareTo(b.seatNumber));

        if (scms.isNotEmpty) {
          scMeibo = scms.first;
        }
      } catch (e) {
        //
      }
    }

    if (scMeibo.seatIndex == -1) {
      _ref.read(seatChartStackFocusProvider.notifier).state = 0;
    } else {
      _ref.read(seatChartStackFocusProvider.notifier).state = scMeibo.seatIndex;
    }
  }

  // 生徒一覧の操作ファンクション) 削除
  Future<void> deleteMeibos({
    required int kihonId,
    AttendanceMeiboModel? meibo,
  }) async {
    final meibos = _ref.read(scMeibosListProvider);

    if (meibo != null) {
      meibos.add(meibo);
    }

    meibos.removeWhere((e) => e.studentKihonId == kihonId);
    _ref.read(scMeibosListProvider.notifier).state = meibos.toList();

    await resetMeibosFoucse(kihonId);
  }

  // 生徒一覧の操作ファンクション) 追加
  Future<void> addMeibos(AttendanceMeiboModel meibo) async {
    final meibos = _ref.read(scMeibosListProvider);

    // ignore: cascade_invocations
    meibos.add(meibo);
    _ref.read(scMeibosListProvider.notifier).state = meibos.toList();

    await resetMeibosFoucse(meibo.studentKihonId!);
  }

  // 生徒一覧の操作ファンクション) フォーカスのリセット
  Future<void> resetMeibosFoucse(int index) async {
    final meiboIndex = _ref.read(seatChartListFocusProvider);

    // 席無しの場合、処理を終了する
    if (meiboIndex == -1) return;

    final meibos = _ref.read(scMeibosListProvider);

    // ignore: cascade_invocations
    meibos.sort((a, b) => a.studentKihonId!.compareTo(b.studentKihonId!));

    var meibo = const AttendanceMeiboModel(
      studentKihonId: 0,
      studentSeq: '0',
      name: '空席',
    );
    try {
      meibo = meibos.where((e) => e.studentKihonId == index).first;
    } catch (e) {
      //
    }

    if (meibo.studentKihonId! == 0) {
      try {
        meibo = meibos.where((e) => e.studentKihonId! > index).first;
      } catch (e) {
        //
      }
    }

    if (meibo.studentKihonId! == 0) {
      try {
        meibo = meibos.first;
      } catch (e) {
        //
      }
    }

    if (meibo.studentKihonId! > 0) {
      _ref.read(seatChartListFocusProvider.notifier).state =
          meibo.studentKihonId!;
    } else {
      _ref.read(seatChartListFocusProvider.notifier).state = -1;
    }
  }
}
