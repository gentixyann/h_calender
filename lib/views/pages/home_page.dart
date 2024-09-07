import 'package:flutter/material.dart';
import 'package:h_calender/models/calendar.dart';
import 'package:h_calender/models/dayEvent.dart';
import 'package:h_calender/theme.dart';
import 'package:h_calender/utils/format.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Column(
        children: [
          _TableCalendar(),
          SizedBox(
            height: 30,
          ),
          _DayPageButton(),
        ],
      ),
    );
  }
}

class _TableCalendar extends ConsumerWidget {
  const _TableCalendar();

  List<DayEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final focusedDate = ref.watch(focusedDateProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusedDate,
      currentDay: DateTime.now(),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      locale: 'ja_JP',
      eventLoader: _getEventsForDay,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: const BoxDecoration(
          color: AppTheme.darkGray, // 今日の日付の背景色
          shape: BoxShape.circle, // 形を丸く
        ),
        selectedDecoration: BoxDecoration(
            shape: BoxShape.circle, color: colorScheme.secondary // 選択した日付の背景色
            ),
        todayTextStyle: const TextStyle(
          color: Colors.white, // 今日の日付の文字色
        ),
        selectedTextStyle: const TextStyle(
          color: Colors.black, // 選択した日付の文字色
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        ref.read(selectedDateProvider.notifier).state = selectedDay;
        ref.read(focusedDateProvider.notifier).state = focusedDay;
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          return _CalendarBuildersStack(date: date, events: events);
        },
      ),
    );
  }
}

class _CalendarBuildersStack extends StatelessWidget {
  const _CalendarBuildersStack({
    required this.events,
    required this.date,
  });

  final List events;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      alignment: Alignment.center,
      children: [
        // 日付の背景色をイベントがある場合に変更
        Container(
          width: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: events.isNotEmpty ? colorScheme.primary : null,
          ),
        ),
        // 日付のテキスト
        Center(
          child: Text(
            date.day.toString(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class _DayPageButton extends ConsumerWidget {
  const _DayPageButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        '記録する',
        // formatDate(selectedDate),
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
