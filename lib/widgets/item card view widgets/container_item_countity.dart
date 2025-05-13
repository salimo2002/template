import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/material%20cubit/material_cubit.dart';
import 'package:template/models/material_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/utils/responsive_text.dart';
import 'package:template/widgets/item%20card%20view%20widgets/column_countity.dart';

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
late String categoryName;
@override
  void initState() {
    context.read<CategoryCubit>().categories.forEach((element) {
      if (widget.material.parentId== element.matId) {
        categoryName=element.matName;
      }
    },);
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
                title: Text('فتح بطاقة المادة'),
                onTap: widget.openItemCard,
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text('استعراض حركة مادة'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('حذف هذه المادة'),
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

  Widget buildItemCardContent(BuildContext context) {
    return Container(
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
                  widget.material.materialName,
                  style: FontStyleApp.black18.copyWith(
                    fontSize: getResponsiveText(context, 14),
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  ' -${widget.index.toString()}',
                  style: FontStyleApp.black18.copyWith(
                    fontSize: getResponsiveText(context, 16),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          FittedBox(
            child: Text(
              categoryName, // التصنيف
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
                    ColumnCountity(countity: '0', nameCountity: 'المخزون'),
                    ColumnCountity(
                      countity: widget.material.materialPrice3.toString(),
                      nameCountity: 'سعر المستهلك',
                    ),
                    ColumnCountity(
                      countity: widget.material.materialPrice1.toString(),
                      nameCountity: 'سعر الجملة',
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
