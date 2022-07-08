import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/work_order_page.dart';
import 'pages/freq_asked_questions.dart';
import 'pages/my_task.dart';
import 'data/hive_data_store.dart';
import "models/task.dart";


 MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
   <int, Color>{
    50:  Color(0xFFFFFFFF),
    100:  Color(0xFFFFFFFF),
    200:  Color(0xFFFFFFFF),
    300:  Color(0xFFFFFFFF),
    400:  Color(0xFFFFFFFF),
    500:  Color(0xFFFFFFFF),
    600:  Color(0xFFFFFFFF),
    700:  Color(0xFFFFFFFF),
    800:  Color(0xFFFFFFFF),
    900:  Color(0xFFFFFFFF),
  },
);

Future<void> main() async {
    await Hive.initFlutter();
    // register adapter
    Hive.registerAdapter<Task>(TaskAdapter());
    // open boxes
    var box = await Hive.openBox<Task>('tasks');
    // delete data from previous day
    box.values.forEach((task) {
      if(task.createdAt.day != DateTime.now().day){
        box.delete(task.id);
      }
     });

  runApp(BaseWidget(child: MyApp()));
}

class BaseWidget extends InheritedWidget{
  BaseWidget({required this.child}) : super(child:child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context){
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if(base != null){
      return base;
    }else{
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HouseKeep',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: const MyHomePage(title: 'HouseKeep'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final screens = [
    HomeView(),
    WorkOrderForm(),
    FAQPage(),
  ];
 
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset('assets/hklogo.png', 
        fit: BoxFit.contain,
        height: 32,
        ),
         centerTitle: true,
      ),

      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            label: 'My Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman),
            label: 'Work Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer_outlined),
            label: 'FAQs',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.red[400],
        onTap: (index) => setState(() => currentIndex = index),
      )
      );
  }
  }

