import 'package:beacon/utils/colors.dart';
import 'package:beacon/utils/global_variables.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    //model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: PageView(
          children: HomeScreenItens,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    color: _page == 0 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,
                    color: _page == 1 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/mainButton.png',
                  width: 600.0,
                  height: 240.0,
                ),
                //color: _page == 2 ? primaryColor : secondaryColor),
                //label: 'ICON BEACON',
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            BottomNavigationBarItem(
                icon: Icon(Icons.map,
                    color: _page == 3 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                    color: _page == 4 ? primaryColor : secondaryColor),
                label: '',
                backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
          ],
          onTap: navigationTapped,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255));
  }
}



  /*
  String username = "";

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });

    print(snap.data());
  }
  */