
import 'package:flutter/material.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/item%20card%20view%20widgets/column_countity.dart';

class ContainerItemCountity extends StatelessWidget {
  const ContainerItemCountity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        border: Border.all(color: kBlueAccent),
        color: kGrey,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'بنطال',
                style: FontStyleApp.blackCustom18.copyWith(
                  fontSize: getResponsiveText(context, 16),
                ),
              ),
              Text(
                ' -1',
                style: FontStyleApp.blackCustom18.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'عام',
            style: FontStyleApp.green14.copyWith(
              fontSize: getResponsiveText(context, 14),
            ),
          ),
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: kBlack),
                color: kWhite,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ColumnCountity(
                      countity: '0',
                      nameCountity: 'الكمية المتوفرة',
                    ),
                    ColumnCountity(
                      countity: '0',
                      nameCountity: 'الكمية المباعة',
                    ),
                    ColumnCountity(
                      countity: '0',
                      nameCountity: 'الكمية الكلية',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
