import 'package:shopping_list/models/category.dart';

class GroceryItem {
  final String id;
  final String name;
  final int quantity;
  final Category category;

  GroceryItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.category});
}
