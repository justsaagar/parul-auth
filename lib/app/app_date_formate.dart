import 'package:intl/intl.dart';

class DateFormatHelper {
  DateFormatHelper._privateConstructor();

  static final DateFormatHelper instance = DateFormatHelper._privateConstructor();

  String? getPrettyDateFormat(DateTime? dateTime) {
    if (dateTime == null) return null;
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime).toLowerCase();
  }
}
