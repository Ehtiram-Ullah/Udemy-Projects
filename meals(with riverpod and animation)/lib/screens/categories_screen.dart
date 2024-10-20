import 'package:flutter/material.dart';
import 'package:meals/models/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate:
              // $ SliverGridDelegateWithFixedCrossAxisCount
              // This is just a fancy way of saying that, "i want x ammount of column in the grid"
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // $ childAspectRation
            //childAspectRation will impact the sizing of those GridView items.
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: availableCategories.map((meal) {
            return CategoryGridItem(
              category: meal,
            );
          }).toList(),
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.bounceInOut)),
              child: child,
            ));
  }
}
