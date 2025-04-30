import 'package:flutter/material.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/views/edit_prodict_view.dart';
import 'package:template/widgets/item%20card%20view%20widgets/column_countity.dart';

class ContainerItemCountity extends StatelessWidget {
  const ContainerItemCountity({
    super.key,
    required this.material,
    required this.index,
  });
  final MaterialModel material;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(arguments: material, context, EditProdictView.id);
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * .17,
        decoration: BoxDecoration(
          border: Border.all(color: kBlueAccent),
          color: kGrey,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FittedBox(
                  child: Text(
                    material.materialName,
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 17),
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    index.toString(),
                    style: FontStyleApp.black18.copyWith(
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            FittedBox(
              child: Text(
                'عام',
                style: FontStyleApp.green14.copyWith(
                  fontSize: getResponsiveText(context, 14),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * .08,
                decoration: BoxDecoration(
                  border: Border.all(color: kBlacCustomk),
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
      ),
    );
  }
}
