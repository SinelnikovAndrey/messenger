import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alta/constants/colors.dart';
import 'package:alta/controllers/appwrite_controllers.dart';
import 'package:alta/models/user_data.dart';
import 'package:alta/providers/user_data_provider.dart';

import '../widgets/navbar.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({super.key});

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  final TextEditingController _searchController = TextEditingController();
  late DocumentList searchedUsers = DocumentList(total: -1, documents: []);

// handle the search
  void _handleSearch() {
    searchUsersNumber(
            searchItem: _searchController.text,
            userId:
                Provider.of<UserDataProvider>(context, listen: false).getUserId)
        .then((value) {
      if (value != null) {
        setState(() {
          searchedUsers = value;
        });
      } else {
        setState(() {
          searchedUsers = DocumentList(total: 0, documents: []);
        });
      }
    });
    searchUsersName(
            searchItem: _searchController.text,
            userId:
                Provider.of<UserDataProvider>(context, listen: false).getUserId)
        .then((value) {
      if (value != null) {
        setState(() {
          searchedUsers = value;
        });
      } else {
        setState(() {
          searchedUsers = DocumentList(total: 0, documents: []);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onSubmitted: (value) => _handleSearch(),
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "Enter phone number"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _handleSearch();
              },
            )
          ],
        ),
        // automaticallyImplyLeading: false,
      ),
      body: searchedUsers.total == -1
          ? const Center(
        child: Text("Use the search box to search users."),
      )
          : searchedUsers.total == 0
          ? const Center(
        child: Text("No users found"),
      )
          : ListView.builder(
        itemCount: searchedUsers.documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/chat",
                  arguments: UserData.toMap(
                      searchedUsers.documents[index].data));
            },
            leading: CircleAvatar(
              backgroundImage: searchedUsers
                  .documents[index].data["profile_pic"] !=
                  null &&
                  searchedUsers
                      .documents[index].data["profile_pic"] !=
                      ""
                  ? NetworkImage(
                  "https://cloud.appwrite.io/v1/storage/buckets/66605d0600130a8db708/files/${searchedUsers.documents[index].data["profile_pic"]}/view?project=666053020014891fd972&mode=admin")
                  : const Image(image: AssetImage("assets/user.png")).image,
            ),
            title: Text(searchedUsers.documents[index].data["name"]),
            subtitle:
            Text(searchedUsers.documents[index].data["phone_no"]),
          );
        },
      ),
    );
  }
}
