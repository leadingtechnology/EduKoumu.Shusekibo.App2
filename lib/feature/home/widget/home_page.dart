import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/auth/provider/auth_provider.dart';
import 'package:kyoumutechou/feature/home/provider/books_provider.dart';
import 'package:kyoumutechou/feature/home/widget/row_book_widget.dart';
import 'package:kyoumutechou/shared/http/app_exception.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(
          'Selected Page: 1',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      bottomNavigationBar: NavigationRail(
        selectedIndex: 1,
        //onDestinationSelected: _onItemTapped,
        labelType: NavigationRailLabelType.all,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.favorite),
            selectedIcon: Icon(Icons.favorite_border),
            label: Text('Favorites'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.book),
            selectedIcon: Icon(Icons.book_outlined),
            label: Text('Bookmarks'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.star),
            selectedIcon: Icon(Icons.star_border),
            label: Text('Starred'),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.blueGrey,
  //       title:   Text('home'.tr()),
  //       actions: <Widget>[
  //         IconButton(
  //           icon: const Icon(Icons.logout),
  //           onPressed: () {
  //             //ref.read(routerProvider).go(SignInRoute.path);
  //             ref.read(authNotifierProvider.notifier).logout();
  //           },
  //         ),
  //       ],
  //     ),
  //     body: _widgetContent(context, ref),
  //   );


  Widget _widgetLoading(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('loading'.tr()),
    );
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    final state = ref.watch(booksNotifierProvider);

    return state.when(
      loading: () {
        return _widgetLoading(context, ref);
      },
      booksLoaded: (books) {
        return ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              return RowBookWidget(book: books[index]);
            },);
      },
      error: (AppException error) {
        return _widgetLoading(context, ref);
      },
    );
  }
}
