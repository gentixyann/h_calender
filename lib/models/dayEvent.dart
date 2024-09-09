import 'dart:collection';
import 'package:h_calender/utils/format.dart';
import 'package:table_calendar/table_calendar.dart';

class DayEvent {
  final String title;
  const DayEvent(this.title);

  @override
  String toString() => title;
}

// final kEvents = LinkedHashMap<DateTime, List<DayEvent>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);

final kEvents = LinkedHashMap<DateTime, List<DayEvent>>(
  equals: isSameDay,
  hashCode: getHashCode,
)
  ..addAll(_kEventSource)
  ..addAll({
    kToday: List.generate(
      // ここでは、kToday に追加するイベント数を調整できます
      5, // 例として5つのイベントを追加
      (index) {
        final eventDate =
            DateTime.utc(kToday.year, kToday.month, kToday.day + index * 5);
        return DayEvent(
          '${formatDate(eventDate)} Event ${index + 1}', // イベントの日付を追加
        );
      },
    ),
  });

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5): List.generate(
        item % 4 + 1, (index) => DayEvent('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      const DayEvent('Today\'s Event 1'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
