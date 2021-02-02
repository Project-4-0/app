import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:intl/intl.dart';

class BoxUserListItem extends StatelessWidget {
  const BoxUserListItem({
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
        height: 90,
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                          textAlign: TextAlign.center)),
                )),
            SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // StartDate
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.today,
                      color: Theme.of(context).accentColor,
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy – kk:mm:ss')
                          .format(box.boxUser.startDate),
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 14),
                    ),
                  ],
                ),
                // Comment
                if (box.comment != null)
                  Row(
                    children: <Widget>[
                      Container(
                          width: 170.0,
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            box.comment,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 10),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
