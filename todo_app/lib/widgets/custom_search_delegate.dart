import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {


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
    // arama yapıldaıktan sonra çıkan sonuçları nasıl göstermek istediğimizi
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // kullanıcı bir iki harf yazdığında veya hiç bir şey yazmadığında görünmesi istenilen
   
 return Container();
  }
}
