import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String customFormatDate(DateTime value, String format) {
  try {
    final DateFormat formatter = DateFormat(
      format,
    );
    final formattedDate = formatter.format(value);
    return formattedDate;
  } catch (e) {
    debugPrint(e.toString());
    return "";
  }
}
