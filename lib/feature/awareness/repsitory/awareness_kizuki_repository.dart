import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_kizuki_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/tenpu_provider.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/feature/common/model/tenpu_input_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/common/provider/filter_provider.dart';
import 'package:kyoumutechou/feature/common/state/api_state.dart';
import 'package:kyoumutechou/shared/http/api_provider.dart';
import 'package:kyoumutechou/shared/http/api_response.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';
import 'package:kyoumutechou/shared/util/image_handler.dart';

// ignore: one_member_abstracts
abstract class AwarenessKizukiRepositoryProtocol {
  Future<ApiState> fetch();
}

final awarenessKizukiRepositoryProvider =
    Provider(AwarenessKizukiRepository.new);

class AwarenessKizukiRepository implements AwarenessKizukiRepositoryProtocol {
  AwarenessKizukiRepository(this.ref);

  final Ref ref;
  final box = Boxes.getAwarenessKizukiModelBox();
  final tenpuBox = Boxes.getTenpuBox();
  final urlBox = Boxes.getImageUrl();
  late final ApiProvider _api = ref.read(apiProvider);

  @override
  Future<ApiState> fetch() async {
    final dantai = ref.read(dantaiProvider);
    final filter = ref.read(filterProvider);

    final strDate =
        DateFormat('yyyy-MM-dd').format(filter.beginDate ?? DateTime.now());
    final endDate =
        DateFormat('yyyy-MM-dd').format(filter.endDate ?? DateTime.now());

    final json = '''
{        
    DantaiId: ${dantai.id},
    Gakunen: ${filter.gakunenCode},
    ShozokuId: ${filter.classId},
    Start: "$strDate",
    End: "$endDate",
    TakeNo: 100,
    PageNo: 1
}
   ''';

    await Boxes.getAwarenessKizukiModelBox().clear();
    final response = await _api.post2('api/kizuki/search', json);

    response.when(
      success: (success) {},
      error: (error) {
        return ApiState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final kizukiValue = value['Value'];
        var kizukiList = awarenessKizukiListFromJson(
          kizukiValue as List<dynamic>,
        );

        // 所属IDのデータのみを抽出する
        kizukiList = kizukiList
            .where((e) => e.shozokuId == filter.classId)
            .toList();

        // 2) save to hive with key
        final _kizukiMap = Map.fromIterables(
          kizukiList.map((e) => '${e.id}').toList(),
          kizukiList.map((e) => e).toList(),
        );

        // 3) save to hive with key
        await Boxes.getAwarenessKizukiModelBox().clear();
        await Boxes.getAwarenessKizukiModelBox().putAll(_kizukiMap);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }

  Future<ApiState> get(int kizukiId) async {
    // 0 の場合は、何もしない
    if (kizukiId == 0) {
      return const ApiState.loaded();
    }

    final response = await _api.get('api/tenpu/$kizukiId');

    response.when(
      success: (success) {},
      error: (error) {
        return ApiState.error(error);
      },
    );

    if (response is APISuccess) {
      final value = response.value;
      try {
        // 1) change response to list
        final tenpuList = tenpuInputListFromJson(value as List<dynamic>);

        // 2) set to hive
        await tenpuBox.clear();
        await urlBox.clear();
        List<String> urls = [];
        // change tenpuList to List<TenpuModel> and save to hive
        for (final tenpu in tenpuList) {
          // final _tenpu = TenpuModel(
          //   tenpuId: tenpu.tenpuId?? 0,
          //   tenpuFileName: '${tenpu.tenpuFileName}',
          //   tenpuFileSize: tenpu.tenpuFileSize?? 0,
          //   tenpuFileData:  base64.decode(tenpu.tenpuFileData ?? ''),
          // );
          //await tenpuBox.put(tenpu.tenpuId, _tenpu);

          if (tenpu.tenpuFileData != null && tenpu.tenpuFileData!.length > 0) {

            final fileData = base64.decode(tenpu.tenpuFileData ?? ''); 
            final url = await ImageHandler.convertUint8ListToBlobUrl(fileData);

            await urlBox.put(tenpu.tenpuId ?? 0, url);
            urls.add(url);
          }
        }

        // tenpuProviderの設定
        ref.read(tenpuListProvider.notifier).addAll(urls);

        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }

  Future<ApiState> patch(int id, String json) async {
    final response = await _api.patch('api/kizuki/$id', json);

    if (response is APISuccess) {
      try {
        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }

  Future<ApiState> delete(AwarenessKizukiModel kizuki, String dt) async {
    final response = await _api.delete(
        'api/kizuki/${kizuki.id}?timestamp=${kizuki.timeStamp}', '',);

    if (response is APISuccess) {
      try {
        return const ApiState.loaded();
      } catch (e) {
        return ApiState.error(AppException.errorWithMessage(e.toString()));
      }
    } else if (response is APIError) {
      return ApiState.error(response.exception);
    } else {
      return const ApiState.loading();
    }
  }
}
