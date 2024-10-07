import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String artistId;
  final Map<String, dynamic> artistData;

  const DetailPage(
      {super.key, required this.artistId, required this.artistData});

  Future<Map<String, dynamic>> fetchArtistDetails(String artistId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('artists')
        .doc(artistId)
        .get();

    if (snapshot.exists) {
      List<String> imageUrls = [];
      for (int i = 1; i <= 3; i++) {
        String imageUrl = await FirebaseStorage.instance
            .ref('artist_images/$artistId/image_$i.jpg') // Ajusta la ruta
            .getDownloadURL();
        imageUrls.add(imageUrl);
      }

      artistData['imageUrls'] = imageUrls;
      return artistData;
    } else {
      return {}; // O maneja el caso donde el artista no existe
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIO  LOCAL ART ROSARIO'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchArtistDetails(artistId), // detalles
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Biografía
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Text(
                    artistData['bio'] ?? 'No hay biografía disponible',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),

                // Carrusel de Imágenes
                CarouselSlider.builder(
                  itemCount: artistData['imagenes']?.length ?? 0,
                  itemBuilder: (context, index, realIndex) {
                    return Image.network(
                      artistData['imagenes'][index],
                      fit: BoxFit.cover,
                    );
                  },
                  options: CarouselOptions(
                    height: 260,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
