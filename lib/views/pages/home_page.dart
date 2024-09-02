import 'package:flutter/material.dart';
import 'package:h_calender/models/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final focusedDate = ref.watch(focusedDateProvider);

    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: focusedDate,
        currentDay: DateTime.now(),
        selectedDayPredicate: (day) {
          return isSameDay(selectedDate, day);
        },
        locale: 'ja_JP',
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        calendarStyle: CalendarStyle(
            todayTextStyle: TextStyle(
          color: Colors.deepPurpleAccent,
        )),
        onDaySelected: (selectedDay, focusedDay) {
          ref.read(selectedDateProvider.notifier).state = selectedDay;
          ref.read(focusedDateProvider.notifier).state = focusedDay;
        },
      ),
    );
  }
}
