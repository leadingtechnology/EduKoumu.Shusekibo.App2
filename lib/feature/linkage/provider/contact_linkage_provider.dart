import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/model/shozoku_model.dart';
import 'package:kyoumutechou/feature/common/provider/dantais_provider.dart';
import 'package:kyoumutechou/feature/home/provider/home_provider.dart';

import 'package:kyoumutechou/feature/linkage/repository/contact_linkage_repository.dart';
import 'package:kyoumutechou/feature/linkage/state/contact_linkage_state.dart';

final contactDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final contactNavigatorMenu = StateProvider<Menu>((ref) => Menu.health); 
final contactShozokusProvider = StateProvider<List<ShozokuModel>>((ref) => []);

final contactLinkageListProvider =
    StateNotifierProvider.autoDispose<ContactLinkageListProvider, ContactLinkageState>(
        (ref) {
  final targetDate = ref.watch(contactDateProvider);
  final dantaiId = ref.watch(dantaiProvider).id ?? 0;

  return ContactLinkageListProvider(ref, dantaiId, targetDate);
});

class ContactLinkageListProvider extends StateNotifier<ContactLinkageState> {
  ContactLinkageListProvider(
    this.ref,
    this.dantaiId,
    this.targetDate,
  ) : super(const ContactLinkageState.loading()) {
    _init();
  }

  final Ref ref;
  final int dantaiId;
  final DateTime targetDate;

  late final _repository = ref.read(contactLinkageRepositoryProvider);

  Future<void> _init() async {
    await fetch();
  }

  Future<void> fetch() async {
    final response = await _repository.fetch(
      dantaiId,
      targetDate,
    );
    if (mounted) {
      state = response;
    }
  }

  Future<void> patch(int id) async {
    final response = await _repository.patch(
      dantaiId,
      targetDate,
      id,
    );
    state = response;
  }
}
