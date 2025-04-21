import 'package:flutter/material.dart';

class DefaultUnt extends StatelessWidget {
  const DefaultUnt({
    super.key,
    required this.isSelected,
    required this.labels,
  });

  final ValueNotifier<int?> isSelected;
  final ValueNotifier<List<String>> labels;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ValueListenableBuilder<List<String>>(
        valueListenable: labels,
        builder: (context, value, _) {
          return ValueListenableBuilder<int?>(
            valueListenable: isSelected,
            builder: (context, val, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RadioMenuButton<int>(
                    value: 1,
                    groupValue: val,
                    onChanged: (value) => isSelected.value = value!,
                    child: Text(value[0]),
                  ),
                  if (value[1].isNotEmpty)
                    RadioMenuButton<int>(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) => isSelected.value = value!,
                      child: Text(value[1]),
                    ),
                  if (value[2].isNotEmpty)
                    RadioMenuButton<int>(
                      value: 3,
                      groupValue: val,
                      onChanged: (value) => isSelected.value = value!,
                      child: Text(value[2]),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
