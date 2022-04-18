import 'package:flutter/material.dart';
import 'package:more_flutter_practice/song.dart';
import 'package:more_flutter_practice/song_card.dart';

import 'info_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController artistController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    artistController.dispose();
    nameController.dispose();
    super.dispose();
  }
  void addNew(){

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Song'),
            ),
            body: ListView(children: [
              Title(title: "Adding Song", color: Colors.blue, child: Column(
               children:  [
                 const Padding(padding: EdgeInsets.all(16.0),),
                 TextField(
                   controller: nameController,
                   decoration: const InputDecoration(
                     border: OutlineInputBorder(),
                     hintText: 'Enter Song Name',
                   ),
                 ),
                 const Padding(padding: EdgeInsets.all(16.0),),
                 TextField(
                   controller: artistController,
                   decoration: const InputDecoration(
                     border: OutlineInputBorder(),
                     hintText: 'Enter Song Artist',
                   ),
                 ),
                 const Padding(padding: EdgeInsets.all(16.0),),
                 ElevatedButton(child: const Text("Add"),
                     onPressed: (){ setState(() {
                       songs.add(Song(name: nameController.text.toString(),
                       artist: artistController.text.toString()));
                 });
                 })
               ]
              ),),
            ]),
          );
        },
      ),
    );

  }

  List<Song> songs = [
    Song(name: 'Untitled', artist: 'The Cure'),
    Song(name: 'One Day', artist: 'UGK'),
    Song(name: 'Ms. Jackson', artist: 'OutKast'),
    Song(name: 'Alright', artist: 'Kendrick Lamar'),
    Song(name: 'Baby', artist: 'Justin Bieber'),
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: addNew,
          )
        ],
      ),
      body: Center(
        child: ListView(
          children: songs.map((e) => SongCard(
              song: e,
              info: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Info(song: e,)
                    )
                );
              },
              delete: (){
                setState(() {
                  songs.remove(e);
                });
              })
          ).toList(),
        ),
      )
    );
  }
}


