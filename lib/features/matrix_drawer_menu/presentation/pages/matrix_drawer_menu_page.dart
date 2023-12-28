import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_examples/features/matrix_drawer_menu/presentation/widgets/menu_tile.dart';

class MatrixDrawerMenuPage extends StatefulWidget {
  const MatrixDrawerMenuPage({super.key});

  @override
  State<MatrixDrawerMenuPage> createState() => _MatrixDrawerMenuPageState();
}

class _MatrixDrawerMenuPageState extends State<MatrixDrawerMenuPage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.blueAccent,
                  Colors.tealAccent,
                ],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://source.unsplash.com/random'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'User name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        MenuTile(
                            title: 'Home',
                            iconData: Icons.home,
                            onPressed: () {}),
                        MenuTile(
                            title: 'Profile',
                            iconData: Icons.person,
                            onPressed: () {}),
                        MenuTile(
                            title: 'Settings',
                            iconData: Icons.settings,
                            onPressed: () {}),
                        MenuTile(
                            title: 'Log out',
                            iconData: Icons.logout,
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: value),
            duration: const Duration(milliseconds: 500),
            builder: (context, double val, s) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: val * 24),
                  child: ClipRRect(
                    borderRadius: val > 0
                        ? const BorderRadius.horizontal(
                            left: Radius.circular(24))
                        : BorderRadius.zero,
                    child: Scaffold(
                      appBar: AppBar(
                        title: const Text('Matrix Menu'),
                      ),
                      body: const Center(
                        child: Text(' Swipe right to open the menu '),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onHorizontalDragUpdate: (v) {
              v.delta.dx > 0 ? value = 1 : value = 0;
              setState(() {});
            },
            // onTap: () {
            //   setState(() {
            //     value == 0 ? value = 1 : value = 0;
            //   });
            // },
          ),
        ],
      ),
    );
  }
}
