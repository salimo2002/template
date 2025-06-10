import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';

class TextFieldDate extends StatefulWidget {
  const TextFieldDate({
    super.key,
    required this.date,
    required this.hoursOrYear,
    required this.label,
  });

  final TextEditingController date;
  final bool hoursOrYear;
  final String label;

  @override
  State<TextFieldDate> createState() => _TextFieldDateState();
}

class _TextFieldDateState extends State<TextFieldDate> {
  @override
  void initState() {
    super.initState();
    if (widget.date.text.isEmpty) {
      widget.date.text = widget.hoursOrYear
          ? formatDate(DateTime.now())
          : formatTime(TimeOfDay.now());
    }
  }

  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String formatTime(TimeOfDay time) {
    if (time.hour < 12) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} AM';
    } else {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} PM';
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (picked != null) {
      setState(() {
        widget.date.text = formatDate(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        widget.date.text = formatTime(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.sizeOf(context).width*0.75,
    height: MediaQuery.sizeOf(context).height*0.048,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: widget.date,
          readOnly: true,
          onTap: () => widget.hoursOrYear ? selectDate(context) : _selectTime(context),
          textAlign: TextAlign.right, 
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: FontStyleApp.blueAccent18.copyWith(fontSize: 14),
            fillColor: kWhite,
            filled: true,
            enabledBorder: borderStyle(),
            border: borderStyle(),
            focusedBorder: borderStyle(),
            errorBorder: borderErrorStyle(),
            focusedErrorBorder: borderErrorStyle(),
            errorStyle: const TextStyle(fontWeight: FontWeight.bold),
         
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder borderErrorStyle() {
  return OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(6),
  );
}

OutlineInputBorder borderStyle() {
  return OutlineInputBorder(
    borderSide: BorderSide(color: kBorderTextFieldColor),
    borderRadius: BorderRadius.circular(6),
  );
}