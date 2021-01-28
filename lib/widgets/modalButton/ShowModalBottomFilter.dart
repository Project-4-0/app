import 'package:b_one_project_4_0/widgets/buttons/FlatButtonBOne.dart';
import 'package:b_one_project_4_0/widgets/buttons/OutlineFlatButtonBOne.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowModalBottomFilter extends StatefulWidget {
  final GestureTapCallback onPressedFilter;
  final Function(DateTime date) startDateCallBack;
  final Function(DateTime date) endDateCallBack;

  final DateTime startDate;
  final DateTime endDate;

  const ShowModalBottomFilter({
    Key key,
    @required this.onPressedFilter,
    @required this.startDateCallBack,
    @required this.endDateCallBack,
    this.startDate,
    this.endDate,
  }) : super(key: key);

  @override
  _ShowModalBottomFilterState createState() => _ShowModalBottomFilterState();
}

class _ShowModalBottomFilterState extends State<ShowModalBottomFilter> {
  DateTime _startDate;
  DateTime _endDate;

  _ShowModalBottomFilterState() {}

  @override
  void initState() {
    super.initState();
    this._endDate = widget.endDate;
    this._startDate = widget.startDate;
  }

  _selectBeginDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this._startDate == null ? DateTime.now() : this._startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        this._startDate = picked;
        widget.startDateCallBack(picked);
      });
    }
  }

  _selectEndDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this._endDate == null ? DateTime.now() : this._endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        this._endDate = picked;
        widget.endDateCallBack(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              "Filters",
              style: Theme.of(context).textTheme.headline4,
            ),
            Padding(padding: EdgeInsets.all(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlineFlatButtonBOne(
                  text: this._startDate == null
                      ? "Begin datum"
                      : DateFormat("yyyy-MM-dd").format(_startDate),
                  onPressed: () {
                    _selectBeginDate();
                  },
                ),
                Padding(padding: EdgeInsets.all(5)),
                OutlineFlatButtonBOne(
                  text: this._endDate == null
                      ? "Eind datum"
                      : DateFormat("yyyy-MM-dd").format(this._endDate),
                  onPressed: () {
                    _selectEndDate();
                  },
                ),
              ],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FlatButtonBOne(
                        text: "Filters Toevoegen",
                        onPressed: widget.onPressedFilter,
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
