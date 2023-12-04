
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/helpers/widgets/my_spacing.dart';
import 'package:kyoumutechou/helpers/widgets/my_text.dart';

// 出欠（日）widget
class HealthSeatWidget extends ConsumerWidget {
  HealthSeatWidget({super.key});

  final List<Student> studentList = [
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '1',
      name: '学生1',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '2',
      name: '学生2',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '3',
      name: '学生3',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '4',
      name: '学生4',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '5',
      name: '学生5',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '6',
      name: '学生6',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '7',
      name: '学生7',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '8',
      name: '学生8',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '9',
      name: '学生9',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '0',
      name: '学生10',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '11',
      name: '学生11',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '12',
      name: '学生12',
    ),    
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '1',
      name: '学生1',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '2',
      name: '学生2',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '3',
      name: '学生3',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '4',
      name: '学生4',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '5',
      name: '学生5',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '6',
      name: '学生6',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '7',
      name: '学生7',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '8',
      name: '学生8',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '9',
      name: '学生9',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '0',
      name: '学生10',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '11',
      name: '学生11',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '12',
      name: '学生12',
    ),    
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '1',
      name: '学生1',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '2',
      name: '学生2',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '3',
      name: '学生3',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '4',
      name: '学生4',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '5',
      name: '学生5',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '6',
      name: '学生6',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '7',
      name: '学生7',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '8',
      name: '学生8',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '9',
      name: '学生9',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '0',
      name: '学生10',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '11',
      name: '学生11',
    ),
    Student(
      avatarUrl: 'https://picsum.photos/250?image=9',
      studentNumber: '12',
      name: '学生12',
    ),    
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return buildGridView(studentList);
  }
}

Widget buildGridView(List<Student> students) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12,12,12,12),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6, 
        childAspectRatio: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
      ),
      itemCount: students.length,
      itemBuilder: (context, index) {
        return buildGridTile(students[index]);
      },
    ),
  );
}

class Student {
  final String avatarUrl;
  final String studentNumber;
  final String name;
  

  Student(
      {required this.avatarUrl,
      required this.studentNumber,
      required this.name});
}


Widget buildGridTile(Student student) {
  return Container(
    decoration: const BoxDecoration(
      //color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          spreadRadius: 1,
          color: Colors.black26,
          blurRadius: 2,
          offset: Offset(2, 0),
        ),
      ],
    ),
    child: Column(
      children: [
        // 上部
        Expanded(
          flex: 5, 
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,0,0,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 10, 0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(student.avatarUrl), 
                  ),
                ), 
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText.bodyMedium(student.studentNumber,fontWeight: 700,),
                      MyText.bodySmall(student.name,fontWeight: 700,), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // 下部
        MySpacing.height(2),
        Expanded(
          flex: 3, // 较小的部分
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('左边'), // 替换为实际数据
                Text('右边'), // 替换为实际数据
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
