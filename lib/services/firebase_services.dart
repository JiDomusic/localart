// services/firebase_services.dart

import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore bd = FirebaseFirestore.instance;

Future<List> getArtistas() async {
  List artistas = [];
  CollectionReference collectionRefArtistas = bd.collection('artistas');

  QuerySnapshot queryArtistas =
      await collectionRefArtistas.orderBy("nombre").get();

  for (var documento in queryArtistas.docs) {
    Map data = documento.data() as Map;
    data['id'] = documento.id;
    artistas.add(data);
  }
  return artistas;
}
