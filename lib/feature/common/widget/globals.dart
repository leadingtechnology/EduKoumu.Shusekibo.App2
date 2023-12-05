library my_app.globals;
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

TabController? tabController;
PlutoGridStateManager? healthStateManager;
PlutoGridStateManager? attendanceStateManager;
PlutoGridStateManager? attendanceTimedStateManager;

List<int> kihonIdList = [6922, 6712, 6711, 6724, 6511, 6530, 6514];

String getPic(int id){
  if (id == 6922) return 'assets/icons/seito2.png';
  if (id == 6712) return 'assets/icons/seito3.png';
  if (id == 6514) return 'assets/icons/seito.png';
  return 'assets/icons/seito1.png';
}
