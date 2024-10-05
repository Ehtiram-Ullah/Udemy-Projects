import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String title;
  final Color color;

  CategoryModel(
      {required this.id, required this.title, this.color = Colors.orange});
}
