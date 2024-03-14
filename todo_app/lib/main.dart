import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/locale_storage.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/home_screen.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var taskBox = await Hive.openBox<Task>("tasks"); //kutu açılımı
  for (var task in taskBox.values) {
    //kutudaki değerleri gez
    if (task.createAt.day != DateTime.now().day) {
      //taskın günü ile bugün eşit değilse
      taskBox.delete(task.id);
    }
  }
}

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //uzun süren Run app ten önce çalışılmasını istediğimiz işlemler için
  await setupHive();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo list',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 0)),
      home: const HomeScreen(),
    );
  }
}
