import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sizer/sizer.dart';

typedef HomePage<T> = T Function(void Function() onOpenDrawer);
typedef DrawerPage<T> = T Function();

class DrawerStatePage extends StatefulWidget {
  final HomePage<Widget> homePage;
  final DrawerPage<Widget> drawerPage;
  const DrawerStatePage({
    Key? key,
    required this.homePage,
    required this.drawerPage,
  }) : super(key: key);

  @override
  _DrawerStatePageState createState() => _DrawerStatePageState();
}

class _DrawerStatePageState extends State<DrawerStatePage> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isDrawerOpen = false;
  bool isDraging = false;
  @override
  void initState() {
    super.initState();
    closeDrawer();
  }

  void openDrawer() {
    setState(() {
      xOffset = 58.569.w;
      yOffset = 100;
      scaleFactor = 0.8;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(21, 30, 61, 1),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          widget.drawerPage(),
          buildHome(),
        ],
      ),
    );
  }

  Widget buildHome() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: AnimatedContainer(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[6],
        ),
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        child: GestureDetector(
          onTap: closeDrawer,
          onHorizontalDragStart: (_) => isDraging = true,
          onHorizontalDragUpdate: (details) {
            if (!isDraging) return;
            const delta = 1;
            if (details.delta.dx > delta) {
              openDrawer();
            } else if (details.delta.dx < -delta) {
              closeDrawer();
            }
            isDraging = false;
          },
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: widget.homePage(
              openDrawer,
            ),
          ),
        ),
      ),
    );
  }
}
