import 'package:flutter/material.dart';
import 'package:practise/screens/player.dart';

import '../model/category.dart';
import '../services/category-operations.dart';

class Song extends StatefulWidget {
  const Song({Key? key}) : super(key: key);

  @override
  State<Song> createState() => _SongState();
}

// ignore: camel_case_types
class _SongState extends State<Song> {
  get centerTitle => null;
  Widget createCategory(category song) {
    final String sendURL = song.songURL;
    gotoplayerscreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const player(),
          settings: RouteSettings(
            arguments: sendURL,
          ),
        ),
      );
    }

    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Row(
          children: [
            Image.network(song.imageURL, fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  song.name,
                  style: const TextStyle(color: Colors.grey, fontSize: 20.0),
                ),
                Text(
                  song.artist,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 81, 255, 0), fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: gotoplayerscreen,
    );
  }

  List<Widget> createListOfCategories() {
    List<category> categoryList = CategoryOperations.getCategories();
    List<Widget> categories =
        categoryList.map((song) => createCategory(song)).toList();
    return categories;
  }

  Widget createGrid() {
    return SizedBox(
      height: 700,
      child: GridView.count(
        childAspectRatio: 5 / 2,
        mainAxisSpacing: 15,
        children: createListOfCategories(),
        crossAxisCount: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_label
    color:
    const Color.fromARGB(66, 21, 1, 24);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'LOFI BEATS',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: createGrid());
  }
}
