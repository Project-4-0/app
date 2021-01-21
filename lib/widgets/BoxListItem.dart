import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/box.dart';


class BoxListItem extends StatelessWidget {
  const BoxListItem({
    @required this.boxText,
    @required this.locationText,
    @required this.onPressed,
    this.box, // TODO: Expect to get a full box object !!!
    Key key,
  }) : super(key: key);

  final String boxText;
  final Box box;
  final String locationText;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(200),
                ),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  )
                ],
              ),
              child: Text(
                box.name!=null?box.name:boxText,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.location_on,
              color: Theme.of(context).accentColor,
            ),
            Text(
              locationText,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
    );
  }
}
