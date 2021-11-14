import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/food.dart';

class HomeCard extends StatelessWidget {
  final Food _food;
  HomeCard({Key? key, food: Food})
      : _food = food,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: getCard(_food, context),
      onTap: () {
        print("hello world");
      },
    );
  }

  Card getCard(Food currentFood, BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              currentFood.getImgLink(),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff027353).withOpacity(0.9),
                    ),
                    height: 75,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 135,
                              child: Text(
                                currentFood.getName()["en"] ?? "",
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.remove_red_eye_sharp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
