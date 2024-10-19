import 'package:flutter/material.dart';
import 'package:meals/models/category_model.dart';
import 'package:meals/screens/meals_screen.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    // $InkWell
    // $GestureDetector
    /*
    When we wrap some widget with InkWell,
    then we can tap on that widget also we get a nice visual feedback,
    but if we wrap some widget with GestureDetector, 
    then also the widget becomes clickable but unlike InkWell we not get a visual feedback.
    */
    return InkWell(
      onTap: () {
        //@ we can also write Navigator.of(context).push(route)
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealsScreen(
                categoryID: category.id,
                title: category.title,
              ),
            ));
      },
      //$splashColor
      // We can set spashColor in InkWell for changing visual tapping effect.
      splashColor: Theme.of(context).primaryColor,
      //$borderRadius
      //Change the borderRadius of that widget (while tapping)
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              end: Alignment.bottomRight,
              begin: Alignment.topLeft,
              colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9)
              ]),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
