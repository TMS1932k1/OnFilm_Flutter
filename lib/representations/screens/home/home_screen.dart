import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onfilm_app/constants/app_constant.dart';
import 'package:onfilm_app/constants/assets_constant.dart';
import 'package:onfilm_app/constants/colors_constant.dart';
import 'package:onfilm_app/constants/dimession_constant.dart';
import 'package:onfilm_app/constants/text_style_constant.dart';
import 'package:onfilm_app/representations/screens/auth/auth_screen.dart';
import 'package:onfilm_app/representations/screens/search/search_screen.dart';
import 'package:onfilm_app/representations/widgets/home/icon_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexCurrent = 0;
  final _pages = AppConstant.pages;

  @override
  Widget build(BuildContext context) {
    // Get device's size
    final size = MediaQuery.of(context).size;
    final pandingTop = MediaQuery.of(context).padding.top;

    // Change page when on click drawer or bottom nav
    void updatePage(int index) {
      setState(() {
        _indexCurrent = index;
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context, _pages[_indexCurrent]['name']),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: size.width >= DimenssionConstant.kMaxWidthMobile
          ? _buildDrawer(
              context,
              size.width * 0.3,
              pandingTop,
              _pages,
              _indexCurrent,
              updatePage,
            )
          : null,
      body: _pages[_indexCurrent]['page'],
      bottomNavigationBar: size.width < DimenssionConstant.kMaxWidthMobile
          ? _buildBottomNav(
              context,
              _indexCurrent,
              _pages,
              updatePage,
            )
          : null,
    );
  }
}

// Drawer
Drawer _buildDrawer(
  BuildContext context,
  double size,
  double pandingTop,
  List<Map<String, dynamic>> titles,
  int indexCurrent,
  Function updatePage,
) {
  return Drawer(
    width: size,
    child: Container(
      padding: EdgeInsets.only(
        left: DimenssionConstant.kRadiusMedium,
        top: DimenssionConstant.kRadiusMedium + pandingTop,
      ),
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AssetsConstant.logoAppImage,
                height: DimenssionConstant.kHeightLogoApp,
              ),
            ),
            SizedBox(height: pandingTop),
            ...titles.map(
              (title) {
                final index = titles.indexOf(title);
                return TextButton.icon(
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft),
                  icon: FaIcon(
                    title['icon'],
                    color: index == indexCurrent
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                    size: DimenssionConstant.kIconBtn,
                  ),
                  label: Text(
                    title['name'],
                    style: TextStyleConstant.headlineSmall.copyWith(
                      color: index == indexCurrent
                          ? Theme.of(context).colorScheme.primary
                          : Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Close drawer
                    Navigator.of(context).pop();
                    updatePage(index);
                  },
                );
              },
            ).toList(),
          ],
        ),
      ),
    ),
  );
}

// Bottom navigation bar
Widget _buildBottomNav(
  BuildContext context,
  int indexCurrent,
  List<Map<String, dynamic>> titles,
  Function updatePage,
) {
  return SizedBox(
    height: kBottomNavigationBarHeight,
    child: BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        ...titles
            .map(
              (title) => BottomNavigationBarItem(
                icon: FaIcon(
                  title['icon'],
                  size: DimenssionConstant.kIconBtn,
                ),
                label: title['name'],
              ),
            )
            .toList(),
      ],
      currentIndex: indexCurrent,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      onTap: (index) => updatePage(index),
    ),
  );
}

// AppBar
AppBar _buildAppBar(
  BuildContext context,
  String title,
) {
  // Process sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      // Go to Login screen
      Navigator.of(context).pushNamed(AuthScreen.nameRoute);
    });
  }

  // Show dialog to confirm sign out
  Future<void> showDialogSignOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text(
            'Sign Out',
            style: TextStyleConstant.headlineMedium,
          ),
          content: const Text(
            'Do you want to sign out this account?',
            style: TextStyleConstant.labelMedium,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Disable',
                style: TextStyleConstant.headlineSmall,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Enable',
                style: TextStyleConstant.headlineSmall,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                signOut();
              },
            ),
          ],
        );
      },
    );
  }

  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    actions: [
      IconButton(
        onPressed: () =>
            // Go to Search screen
            Navigator.of(context).pushNamed(SearchScreen.nameRoute),
        iconSize: DimenssionConstant.kIconBtn,
        icon: const FaIcon(
          FontAwesomeIcons.magnifyingGlass,
        ),
      ),
      StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return IconUser(
              () {
                showDialogSignOut(context);
              },
            );
          } else {
            return IconButton(
              onPressed: () =>
                  // Go to Login screen
                  Navigator.of(context).pushNamed(AuthScreen.nameRoute),
              iconSize: DimenssionConstant.kIconBtn,
              icon: const FaIcon(
                FontAwesomeIcons.rightToBracket,
              ),
            );
          }
        },
      ),
    ],
    elevation: 0,
    backgroundColor: Colors.transparent,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: ColorsConstant.gradientTopToBottom,
      ),
    ),
  );
}
