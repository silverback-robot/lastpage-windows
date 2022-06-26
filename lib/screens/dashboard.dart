import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/screens/library.dart';
import 'package:lastpage/services/firestore_rest_api.dart';
import 'package:lastpage/widgets/window_behavior/title_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> sharedPrefSnapshot) {
            if (sharedPrefSnapshot.hasData) {
              var prefs = sharedPrefSnapshot.data!;
              return Column(
                // TEMPORARY - Space Filler/Test Bed
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  WindowTitleBarBox(
                    child: Row(
                      children: [
                        Expanded(child: MoveWindow()),
                        const WindowButtons()
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.white,
                          child: SizedBox(
                            width: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Text(
                                "Hello\n${prefs.getString('name')}!",
                                style: const TextStyle(
                                  color: LastpageColors.black,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Library.routeName);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: SizedBox(
                                  width: 150,
                                  height: 120,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: const [
                                        Icon(
                                          Icons.library_books_outlined,
                                          color: LastpageColors.black,
                                          size: 40,
                                        ),
                                        Text(
                                          'Library',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: LastpageColors.black,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Provider.of<FirestoreRestApi>(context,
                                            listen: false)
                                        .fetchUserUploads();
                                  },
                                  child: const Text("HTTP TEST")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
}
