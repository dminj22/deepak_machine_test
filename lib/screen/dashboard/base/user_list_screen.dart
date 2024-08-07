import 'package:deepak_machine_test/util/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:deepak_machine_test/services/model/UserListModel.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../provider/user_list_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Consumer<UserListProvider>(
        builder: (context, userListProvider, child) {
          return PagedListView<int, UserListModel>(
            pagingController: userListProvider.pagingController,
            builderDelegate: PagedChildBuilderDelegate<UserListModel>(
              itemBuilder: (context, item, index) => ListTile(
                leading: SizedBox(
                    width: 30,
                    height: 30,
                    child: CustomImage(url: item.avatar.toString(), radius: 5)),
                title: Text('${item.firstName} ${item.lastName}'),
                subtitle: Text(item.email.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
