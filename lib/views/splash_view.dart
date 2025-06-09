import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/category%20cubit/category_cubit.dart';
import 'package:template/cubit/company%20cubit/company_cubit.dart';
import 'package:template/cubit/imei%20cubit/imei_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/views/home_view.dart';
import 'package:video_player/video_player.dart';

class SplashView extends StatefulWidget {
  static const id = 'SplashVideoScreen';

  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  VideoPlayerController? _controller;
  bool _isMobile = false;
  bool _navigated = false;
  late VoidCallback _videoListener;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MaterialCubit>().fetchMaterials();
      context.read<CategoryCubit>().fetchCategory();
      context.read<AccountsCubit>().fetchAccounts();
      context.read<BillCubit>().fetchBills();
      context.read<ImeiCubit>().getDevices(
        comId: context.read<CompanyCubit>().comp.comId,
      );
    });

    _isMobile = Platform.isAndroid || Platform.isIOS;

    if (_isMobile) {
      _controller = VideoPlayerController.asset(
        'assets/videos/splash_intro_1.mp4',
      );
      _initializeVideo();
    } else {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, HomeView.id);
      });
    }
  }

  Future<void> _initializeVideo() async {
    await _controller!.initialize();
    setState(() {});
    _controller!.play();

    _videoListener = () {
      if (_controller!.value.position >= _controller!.value.duration &&
          !_navigated) {
        _navigated = true;
        _controller!.removeListener(_videoListener);
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, HomeView.id);
      }
    };

    _controller!.addListener(_videoListener);
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isMobile ||
        _controller == null ||
        !_controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
