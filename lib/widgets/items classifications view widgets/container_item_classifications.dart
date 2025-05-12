import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/category%20cubit/category_cubit.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/responsive_text.dart';

class ContainerItemClassifications extends StatelessWidget {
  const ContainerItemClassifications({
    super.key,
    required this.nameClassificatio,
    required this.onTap,
    required this.color,
    required this.matId,
  });
  final String nameClassificatio;
  final void Function() onTap;
  final Color color;
  final String matId;
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
                              context.read<CategoryCubit>().categoryDeletById(
                                matId: matId,
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

      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          width: MediaQuery.sizeOf(context).width * .95,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Text(
              nameClassificatio,
              style: TextStyle(
                fontSize: getResponsiveText(context, 18),
                color: const Color.fromARGB(255, 82, 82, 82),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ),
    );
  }
}
