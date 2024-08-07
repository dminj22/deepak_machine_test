import 'package:deepak_machine_test/services/model/UserListModel.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../services/api_const.dart';
import '../util/widgets.dart';

class UserListProvider extends ChangeNotifier {
  int pageSize = 6;

  final PagingController<int, UserListModel> pagingController =
      PagingController(firstPageKey: 1);

  UserListProvider() {
    pagingController.addPageRequestListener((pageKey) {
      listOfUsers(pageKey: pageKey);
    });
  }

  Future<void> listOfUsers({required int pageKey}) async {
    try {
      ApiHelper apiHelper =
          ApiHelper(url: "${ApiUrl().listUserUrl}$pageKey");
      var response = await apiHelper.get();

      if (response.isNotEmpty) {
        final List<UserListModel> newItems = (response["data"] as List)
            .map((json) => UserListModel.fromJson(json))
            .toList();
        print(response["data"]);
        final isLastPage = newItems.length < pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }

        notifyListeners();
      } else {
        showToast(msg: "Something Went Wrong");
        pagingController.error = "Error";
      }
    } catch (error) {
      pagingController.error = error;
      showToast(msg: "$error");
    }
  }
}
