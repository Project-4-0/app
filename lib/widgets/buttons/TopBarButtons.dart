import 'package:b_one_project_4_0/widgets/buttons/IconTextLeftButton.dart';
import 'package:flutter/material.dart';

// Default design button BOne
class TopBarButtons extends StatelessWidget {
  const TopBarButtons({
    Key key,
    @required this.onPressedLeft(),
    @required this.onPressedRight(),
    @required this.textLeft,
    @required this.textRight,
    @required this.iconLeft,
    @required this.iconRight,
    this.color,
  }) : super(key: key);

  final GestureTapCallback onPressedLeft;
  final GestureTapCallback onPressedRight;
  final String textLeft;
  final String textRight;
  final IconData iconLeft;
  final IconData iconRight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconTextLeftButton(
          text: textLeft,
          onPressed: onPressedLeft,
          icons: iconLeft,
          color: color,
        ),
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
