import 'package:flutter/material.dart';

// Default design button BOne
class DropdownButtonbOne extends StatelessWidget {
  const DropdownButtonbOne({
    Key key,
    @required this.dropdownOptions,
    this.isActive = false,
    this.dropdownValue,
    this.color,
    this.minWidth = 160,
  }) : super(key: key);

  final dropdownOptions;
  final Color color;
  final bool isActive;
  final double minWidth;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {},
      items: <String>['Boer', 'Monteur', 'Admin']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
