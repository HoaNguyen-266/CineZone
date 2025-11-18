// lib/widgets/showtime_selector.dart
import 'package:flutter/material.dart';

class ShowtimeSelector extends StatefulWidget {
  final String cinemaName;
  final List<String> showtimes;
  final Function(String) onTimeSelected;
  final bool isFirst;

  const ShowtimeSelector({
    required this.cinemaName,
    required this.showtimes,
    required this.onTimeSelected,
    required this.isFirst,
  });

  @override
  _ShowtimeSelectorState createState() => _ShowtimeSelectorState();
}

class _ShowtimeSelectorState extends State<ShowtimeSelector> {
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isFirst; // Mở rộng rạp đầu tiên
  }

  @override
  Widget build(BuildContext context) {
    // ... Giữ nguyên nội dung build của ShowtimeSelector từ file main.dart ...
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cinemaName,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '2D PHỤ ĐỀ',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    )
                  ],
                ),
                Row(
                  children: [
                    if (widget.isFirst)
                      Text(
                        '3.5 km',
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    SizedBox(width: 5),
                    Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey.shade600),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.showtimes.map((time) {
                return OutlinedButton(
                  onPressed: () => widget.onTimeSelected(time),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey.shade400),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  child: Text(time),
                );
              }).toList(),
            ),
          ),
        Divider(color: Colors.grey.shade300, thickness: 1),
      ],
    );
  }
}