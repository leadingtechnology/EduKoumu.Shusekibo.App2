import 'package:kyoumutechou/feature/home/repository/books_repository.dart';
import 'package:kyoumutechou/feature/home/state/books_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'books_provider.g.dart';

@riverpod
class BooksNotifier extends _$BooksNotifier {
  late final BooksRepository _repository = ref.read(booksRepositoryProvider);

  @override
  BooksState build() {
    _fetch();
    return const BooksState.loading();
  }

  Future<void> _fetch() async {
    final response = await _repository.fetch();
    state = response;
  }
}
