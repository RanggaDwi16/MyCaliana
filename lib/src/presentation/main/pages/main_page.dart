import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:my_caliana/src/core/routers/router_name.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';
import 'package:my_caliana/src/core/utils/constant/path.dart';
import 'package:my_caliana/src/presentation/main/widgets/navbar_list.dart';
import 'package:my_caliana/src/presentation/login/provider/user_provider.dart'; // Import userProvider

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider); // Ambil user dari provider
    final userName =
        user?.fullName ?? "Pengguna"; // Default jika tidak ada user

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Image.asset(
            PathConstant.logoCalianaPath,
            width: 40,
            height: 40,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          if (_currentIndex == 0)
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                _pageController.jumpToPage(1);
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    right: 32,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 100, // Lebih lebar untuk nama panjang
                        ),
                        child: Text(
                          userName.length > 8
                              ? '${userName.substring(0, 8)}...'
                              : userName,
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        PathConstant.avatarPath,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Gap(16),
          GestureDetector(
            onTap: () {
              context.pushNamed(RouterName.notification);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(listFrame.length, (index) => listFrame[index]),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.white,
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 12,
        spaceBetweenChildren: 8,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.file_open_outlined,
                color: AppColor.primaryColor),
            label: 'Pra Registrasi',
            backgroundColor: AppColor.colorSafeArea,
            shape: const CircleBorder(),
            onTap: () {
              context.pushNamed(RouterName.praRegistration);
            },
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.person_pin_outlined,
              color: AppColor.primaryColor,
            ),
            label: 'Registrasi',
            backgroundColor: AppColor.colorSafeArea,
            shape: const CircleBorder(),
            onTap: () {
              context.pushNamed(RouterName.registration);
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 75,
        notchMargin: 12,
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.blue : Colors.grey;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 3,
                width: 50,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4),
              Icon(iconList[index], color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                labelList[index],
                style: TextStyle(color: color, fontSize: 12),
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
