import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/cubit/category%20cubit/category_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/item%20card%20view%20widgets/table_fields.dart';

class ContainerItemCountity extends StatefulWidget {
  const ContainerItemCountity({
    super.key,
    required this.material,
    required this.index,
    required this.openItemCard,
  });

  final MaterialModel material;
  final int index;
  final VoidCallback openItemCard;

  @override
  State<ContainerItemCountity> createState() => _ContainerItemCountityState();
}

class _ContainerItemCountityState extends State<ContainerItemCountity> {
  String categoryName = '';
  @override
  void initState() {
    context.read<CategoryCubit>().categories.forEach((element) {
      if (widget.material.parentId == element.matId) {
        categoryName = element.matName;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (TapDownDetails details) {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        showMenu(
          context: context,
          position: RelativeRect.fromRect(
            details.globalPosition & const Size(60, 60),
            Offset.zero & overlay.size,
          ),
          items: [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.visibility),
                title: Text('بطاقة المادة'),
                onTap: widget.openItemCard,
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('حركة مادة'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('حذف'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              // ignore: deprecated_member_use
                              FontAwesomeIcons.solidQuestionCircle,
                              color: kBlueAccent,
                            ),
                            SizedBox(width: 7),
                            Text('حذف المادة'),
                          ],
                        ),
                        content: Text('هل أنت متأكد أنك تريد حذف هذه المادة؟'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('إلغاء الامر'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<MaterialCubit>().deleteMaterial(
                                widget.material,
                              );
                            },
                            child: Text('نعم'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      child: buildItemCardContent(context),
    );
  }

  @override
  Widget buildItemCardContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [bosShadow()],
        color: kWhite,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(width: .2, color: Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                FittedBox(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: kSecondColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      categoryName,
                      style: FontStyleApp.white18.copyWith(
                        fontSize: getResponsiveText(context, 12),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 1,
                  child: Text(
                    widget.material.materialName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: FontStyleApp.black18.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: getResponsiveText(context, 14),
                    ),
                  ),
                ),
                Text(
                  ' -${widget.index.toString()}',
                  style: FontStyleApp.black18.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: getResponsiveText(context, 14),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TableFIelds(
                lable1: 'سعر المستهلك',
                value1: widget.material.materialPrice3.toString(),
                lable2: 'سعر الجملة',
                value2: widget.material.materialPrice1.toString(),
                lable3: 'الكمية المتوفرة',
                value3: widget.material.matBalance.toString(),
                lable4: 'الوحدة',
                value4:
                    widget.material.materialUnitDefault == 0
                        ? widget.material.materialUnit
                        : widget.material.materialUnit2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
