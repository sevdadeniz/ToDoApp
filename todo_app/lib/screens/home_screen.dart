import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo_app/data/locale_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/custom_search_delegate.dart';
import 'package:todo_app/widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Task> _allTasks;
  late LocalStorage _localeStorage;

  @override
  void initState() {
    _localeStorage = locator<LocalStorage>();
    _allTasks = <Task>[];
    _getAllTaskFromDB();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            _showAddTaskButtonSheet();
          },
          child: const Text(
            "Bugün neler yapacaksın?",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showSearchPage();
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _showAddTaskButtonSheet();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                var oAnkiEleman = _allTasks[index];
                var taskNum = (index + 1).toString();
                return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete,
                            size: 24,
                          )
                        ],
                      ),
                    ),
                    key: Key(oAnkiEleman.id),
                    onDismissed: (direction) async {
                      _allTasks.removeAt(index);
                      _localeStorage.deleteTask(task: oAnkiEleman);
                      setState(() {});
                    },
                    child: TaskItem(task: oAnkiEleman));
              },
              itemCount: _allTasks.length,
            )
          : Center(
              child: const Text("Haydi görev ekle"),
            ),
    );
  }

  void _showAddTaskButtonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          width: MediaQuery.of(context).size.width,
          child: ListTile(
            title: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 20),
              decoration: const InputDecoration(
                  hintText: "Görev giriniz", border: InputBorder.none),
              onSubmitted: (value) {
                Navigator.of(context).pop();
                DatePicker.showTimePicker(
                  context,
                  showSecondsColumn: false, // saniye datasının görünmemesi için
                  onConfirm: (time) async {
                    var yeniEklenecekGorev =
                        Task.create(name: value, createAt: time);
                    _allTasks.insert(0, yeniEklenecekGorev);
                    await _localeStorage.addTask(task: yeniEklenecekGorev);
                    setState(() {});
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _getAllTaskFromDB() async {
    _allTasks = await _localeStorage
        .getAllTask(); //hafızada bulunan tüm verileri getirmek için
    setState(() {});
  }

  void _showSearchPage() async {
    await showSearch(
        context: context, delegate: CustomSearchDelegate(allTasks: _allTasks));
    _getAllTaskFromDB();
  }
}
