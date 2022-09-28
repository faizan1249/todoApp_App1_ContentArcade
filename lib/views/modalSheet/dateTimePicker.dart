import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_day1/viewModel/dateTimePickerViewModel.dart';
import 'package:provider/provider.dart';

class DateTimePicker extends StatefulWidget {
  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    DateTimePickerViewModel dateTimePickerViewModel =
        Provider.of<DateTimePickerViewModel>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton.icon(
              onPressed: () async {
                print("Date Picker");
                await dateTimePickerViewModel.selectDate(context);
                dateTimePickerViewModel.setshowDateStatus = true;
              },
              icon: Icon(Icons.calendar_today_rounded),
              label: const Text("Select Date")),
        ),
        dateTimePickerViewModel.getShowDateStatus == true
            ? Center(
                child: Text(dateTimePickerViewModel.getSelectedDate
                    .toLocal()
                    .toString()))
            : Center(child: const Text("Please Select Date")),
        Center(
          child: ElevatedButton.icon(
              onPressed: () async {
                print("Time Picker");
                await dateTimePickerViewModel.selectTime(context);
                dateTimePickerViewModel.setShowTimeStatus = true;
              },
              icon: Icon(Icons.calendar_today_rounded),
              label: const Text("Select Time")),
        ),
        dateTimePickerViewModel.getShowTimeStatus == true
            ? Center(
            child: Text(dateTimePickerViewModel.getSelectedTime

                .toString()))
            : Center(child: const Text("Please Select Time")),
      ],
    );
  }
}
