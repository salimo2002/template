import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/cubit/imei%20cubit/imei_cubit.dart';
import 'package:template/cubit/imei%20cubit/imei_status.dart';
import 'package:template/utils/constants.dart';
import 'package:template/utils/custom_app_bar.dart';
import 'package:template/utils/custom_snack_bar.dart';
import 'package:template/utils/font_style.dart';
import 'package:template/views/log_in_view.dart';
import 'package:template/views/splash_view.dart';
import 'package:template/widgets/log%20in%20view/mobile_activated_card.dart';

class DevicesActivatedView extends StatelessWidget {
  const DevicesActivatedView({super.key});
  static String id = 'DevicesActivatedView';

  @override
  Widget build(BuildContext context) {
    bool myImei = false;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'الاجهزة المفعلة',
        showIcons: false,
      ),
      body: BlocConsumer<ImeiCubit, ImeiStatus>(
        listener: (context, state) {
          if (state is ImeiSuccessState) {
            if (myImei) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(context, 'تم حذف جهازك', kBlueAccent),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                LogInView.id,
                (route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(context, state.message!, kBlueAccent),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                SplashView.id,
                (route) => false,
              );
            }
          }
          if (state is ImeiFaliureState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(customSnackBar(context, state.errorMessage, kRed));
          }
        },
        builder: (context, state) {
          if (state is ImeiLoadingState) {
            return Center(child: CircularProgressIndicator(color: kBlueAccent));
          } else if (state is ImeiFaliureState) {
            return Center(
              child: Text(state.errorMessage, style: FontStyleApp.blueAccent18),
            );
          } else if (state is ImeiSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.devices.length,
                    itemBuilder: (context, index) {
                      return MobileActivatedCard(
                        userName: state.users[index],
                        imei: state.devices[index],
                        onPressed: () {
                          if (state.devices[index] == imei) {
                            myImei = true;
                          }
                          context.read<ImeiCubit>().deletDevice(
                            imei: state.devices[index],
                            comId: CompanyCubit.comp.comId,
                            userName: state.users[index],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
