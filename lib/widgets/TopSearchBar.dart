import 'package:b_one_project_4_0/widgets/buttons/IconTextLeftButton.dart';
import 'package:b_one_project_4_0/widgets/TextFieldBOne.dart';
import 'package:flutter/material.dart';

// Default design button BOne
class TopSearchBar extends StatelessWidget {
  const TopSearchBar({
    Key key,
    @required this.onPressedRight(),
    @required this.textRight,
    @required this.iconRight,
    this.color,
  }) : super(key: key);

  final GestureTapCallback onPressedRight;
  final String textRight;
  final IconData iconRight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Searchfield
        Expanded(
            child: TextFieldBOne(
          context: context,
          labelText: "Zoek",
          icon: Icon(Icons.search),
        )),

        IconTextLeftButton(
          text: textRight,
          onPressed: onPressedRight,
          icons: iconRight,
          color: color,
        ),
      ],
    );
  }
}
