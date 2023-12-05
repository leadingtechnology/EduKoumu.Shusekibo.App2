import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyoumutechou/feature/awareness/model/awareness_meibo_model.dart';
import 'package:kyoumutechou/feature/awareness/provider/awareness_meibo_provider.dart';
import 'package:kyoumutechou/feature/awareness/weidget/awareness_seat_widget.dart';
import 'package:kyoumutechou/feature/boxes.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';

import '../../../shared/http/app_exception.dart';


class AwarenessSeatPage extends ConsumerWidget {
  const AwarenessSeatPage({ Key? key}) : super(key: key);

  //final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MySpacing.height(8),
        // search bar
        //AwarenessSearchWidget(scaffoldKey: scaffoldKey),

        // screen
        MySpacing.height(8),
        Expanded(
            child: Column(children: [
          Expanded(
              child: Container(
                color: Colors.grey[100],
                padding: MySpacing.all(16),
                child: AwarenessSeats()
              ),
            ),
          // tools bar
        ])),
      ],
    );
  }
}

class AwarenessSeats extends ConsumerWidget {
  AwarenessSeats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(awarenessMeiboListProvider);

    return state.when(
      loading: () { return Container(); },
      error: (AppException e){ return Container(child: Text('${e.toString()}'),); },
      loaded: (){
        return ValueListenableBuilder(
          valueListenable: Boxes.getAwarenessMeiboBox().listenable(), 
          builder: (context, Box<AwarenessMeiboModel> box, _){
            final List<AwarenessMeiboModel> meibos = box.values.toList();
            
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 2,
              ),
              itemCount: meibos.length,
              itemBuilder: (BuildContext context, int index) {
                return AwarenessSeatWidget(
                  meibo: meibos[index],
                );
              },
            );
          }
        );
      }
    );
  }
}
