import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/box.dart';

class BoxListItem extends StatelessWidget {
  const BoxListItem({
    @required this.onPressed,
    @required this.box, // TODO: Expect to get a full box object !!!
    Key key,
  }) : super(key: key);

  final Box box;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        // padding: EdgeInsets.all(5),
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
            CircleAvatar(
                radius: 50.0,
                backgroundColor: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Center(
                      child: Text(box.name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)),
                )),
            SizedBox(
              width: 15.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    child: Flexible(
                        child: Text(
                  box.macAddress,
                  style: TextStyle(color: Theme.of(context).accentColor),
                  textAlign: TextAlign.left,
                ))),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     // Icon(
                //     //   Icons.comment,
                //     //   color: Theme.of(context).accentColor,
                //     // ),
                //     Container(
                //         child: Flexible(
                //             child: Text(
                //       box.macAddress,
                //       style: TextStyle(color: Theme.of(context).accentColor),
                //       textAlign: TextAlign.left,
                //     ))),
                //   ],
                // ),
                // Comment
                // if (box.comment != null)
                //   Row(
                //     children: <Widget>[
                //       Icon(
                //         Icons.comment,
                //         color: Theme.of(context).accentColor,
                //       ),
                //       Text(
                //         box.comment,
                //         style: TextStyle(color: Theme.of(context).accentColor),
                //       ),
                //     ],
                //   ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
