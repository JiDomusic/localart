//import 'package:localart/scrennshome/ContactCard.dart'; // Import if neededimport 'package:localart/scrennshome/ContactCard.dart'; // Import if needed
//import 'package:flutter/src/widgets/framework.dart';

class Contact {
  final String bio;
  final String name;
  final String estilo;
  final String imageAsset;
  final List<String> imageURLList;

  Contact({
    required this.bio,
    required this.name,
    required this.estilo,
    required this.imageAsset,
    required this.imageURLList,
  });

  factory Contact.fromFirestore(Map<String, dynamic> data) {
    return Contact(
      name: data['name'],
      bio: data['bio'],
      estilo: data['estilo'],
      imageAsset: data['imageAsset'],
      imageURLList: List<String>.from(data['imageURLList']),
    );
  }
}
