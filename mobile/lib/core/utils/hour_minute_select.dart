import 'package:flutter/material.dart';

class HourMinutePicker extends StatefulWidget {
  final ValueChanged<int>? onHourSelected;
  final ValueChanged<int>? onMinuteSelected;

  const HourMinutePicker({Key? key, this.onHourSelected, this.onMinuteSelected})
      : super(key: key);

  @override
  _HourMinutePickerState createState() => _HourMinutePickerState();
}

class _HourMinutePickerState extends State<HourMinutePicker> {
  int _selectedHour = 0;
  int _selectedMinute = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPicker(
          label: 'Hour',
          values: List.generate(24, (index) => index),
          onChanged: (value) {
            setState(() {
              _selectedHour = value;
              widget.onHourSelected?.call(value);
            });
          },
        ),
        _buildPicker(
          label: 'Minute',
          values: List.generate(60, (index) => index),
          onChanged: (value) {
            setState(() {
              _selectedMinute = value;
              widget.onMinuteSelected?.call(value);
            });
          },
        ),
      ],
    );
  }

  Widget _buildPicker(
      {required String label,
      required List<int> values,
      required ValueChanged<int> onChanged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label),
        SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListWheelScrollView(
            itemExtent: 30,
            physics: FixedExtentScrollPhysics(),
            children: values.map((value) {
              return Text(
                value.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 20),
              );
            }).toList(),
            onSelectedItemChanged: (index) {
              onChanged(values[index]);
            },
          ),
        ),
      ],
    );
  }
}
