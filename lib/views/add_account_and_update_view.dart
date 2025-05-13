import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/account%20service/accounts_cubit.dart';
import 'package:template/models/account_model.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/widgets/new%20item%20view%20widgets/container_fields.dart';
import 'package:template/widgets/new%20item%20view%20widgets/save_and_exite_button.dart';
import 'package:template/widgets/new%20item%20view%20widgets/text_field_details.dart';

class AddAccountAndUpdateView extends StatefulWidget {
  const AddAccountAndUpdateView({super.key});
  static String id = 'AddAccountAndUpdateView';

  @override
  State<AddAccountAndUpdateView> createState() =>
      _AddAccountAndUpdateViewState();
}

class _AddAccountAndUpdateViewState extends State<AddAccountAndUpdateView> {
  final TextEditingController nameAcc = TextEditingController();
  final TextEditingController phonAcc = TextEditingController();
  final TextEditingController mobileAcc = TextEditingController();
  final TextEditingController addressAcc = TextEditingController();
  final TextEditingController emailAcc = TextEditingController();
  final TextEditingController taxAcc = TextEditingController();

  late bool isNew;
  AccountModel? existingAccount;

  @override
  void dispose() {
    nameAcc.dispose();
    phonAcc.dispose();
    mobileAcc.dispose();
    addressAcc.dispose();
    emailAcc.dispose();
    taxAcc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    isNew = args!['isNew'] as bool;
    existingAccount = args['account'] as AccountModel?;

    if (!isNew && existingAccount != null) {
      nameAcc.text = existingAccount!.accName;
      phonAcc.text = existingAccount!.accPhone ?? '';
      mobileAcc.text = existingAccount!.accMobile ?? '';
      addressAcc.text = existingAccount!.accAddress ?? '';
      emailAcc.text = existingAccount!.accEmail ?? '';
      taxAcc.text = existingAccount!.accTaxNo ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: isNew ? 'إضافة حساب جديد' : 'تعديل حساب',
        showIcons: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'العملاء و الزبائن',
                            label: 'الحساب الرئيسي',
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'اسم الحساب',
                            label: 'اسم الحساب',
                            controller: nameAcc,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'رقم الهاتف',
                            label: 'الهاتف',
                            controller: phonAcc,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'رقم الموبايل',
                            label: 'موبايل',
                            controller: mobileAcc,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'العنوان',
                            label: 'العنوان',
                            controller: addressAcc,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'البريد الاكتروني',
                            label: 'البريد',
                            controller: emailAcc,
                          ),
                        ],
                      ),
                      ContainerFields(
                        children: [
                          TextFieldAndDetails(
                            hintText: 'الرقم الضريبي',
                            label: 'الرقم الضريبي',
                            controller: taxAcc,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            SaveAndExitButton(
              text: 'حفظ و انهاء',
              onPressed: () {
                if (nameAcc.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: kBlueAccent,
                      content: Text(
                        'اسم الحساب مطلوب',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                  return;
                }

                final account = AccountModel(
                  accTaxNo: taxAcc.text,
                  accAddress: addressAcc.text,
                  accEmail: emailAcc.text,
                  accMobile: mobileAcc.text,
                  accPhone: phonAcc.text,
                  accNumber:
                      isNew
                          ? Random().nextInt(1000000)
                          : existingAccount!.accNumber,
                  accName: nameAcc.text,
                  parentId: 0,
                  accKind: 0,
                  accRefrence: 1,
                  accID: isNew ? null : existingAccount!.accID,
                );

                if (isNew) {
                  context.read<AccountsCubit>().insertAccounts(account);
                } else {
                  context.read<AccountsCubit>().updateAccounts(account);
                }

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
