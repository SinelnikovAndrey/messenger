import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alta/controllers/appwrite_controllers.dart';
import 'package:alta/controllers/local_saved_data.dart';
import 'package:alta/providers/chat_provider.dart';
import 'package:alta/providers/user_data_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
          ),
          body: ListView(
            children: [
              ListTile(
                onTap: () => Navigator.pushNamed(context, "/update",
                    arguments: {"title": "edit"}),
                leading: CircleAvatar(
                  backgroundImage: value.getUserProfile != null ||
                          value.getUserProfile != ""
                      ? CachedNetworkImageProvider(
                          "https://cloud.appwrite.io/v1/storage/buckets/66605d0600130a8db708/files/${value.getUserProfile}/view?project=666053020014891fd972&mode=admin")
                      : const Image(
                          image: AssetImage("assets/user.png"),
                        ).image,
                ),
                title: Text(value.getUserName),
                subtitle: Text(value.getUserNumber),
                trailing: const Icon(Icons.edit_outlined),
              ),
              const Divider(),
              ListTile(
                onTap: () async {
                  await updateOnlineStatus(
                      status: false,
                      userId:
                          Provider.of<UserDataProvider>(context, listen: false)
                              .getUserId);
                  await LocalSavedData.clearAllData();
                  Provider.of<UserDataProvider>(context, listen: false)
                      .clearAllProvider();
                  Provider.of<ChatProvider>(context, listen: false)
                      .clearChats();
                  await logoutUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/login", (route) => false);
                },
                leading: const Icon(Icons.logout_outlined),
                title: const Text("Logout"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About"),
              ),
            ],
          ),
        );
      },
    );
  }
}
