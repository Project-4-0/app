import 'package:flutter/material.dart';
import 'package:b_one_project_4_0/models/kpi.dart';
import 'package:b_one_project_4_0/controller/kpiController.dart';

class KPI extends StatefulWidget {
  KPI();

  @override
  State<StatefulWidget> createState() => _KPI();
}

class _KPI extends State<KPI> {
  @override
  void initState() {
    super.initState();
    _getKPI();
  }

  Kpi kpi;

  void _getKPI() {
    KpiController.loadCount().then((kpi) {
      setState(() {
        this.kpi = kpi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: kpi != null
            ? Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //Center Row contents vertically,
                      children: [
                        // Amount of USERS
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 0.75))
                            ],
                          ),
                          child: Row(children: [
                            Container(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.group, size: 35)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Gebruikers", textAlign: TextAlign.left),
                                Text(kpi.userCount.toString(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        color: Theme.of(context).primaryColor),
                                    textAlign: TextAlign.right),
                              ],
                            ),
                          ]),
                        )),

                        SizedBox(width: 10.0),

                        // Amount of BOXEN
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 0.75))
                            ],
                          ),
                          child: Row(children: [
                            Container(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.widgets, size: 35)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              children: [
                                Text("Boxen", textAlign: TextAlign.left),
                                Text(
                                    (kpi.boxCountActive +
                                            kpi.boxCountNoneActive)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        color: Theme.of(context).primaryColor),
                                    textAlign: TextAlign.right),
                              ],
                            ),
                          ]),
                        )),
                      ]),
                  SizedBox(height: 10.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //Center Row contents vertically,
                      children: [
                        // Actieve boxen
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 0.75))
                            ],
                          ),
                          child: Row(children: [
                            Container(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.wifi, size: 35)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              children: [
                                Text("Actieve boxen"),
                                Text(kpi.boxCountActive.toString(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        color: Theme.of(context).primaryColor)),
                                SizedBox(
                                    width: 100.0,
                                    height: 5.0,
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).primaryColor),
                                      value: 1 /
                                          (kpi.boxCountActive +
                                              kpi.boxCountNoneActive) *
                                          kpi.boxCountActive,
                                      minHeight: 2.0,
                                    ))
                              ],
                            ),
                          ]),
                        )),

                        SizedBox(
                          width: 10.0,
                        ),

                        // None Active boxen
                        Expanded(
                            child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 0.75))
                            ],
                          ),
                          child: Row(children: [
                            Container(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.wifi_off, size: 35)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              children: [
                                Text("Inactieve boxen"),
                                Text(kpi.boxCountNoneActive.toString(),
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        color: Theme.of(context).primaryColor)),
                                SizedBox(
                                    width: 100.0,
                                    height: 5.0,
                                    child: LinearProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).primaryColor),
                                      value: 1 /
                                          (kpi.boxCountActive +
                                              kpi.boxCountNoneActive) *
                                          kpi.boxCountNoneActive,
                                      minHeight: 2.0,
                                    ))
                              ],
                            ),
                          ]),
                        )),
                      ]),
                ],
              )
            : CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ));
  }
}
