import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/appwrite_controllers.dart';
import '../controllers/local_saved_data.dart';
import '../providers/chat_provider.dart';
import '../providers/user_data_provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Consumer<UserDataProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const AlwaysScrollableScrollPhysics(),

          child: Column(


              children: [
            Stack(children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xff5c9468)),
              ),
              Positioned(
                top: 50,
                left: 20,
                height: 70,
                width: 70,
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/profile"),
                  child: CircleAvatar(
                    backgroundImage: value.getUserProfile != null ||
                            value.getUserProfile != ""
                        ? CachedNetworkImageProvider(
                            "https://cloud.appwrite.io/v1/storage/buckets/66605d0600130a8db708/files/${value.getUserProfile}/view?project=666053020014891fd972&mode=admin")
                        : const Image(
                            image: AssetImage("assets/user.png"),
                          ).image,
                  ),
                ),
              ),
            ]),
            Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/profile"),
                  child:
                  Consumer<UserDataProvider>(builder: (context, value, child) {
                    return const ListTile(

                      leading: Icon(Icons.account_circle_outlined),
                      title: Text("My profile"),
                    );
                  })
              ),
                const Divider(),

                const ListTile(


                  leading: Icon(Icons.group_outlined),
                  title: Text("New Group"),
                ),
                const ListTile(
                  leading: Icon(Icons.contacts_outlined),
                  title: Text("Contacts"),
                ),
                const ListTile(
                  leading: Icon(Icons.call_outlined),
                  title: Text("Calls"),
                ),
                const ListTile(
                  leading: Icon(Icons.accessibility_rounded),
                  title: Text("People Nearby"),
                ),
                const ListTile(
                  leading: Icon(Icons.save_alt_outlined),
                  title: Text("Saved Messages"),
                ),
                const ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text("Settings"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.person_add_outlined),
                  title: Text("Invite Friends"),
                ),
                const ListTile(
                  leading: Icon(Icons.help_outline_outlined),
                  title: Text("Telegram Features"),
                ),

              ]
            ),

          ]),
        );
      }),
    );
  }
}
