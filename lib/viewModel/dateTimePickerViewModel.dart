import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerViewModel with ChangeNotifier {
  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  bool showDate = false;
  bool showTime = false;
  bool showDateTime = false;
  set setSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    notifyListeners();
  }

  DateTime get getSelectedDate => selectedDate;

  set setSelectedTime(TimeOfDay newTime) {
    selectedTime = newTime;
    notifyListeners();
  }

  TimeOfDay get getSelectedTime => selectedTime;

  set setshowDateStatus(bool newStatus) {
    showDate = newStatus;
    notifyListeners();
  }

  bool get getShowDateStatus => showDate;

  set setShowTimeStatus(bool newStatus) {
    showTime = newStatus;
    notifyListeners();
  }

  bool get getShowTimeStatus => showTime;

  set setShowDateTimeStatus(bool newStatus) {
    showDateTime = newStatus;
    notifyListeners();
  }

  bool get getShowDateTimeStatus => showDateTime;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = picked;

      print("Selected Date $selectedDate");
      setSelectedDate = selectedDate;
      notifyListeners();
    }
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      selectedTime = pickedTime;
      print(selectedTime.minute);
      setSelectedTime = selectedTime;
    }
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy-MM-dd HH: ss a').format(dateTime);
    }
  }

  String getTime(TimeOfDay tod) {
    final now = DateTime.now();

    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }
}
