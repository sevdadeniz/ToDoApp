// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/data/locale_storage.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widgets/task_list_item.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Task> allTasks;
  CustomSearchDelegate({
    required this.allTasks,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    // Arama kısmının sağ tarafında bulunan ikonları
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query.isEmpty ? null : query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left side of the AppBar
    return GestureDetector(
      child: Icon(Icons.arrow_back),
      onTap: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // arama yapıldaıktan sonra çıkan sonuçları nasıl göstermek istediğimiz. search ikonuna bastıktan sonra
    List<Task> filteredList = allTasks
        .where(
            (gorev) => gorev.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              var oAnkiEleman = filteredList[index];
              var taskNum = (index + 1).toString();
              return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: const Row(
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
                    filteredList.removeAt(index);
                    await locator<LocalStorage>().deleteTask(task: oAnkiEleman);
                  },
                  child: TaskItem(task: oAnkiEleman));
            },
            itemCount: filteredList.length,
          )
        : const Center(child: Text("Sonuç bulunmadı"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // kullanıcı bir iki harf yazdığında veya hiç bir şey yazmadığında görünmesi istenilen

    return Container();
  }
}
