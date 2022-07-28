import 'package:flutter/material.dart';
import 'package:lastpage/models/lastpage_colors.dart';
import 'package:lastpage/models/syllabus/syllabus_provider.dart';
import 'package:lastpage/models/user_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SyllabusProvider>(context).syllabus;

    return Scaffold(
      body: FutureBuilder(
        future: SharedPreferences.getInstance(),
        // var storedUid = prefs.getString('uid');,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            var prefs = snapshot.data!;
            // var uid = prefs.getString('uid');
            var name = prefs.getString('name');
            var email = prefs.getString('email');
            var phone = prefs.getInt('phone');
            // var university = prefs.getString('university');
            // var department = prefs.getString('department');
            var avatar = prefs.getString('avatar');

            return Center(
              child: Card(
                child: SizedBox(
                  height: 400,
                  width: 600,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(12.0), //or 15.0
                                    child: Container(
                                      color: LastpageColors.lightGrey,
                                      height: 150.0,
                                      width: 120.0,
                                      child: avatar != null && avatar.isNotEmpty
                                          ? Image.network(avatar)
                                          : const Icon(Icons.person_rounded,
                                              color: LastpageColors.white,
                                              size: 120.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 16.0),
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        child: const Text("Update Avatar")),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.red),
                                    onPressed: Provider.of<UserAuth>(context,
                                            listen: false)
                                        .signOut,
                                    icon: const Icon(Icons.logout_outlined),
                                    label: const Text("Logout")),
                              )
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: LastpageColors.lightGrey,
                        indent: 12,
                        endIndent: 12,
                      ),
                      Expanded(
                        flex: 5,
                        child:
                            Column(mainAxisAlignment: MainAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 30),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name ?? "No name",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          if (email != null && email.isNotEmpty)
                                            const Text(
                                              "Email",
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                                color: LastpageColors.darkGrey,
                                              ),
                                            ),
                                          if (email != null && email.isNotEmpty)
                                            Text(
                                              email,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                // fontWeight: FontWeight.bold,
                                                color: LastpageColors.darkGrey,
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          if (phone != null && phone != 0)
                                            const Text(
                                              "Phone",
                                              style: TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                                color: LastpageColors.darkGrey,
                                              ),
                                            ),
                                          if (phone != null && phone != 0)
                                            Text(
                                              "$phone",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                // fontWeight: FontWeight.bold,
                                                color: LastpageColors.darkGrey,
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "University",
                                            style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                          Text(
                                            data?.university ?? "No university",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Department",
                                            style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                          Text(
                                            data?.course ?? "No department",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Syllabus Version",
                                            style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                          Text(
                                            data?.syllabusVersion ??
                                                "No version",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // fontWeight: FontWeight.bold,
                                              color: LastpageColors.darkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
