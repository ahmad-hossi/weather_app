extension DateTimeExtension on DateTime {
   String prettyFormat() {
      final dayName = _getAbbreviatedWeekdayName();
      final monthName = _getMonthName();
      final day = this.day.toString().padLeft(2, '0');
      final time = _getTime();

      return '$dayName, $monthName $day $time';
   }

   String _getAbbreviatedWeekdayName() {
      switch (weekday) {
         case DateTime.monday:
            return 'Mon';
         case DateTime.tuesday:
            return 'Tue';
         case DateTime.wednesday:
            return 'Wed';
         case DateTime.thursday:
            return 'Thu';
         case DateTime.friday:
            return 'Fri';
         case DateTime.saturday:
            return 'Sat';
         case DateTime.sunday:
            return 'Sun';
         default:
            return '';
      }
   }

   String _getMonthName() {
      switch (month) {
         case DateTime.january:
            return 'January';
         case DateTime.february:
            return 'February';
         case DateTime.march:
            return 'March';
         case DateTime.april:
            return 'April';
         case DateTime.may:
            return 'May';
         case DateTime.june:
            return 'June';
         case DateTime.july:
            return 'July';
         case DateTime.august:
            return 'August';
         case DateTime.september:
            return 'September';
         case DateTime.october:
            return 'October';
         case DateTime.november:
            return 'November';
         case DateTime.december:
            return 'December';
         default:
            return '';
      }
   }

   String _getTime() {
      final hour = this.hour == 0 ? 12 : this.hour;
      final minute = this.minute.toString().padLeft(2, '0');
      final period = this.hour < 12 ? 'AM' : 'PM';

      return '$hour:$minute $period';
   }
}