import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class PopUp extends StatelessWidget {
  const PopUp({
    // @required this.context,
    @required this.title,
    @required this.message, 
    this.url, 
    this.urlText, 
    Key key,
  }) : super(key: key);

  // final BuildContext context;
  final String title;
  final String message;
  final String url;
  final String urlText;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(this.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              this.message,
              textAlign: TextAlign.left,
              style: TextStyle()),
              if(this.url!=null&&this.urlText!=null)
              SizedBox(
                height: 10.0
              ),
              if(this.url!=null&&this.urlText!=null)
                    GestureDetector(
        onTap: () {
                _openUrl();

        },
        child: Text(this.urlText,
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
      ),
                        
        ],
      ),
      actions: <Widget>[
         FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Sluiten'),
        ),
      ],
    );

  }

Future<void> _openUrl() async {
  if (await canLaunch(this.url)) {
    await launch(this.url);
  } else {
    throw 'Kan de website van VITO niet laden!';
  }
}

}
