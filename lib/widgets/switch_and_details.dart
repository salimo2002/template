import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class SwitchAndDetails extends StatelessWidget {
  const SwitchAndDetails({super.key, required this.valueSwitch});

  final ValueNotifier<bool> valueSwitch;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: valueSwitch,
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () {
                  valueSwitch.value = !value;
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border.all(color: kBlueAccent),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Text(
                        'هذا الحساب مورد و عميل معاً',
                        style: TextStyle(
                          color: kBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: getResponsiveText(context, 14),
                        ),
                      ),
                      SizedBox(width: 10),
                      Checkbox(
                        value: value,
                        onChanged: (value) {
                          valueSwitch.value = value!;
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(width: 10),
        Text(
          'المتجر الالكتروني',
          style: TextStyle(fontSize: getResponsiveText(context, 12)),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}
