import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/cubit/company%20cubit/company_status.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/views/splash_view.dart';
import 'package:template/widgets/log%20in%20view/main_button.dart';
import 'package:template/widgets/new%20item%20view%20widgets/custom_text_field.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});
  static String id = 'LogInView';

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late final TextEditingController companyName;
  late final TextEditingController activateKey;
  late final GlobalKey<FormState> globalKey;
  @override
  void initState() {
    companyName = TextEditingController();
    activateKey = TextEditingController();
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/Login/pictureBox3.Image.png',
                      height: 150,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'تفعيل التطبيق',
                      style: FontStyleApp.blueAccent18.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      validator: (p0) {
                        if (p0 == null || p0 == '') {
                          return 'الرجاء ادخال اسم الشركة';
                        }
                        return null;
                      },
                      hintText: 'اسم الشركة',
                      controller: companyName,
                      focusNode: FocusNode(),
                      prefixIcon: Icon(
                        FontAwesomeIcons.house,
                        color: kBlueAccent,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      validator: (p0) {
                        if (p0 == null || p0 == '') {
                          return 'الرجاء ادخال مفتاح التفعيل';
                        }
                        return null;
                      },
                      hintText: 'مفتاح التفعيل',
                      controller: activateKey,
                      focusNode: FocusNode(),
                      prefixIcon: Icon(
                        FontAwesomeIcons.key,
                        color: kBlueAccent,
                      ),
                    ),
                    SizedBox(height: 15),
                    BlocConsumer<CompanyCubit, CompanyStatus>(
                      listener: (context, state) {
                        if (state is CompanySuccesState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(context, state.message, kBlueAccent),
                          );
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            SplashVideoScreen.id,
                            (route) => false,
                          );
                        }
                        if (state is CompanyFaliureState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(context, state.errorMessage, kRed),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CompanyInitState) {
                          return MainButton(
                            onTap: () {
                              if (globalKey.currentState!.validate()) {
                                context.read<CompanyCubit>().checkCompany(
                                  comName: companyName.text,
                                  comSerial: activateKey.text,
                                );
                              }
                            },
                            label: 'تفعيل',
                            color: kBlueAccent,
                          );
                        } else if (state is CompanyFaliureState) {
                          return MainButton(
                            onTap: () {
                              context.read<CompanyCubit>().checkCompany(
                                comName: companyName.text,
                                comSerial: activateKey.text,
                              );
                            },
                            label: 'تفعيل',
                            color: kBlueAccent,
                          );
                        } else {
                          return CircularProgressIndicator(color: kBlueAccent);
                        }
                      },
                    ),
                    SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
