import 'package:flutter/material.dart';

class MooMooBeenzCard extends StatefulWidget {
  @override
  _MooMooBeenzCard createState() => _MooMooBeenzCard();
}

class _MooMooBeenzCard extends State<MooMooBeenzCard> {
  List<bool> isSelected = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(child:ToggleButtons(
          children: <Widget> [
            Icon(Icons.favorite),
            Icon(Icons.favorite),
            Icon(Icons.favorite),
            Icon(Icons.favorite),
            Icon(Icons.favorite)
          ],
          selectedColor: Colors.white,
          fillColor: Colors.black,
          splashColor: Colors.black,
          renderBorder: false,
          onPressed: (int index) {
            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = !isSelected[buttonIndex];
                } else {
                  isSelected[buttonIndex] = false;
                }
              }
            });
          },
          isSelected: isSelected
        ))
      )
    );
  }
}