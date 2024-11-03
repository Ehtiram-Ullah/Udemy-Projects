import 'package:flutter/material.dart';

import 'package:shopping_list/models/category.dart';

final categories = {
  Categories.vegetables: Category(
    'Vegetables',
    const Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: Category(
    'Fruit',
    const Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: Category(
    'Meat',
    const Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: Category(
    'Dairy',
    const Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: Category(
    'Carbs',
    const Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: Category(
    'Sweets',
    const Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: Category(
    'Spices',
    const Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: Category(
    'Convenience',
    const Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: Category(
    'Hygiene',
    const Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: Category(
    'Other',
    const Color.fromARGB(255, 0, 225, 255),
  ),
};
