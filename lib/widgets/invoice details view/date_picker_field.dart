import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/widgets/home%20view%20widgets/custom_container.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({super.key});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: kBlueAccent,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: IgnorePointer(
                    child: EditableText(
                      textAlign: TextAlign.end,
                      controller: _dateController,
                      focusNode: FocusNode(),
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      cursorColor: Colors.blue,
                      backgroundCursorColor: Colors.transparent,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _selectedDate,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 30),
            const Text('التاريخ'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
