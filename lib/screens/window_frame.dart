import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:lastpage/screens/library.dart';
import 'package:lastpage/screens/update_profile.dart';
import 'package:lastpage/widgets/window_behavior/title_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WindowFrame extends StatefulWidget {
  const WindowFrame({Key? key}) : super(key: key);

  static const routeName = '/window_frame';

  @override
  State<WindowFrame> createState() => _WindowFrameState();
}

class _WindowFrameState extends State<WindowFrame> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 27,
        title: WindowTitleBarBox(
          child: Row(
            children: [Expanded(child: MoveWindow()), const WindowButtons()],
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> sharedPrefSnapshot) {
            if (sharedPrefSnapshot.hasData) {
              var prefs = sharedPrefSnapshot.data!;
              return Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: const <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Icon(Icons.library_books_outlined),
                        selectedIcon: Icon(Icons.library_books),
                        label: Text('Library'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.list_alt_outlined),
                        selectedIcon: Icon(Icons.list_alt_rounded),
                        label: Text('Syllabus'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: Text('Profile'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.sync_outlined),
                        selectedIcon: Icon(Icons.sync),
                        label: Text('Sync Files'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 0.5, width: 0.5),
                  Expanded(
                    child: buildPage(),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const Library();
      case 1:
        return const Library();
      case 2:
        return const UpdateProfile();
      case 3:
      default:
        return const Library();
    }
  }
}