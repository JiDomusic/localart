import 'package:flutter/material.dart';
import 'package:localart/scrennshome/detailpage.dart';
import 'package:localart/services/firebase_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(253, 186, 10, 236),
        title: const Text("LOCAL ART"),
        centerTitle: true,
      ),
      // Add background color to the body
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.black // Set yo.ur desired background color
            ),
        child: FutureBuilder(
          future: getArtistas(), // Assuming you have a function 'getArtistas()'
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                artistData: snapshot.data?[index],
                                artistId: snapshot.data?[index]['id'],
                              ), // Navigate to SecondScreen
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 30),
                          child: ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                          .data?[index]['imagen'] ??
                                      'https://firebasestorage.googleapis.com/v0/b/localart-a7747.appspot.com/o/mariocaporali.jpg?alt=media&token=5a3834a4-7564-414c-8386-eb5a71076379'),
                                  // Replace with your image URL
                                  radius: 70.0),
                              title: Padding(
                                padding: const EdgeInsets.all(19.0),
                                child: Text(
                                  snapshot.data?[index]['nombre'] ?? 'YARA',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 47.0),
                                child: Text(
                                  snapshot.data?[index]['estilo'] ?? 'Artista',
                                  // Reemplaza 'bio' con el nombre del campo en tu Firestore
                                  style: const TextStyle(fontSize: 19),
                                ),
                              )),
                        ));
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
