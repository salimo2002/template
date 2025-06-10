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
  late VideoPlayerController? _controller;
  bool _isMobile = false;

  bool _materialsLoaded = false;
  bool _categoriesLoaded = false;
  bool _accountsLoaded = false;
  bool _billsLoaded = false;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MaterialCubit>().fetchMaterials().then((_) {
        _materialsLoaded = true;
        checkAndNavigate();
      });


      context.read<CategoryCubit>().fetchCategory().then((_) {
        _categoriesLoaded = true;
        checkAndNavigate();
      });

      context.read<AccountsCubit>().fetchAccounts().then((_) {
        _accountsLoaded = true;
        checkAndNavigate();
      });

      context.read<BillCubit>().fetchBills().then((_) {
        _billsLoaded = true;
        checkAndNavigate();
      });
    });

    _isMobile = Platform.isAndroid || Platform.isIOS;

    if (_isMobile) {
      _controller = VideoPlayerController.asset(
        'assets/videos/splash_intro_1.mp4',
      );
      _initializeVideo();
    } else {
      _controller = null;
      Future.delayed(const Duration(milliseconds: 500), () {
        _videoInitialized = true;
        checkAndNavigate();
      });
    }
  }

  Future<void> _initializeVideo() async {
    await _controller!.initialize();
    _controller!.setLooping(true); // ✅ إعادة تشغيل الفيديو تلقائيًا
    setState(() {
      _videoInitialized = true;
    });
    _controller!.play();
    checkAndNavigate(); // في حال تم تحميل البيانات قبل تهيئة الفيديو
  }

  void checkAndNavigate() {
    if (_materialsLoaded &&
        _categoriesLoaded &&
        _accountsLoaded &&
        _billsLoaded &&
        _videoInitialized) {
      Navigator.pushReplacementNamed(context, HomeView.id);
    }
  }

  @override
  void dispose() {
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

    final videoSize = _controller!.value.size;
    final aspectRatio = videoSize.width / videoSize.height;

    double width = MediaQuery.of(context).size.width;
    double height = width / aspectRatio;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: VideoPlayer(_controller!),
        ),
      ),
    );
  }
}
