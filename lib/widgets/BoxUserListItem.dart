import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/box.dart';
import 'package:intl/intl.dart';

class BoxUserListItem extends StatelessWidget {
  const BoxUserListItem({
    @required this.onPressed,
    this.onPressedDelete,
    @required this.delete,
    @required this.box, // TODO: Expect to get a full box object !!!
    Key key,
  }) : super(key: key);

  final Box box;
  final GestureTapCallback onPressed;
  final GestureTapCallback onPressedDelete;
  final bool delete;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: this.onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(5),
        // height: 90,
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
                radius: 40.0,
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
              width: 5,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // StartDate
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Theme.of(context).accentColor,
                      size: 16,
                    ),
                    Container(
                        width: delete ? 150.0 : 170.0,
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          DateFormat('dd/MM/yyyy – kk:mm:ss')
                              .format(box.boxUser.startDate),
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                // Comment
                if (box.comment != null &&
                    box.comment != "" &&
                    box.comment != " " &&
                    box.comment.isNotEmpty)
                  Row(
                    children: <Widget>[
                      Container(
                          width: delete ? 150.0 : 170.0,
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            box.comment,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 10),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ],
                  ),
              ],
            )),
            if (delete)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: this.onPressedDelete,
              ),
          ],
        ),
      ),
    );
  }
}
