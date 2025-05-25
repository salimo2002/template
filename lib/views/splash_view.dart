import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/cubit/account%20cubit/accounts_cubit.dart';
import 'package:template/cubit/bill%20cubit/bill_cubit.dart';
import 'package:template/cubit/category%20cubit/category_cubit.dart';
import 'package:template/cubit/material%20cubit/material_cubit.dart';
import 'package:template/views/home_view.dart';
import 'package:video_player/video_player.dart';

class SplashVideoScreen extends StatefulWidget {
  static const id = 'SplashVideoScreen';

  const SplashVideoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashVideoScreenState createState() => _SplashVideoScreenState();
}

class _SplashVideoScreenState extends State<SplashVideoScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MaterialCubit>().fetchMaterials();
      context.read<CategoryCubit>().fetchCategory();
      context.read<AccountsCubit>().fetchAccounts();
      context.read<BillCubit>().fetchBills();
    });

    _controller = VideoPlayerController.asset(
      'assets/videos/splash_intro_1.mp4',
    );
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();
    setState(() {});
    _controller.play();

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, HomeView.id);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: SizedBox()),
      );
    }

    final videoSize = _controller.value.size;
    final aspectRatio = videoSize.width / videoSize.height;

    double width = MediaQuery.of(context).size.width;
    double height = width / aspectRatio;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
