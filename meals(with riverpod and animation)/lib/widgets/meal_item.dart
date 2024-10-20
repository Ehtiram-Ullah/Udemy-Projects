import 'package:flutter/material.dart';
import 'package:meals/models/meal_model.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // $ clipBehavior
      // We can set clipBehavior on a Card to "Clip.hardEdge",
      //which simply clips this widget
      //(removing any content of child widgets that would go outside of the shape boundaries).
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => MealDetailsScreen(
                    meal: meal,
                  )));
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              //$ FadeInImage
              //FadeInImage is a utility widget that displays an image that's being faded in,
              //so that when the image is loaded,
              //it's not popping in (which can be quite ugly),
              //but it's smoothly faded in.
              child: FadeInImage(
                //$ MemoryImage
                // MemoryImage is a class provided by flutter (a so-called image provider class),
                //which knows how to load a images form memory.
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                //$ BoxFit.cover
                //BoxFit.cover ensures that an image never distorts.
                //Instead, the image is cropped and slightly zoomed in
                //if it doesn't fit into the box otherwise.
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),

            // $ Positioned
            //Positioned widget is used for positioning a widget on top of a widget in a stack.
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black54,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        //$ TextOverflow.ellipsis
                        // If the text will be too long it gonna just output '...' instead of
                        // directly cutting it
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // $ '${some data type}'
                          // This is used to convert any data type to string
                          MealItemTrait(
                              icon: Icons.schedule,
                              lable: '${meal.duration} min'),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.work, lable: complexityText),
                          const SizedBox(
                            width: 12,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money,
                              lable: affordabilityText),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
