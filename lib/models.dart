// models.dart
import 'package:flutter/material.dart';

class Comment {
  final String user;
  final String text;
  bool liked;

  Comment({required this.user, required this.text, this.liked = false});
}

class Book {
  final String title;
  final String author;
  final String image;
  final String description;
  double rating;
  List<Comment> comments;

  Book({
    required this.title,
    required this.author,
    required this.image,
    required this.description,
    this.rating = 0.0,
    this.comments = const [],
  });
}
