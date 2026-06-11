import 'package:doctor/Presentation/Reminder/widgets/day_card.dart';
import 'package:doctor/Presentation/Reminder/widgets/select_table_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateReminderPicker extends StatefulWidget {
  const DateReminderPicker({super.key});

  @override
  State<DateReminderPicker> createState() => _DateReminderPickerState();
}

class _DateReminderPickerState extends State<DateReminderPicker> {
  DateTime _selectedDate = DateTime(2026, 3, 15);
  int? _selectedDayOffset;
  String? _selectedPeriod;
  String? _selectedTime;

  final List<String> _periods = [
    '1 Day',
    '5 Day',
    '7 Day',
    '15 Day',
    '1 Month',
  ];

  final List<String> _times = ['03:00 AM', '03:30 AM', '04:00 AM', '04:30 AM'];

  List<DateTime> _getNextDays() {
    final today = DateTime(2026, 3, 12);
    return List.generate(4, (i) => today.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    final days = _getNextDays();

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 0.5.w),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: const Color(0xFF2EAF8A),
                  size: 22.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF888888),
                  size: 22.r,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Day Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(days.length, (index) {
              final day = days[index];
              final isSelected = _selectedDayOffset == index;
              return DayCard(
                day: day,
                isSelected: isSelected,
                onTap: () => setState(() {
                  _selectedDayOffset = index;
                  _selectedDate = day;
                  _selectedPeriod = null;
                }),
              );
            }),
          ),
          SizedBox(height: 24.h),
          // OR Divider
          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFF1A1A2E), thickness: 1)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFF1A1A2E), thickness: 1)),
            ],
          ),
          SizedBox(height: 20.h),
          // Period Chips
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: _periods.map((period) {
              final isSelected = _selectedPeriod == period;
              return SelectableChip(
                label: period,
                isSelected: isSelected,
                onTap: () => setState(() {
                  _selectedPeriod = period;
                  _selectedDayOffset = null;
                }),
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),
          // Time Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _times.map((time) {
                final isSelected = _selectedTime == time;
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SelectableChip(
                    label: time,
                    isSelected: isSelected,
                    onTap: () => setState(() {
                      _selectedTime = time;
                    }),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

