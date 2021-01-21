import 'package:flutter/material.dart';

class CardBOne extends StatelessWidget {
  const CardBOne({
    @required this.child,
    this.opactiy = 0.1,
    this.blurRadius = 5.0,
    this.spreadRadius = 1.0,
    Key key,
  }) : super(key: key);

  final Widget child;
  final double opactiy;
  final double blurRadius;
  final double spreadRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(this.opactiy),
            blurRadius: this.blurRadius, // soften the shadow
            spreadRadius: this.spreadRadius, //extend the shadow
          ),
        ],
      ),
      child: child,
    );
  }
}
