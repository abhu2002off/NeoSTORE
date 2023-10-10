import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mvvm_signin_out/view/drawer_screen.dart';
import 'package:mvvm_signin_out/view/home_screen.dart';

class LayoutScreen extends StatefulHookConsumerWidget {
  const LayoutScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(children: [
          DrawerScreen(),
          HomeScreen(),
        ]),
      ),
    );
  }
}
