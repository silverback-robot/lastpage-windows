import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  height: 475,
                  width: 700,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        child: avatar != null &&
                                                avatar.isNotEmpty
                                            ? Image.network(avatar)
                                            : const Icon(Icons.person_rounded,
                                                color: LastpageColors.white,
                                                size: 120.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 16.0),
                                      child: OutlinedButton.icon(
                                          icon: const Icon(Icons.perm_identity),
                                          style: OutlinedButton.styleFrom(
                                            fixedSize: const Size(175, 35),
                                          ),
                                          //TODO: Allow user to select an image and upload to storage, update profile document and refresh screen
                                          onPressed: () {},
                                          label: const Text("Update Avatar")),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                            fixedSize: const Size(175, 35),
                                          ),
                                          //TODO: Launch browser with contact form page
                                          onPressed: () {},
                                          icon: const Icon(Icons.email),
                                          label: const Text("Contact Us")),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      OutlinedButton.icon(
                                          style: OutlinedButton.styleFrom(
                                              fixedSize: const Size(175, 35),
                                              primary: Colors.red),
                                          onPressed: Provider.of<UserAuth>(
                                                  context,
                                                  listen: false)
                                              .signOut,
                                          icon:
                                              const Icon(Icons.logout_outlined),
                                          label: const Text("Logout")),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child:
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 24),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name ?? "No name",
                                              style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: LastpageColors.darkGrey,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            if (email != null &&
                                                email.isNotEmpty)
                                              const Text(
                                                "Email",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.bold,
                                                  color:
                                                      LastpageColors.darkGrey,
                                                ),
                                              ),
                                            if (email != null &&
                                                email.isNotEmpty)
                                              Text(
                                                email,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  // fontWeight: FontWeight.bold,
                                                  color:
                                                      LastpageColors.darkGrey,
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
                                                  color:
                                                      LastpageColors.darkGrey,
                                                ),
                                              ),
                                            if (phone != null && phone != 0)
                                              Text(
                                                "+91 $phone",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  // fontWeight: FontWeight.bold,
                                                  color:
                                                      LastpageColors.darkGrey,
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
                                              data?.university ??
                                                  "No university",
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
                                      Center(
                                        child: Container(
                                          width: 400,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: LastpageColors.lightGrey,
                                                width: 0.75),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  height: 30,
                                                  'assets/logo/lastpage_logo.svg'),
                                              Container(
                                                margin: const EdgeInsets.all(8),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: LastpageColors
                                                            .darkGrey,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: LastpageColors
                                                        .darkGrey),
                                                child: const Text(
                                                    "Version: 0.0.1",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: LastpageColors
                                                            .white)),
                                              ),
                                              // ignore: prefer_const_constructors
                                              Text(
                                                  textAlign: TextAlign.center,
                                                  "\u00a9 Copyright owned by Lastpage Student Services. By using this and other lastpage apps, you are agreeing to our terms of service.",
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: LastpageColors
                                                          .darkGrey,
                                                      letterSpacing: -1)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ]),
                        ),
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
