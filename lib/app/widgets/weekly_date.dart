library weekly_date_picker;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';
import 'package:week_of_year/week_of_year.dart';
import "package:weekly_date_picker/datetime_apis.dart";

class WeeklyDate extends StatefulWidget {
  const WeeklyDate({
    super.key,
    required this.selectedDay,
    required this.changeDay,
    this.weekdayText = 'Week',
    this.weekdays = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    this.backgroundColor = const Color(0xFFFAFAFA),
    this.selectedDigitBackgroundColor = const Color(0xFF2A2859),
    this.selectedDigitBorderColor = const Color(0x00000000), // Transparent color
    this.selectedDigitColor = const Color(0xFFFFFFFF),
    this.digitsColor = const Color(0xFF000000),
    this.weekdayTextColor = const Color(0xFF303030),
    this.enableWeeknumberText = false,
    this.weeknumberColor = const Color(0xFFB2F5FE),
    this.weeknumberTextColor = const Color(0xFF000000),
    this.daysInWeek = 7,
    required this.controller,
  }) : assert(weekdays.length == daysInWeek, "weekdays must be of length $daysInWeek");

  final PageController controller;

  /// The current selected day
  final DateTime selectedDay;

  /// Callback function with the new selected date
  final Function(DateTime) changeDay;

  /// Specifies the weekday text: default is 'Week'
  final String weekdayText;

  /// Specifies the weekday strings ['Mon', 'Tue'...]
  final List<String> weekdays;

  /// Background color
  final Color backgroundColor;

  /// Color of the selected day circle
  final Color selectedDigitBackgroundColor;

  /// Color of the border of the selected day circle
  final Color selectedDigitBorderColor;

  /// Color of the selected digit text
  final Color selectedDigitColor;

  /// Color of the unselected digits text
  final Color digitsColor;

  /// Is the color of the weekdays 'Mon', 'Tue'...
  final Color weekdayTextColor;

  /// Set to false to hide the weeknumber textfield to the left of the slider
  final bool enableWeeknumberText;

  /// Color of the weekday container
  final Color weeknumberColor;

  /// Color of the weekday text
  final Color weeknumberTextColor;

  /// Specifies the number of weekdays to render, default is 7, so Monday to Sunday
  final int daysInWeek;

  @override
  _WeeklyDateState createState() => _WeeklyDateState();
}

class _WeeklyDateState extends State<WeeklyDate> {
  final DateTime _todaysDateTime = DateTime.now();

  // About 100 years back in time should be sufficient for most users, 52 weeks * 100
  final int _weekIndexOffset = 520;

  late final DateTime _initialSelectedDay;
  late int _weeknumberInSwipe;

  @override
  void initState() {
    super.initState();
    _initialSelectedDay = widget.selectedDay;
    _weeknumberInSwipe = widget.selectedDay.weekOfYear;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenHeight(context) * .08,
      child: Row(
        children: <Widget>[
          widget.enableWeeknumberText
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  color: widget.weeknumberColor,
                  child: Text(
                    '${widget.weekdayText} $_weeknumberInSwipe',
                    style: TextStyle(color: widget.weeknumberTextColor),
                  ),
                )
              : Container(),
          Expanded(
            child: PageView.builder(
              controller: widget.controller,
              onPageChanged: (int index) {
                setState(() {
                  _weeknumberInSwipe = _initialSelectedDay.addDays(7 * (index - _weekIndexOffset)).weekOfYear;

                  todayDate.value = todayDate.value.add(Duration(days: index > widget.controller.page! ? 7 : -7));
                  widget.changeDay(todayDate.value);

                  startOfWeek.value =
                      dateTimeFromWeekNumber(todayDate.value.year, todayDate.value.weekOfYear - 1, DateTime.monday);

                  endOfWeek.value =
                      dateTimeFromWeekNumber(todayDate.value.year, todayDate.value.weekOfYear, DateTime.sunday)
                          .add(const Duration(hours: 23, minutes: 59, seconds: 59));
                });
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, weekIndex) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _weekdays(weekIndex - _weekIndexOffset),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds a 5 day list of DateButtons
  List<Widget> _weekdays(int weekIndex) {
    List<Widget> weekdays = [];

    for (int i = 0; i < widget.daysInWeek; i++) {
      final int offset = i + 1 - _initialSelectedDay.weekday;
      final int daysToAdd = weekIndex * 7 + offset;
      final DateTime dateTime = _initialSelectedDay.addDays(daysToAdd);
      weekdays.add(_dateButton(dateTime));
    }
    return weekdays;
  }

  Widget _dateButton(DateTime dateTime) {
    final String weekday = widget.weekdays[dateTime.weekday - 1];
    final bool isSelected = dateTime.isSameDateAs(widget.selectedDay);
    final bool isTodaysDate = dateTime.isSameDateAs(_todaysDateTime);

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.changeDay(dateTime),
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                    color: isTodaysDate ? widget.selectedDigitBorderColor : Colors.transparent, shape: BoxShape.circle),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 14.0,
                  child: Text(
                    '${dateTime.day}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: isSelected ? primaryColor : blackColor.shade200),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: AutoSizeText(
                  weekday,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: isSelected ? primaryColor : blackColor.shade200),
                ),
              ),
              if (isSelected) ...[
                Animate(
                  effects: const [FadeEffect(duration: Duration(milliseconds: 800))],
                  child: Container(
                    height: 4,
                    width: 10,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
