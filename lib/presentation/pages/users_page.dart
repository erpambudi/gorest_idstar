import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../common/constants/app_images.dart';
import '../bloc/user/user_detail_bloc.dart';
import '../bloc/user/users_bloc.dart';
import '../widgets/app_shimmer.dart';
import '../widgets/result_state_view.dart';
import '../widgets/search_bar.dart';
import '../widgets/user_item.dart';
import 'user_detail_page.dart';
import 'user_form_page.dart';
import '../../data/models/user_data.dart';
import '../../common/constants/app_values.dart';
import '../../common/styles/app_colors.dart';

class UsersPage extends StatefulWidget {
  static const routeName = '/users';

  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final PagingController<int, UserData> _pagingController =
      PagingController(firstPageKey: 1);

  final int _pageSize = 20;

  String? queryName;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context
          .read<UsersBloc>()
          .add(GetUsersEvent(pageKey, _pageSize, queryName: queryName));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengguna"),
      ),
      backgroundColor: AppColors.white,
      body: BlocListener<UsersBloc, UsersState>(
        listener: ((context, state) {
          if (state is UsersHasData) {
            bool isLastPage = state.users.length < _pageSize;

            if (isLastPage) {
              _pagingController.appendLastPage(state.users);
            } else {
              _pagingController.appendPage(state.users, state.currentPage + 1);
            }
          }

          if (state is UsersError) {
            _pagingController.error = state.message;
          }
        }),
        child: Column(
          children: [
            //Search Form
            AppSearchBar(
              onChanged: (value) {
                queryName = value;
                _pagingController.refresh();
              },
            ),
            const SizedBox(
              height: AppValues.margin,
            ),

            //List User
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => _pagingController.refresh(),
                ),
                child: PagedListView<int, UserData>.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<UserData>(
                    animateTransitions: true,
                    itemBuilder: (context, item, index) {
                      return GestureDetector(
                        onTap: () async {
                          context
                              .read<UserDetailBloc>()
                              .add(GetDetailUserEvent(item.id!));

                          var isReload = await Navigator.pushNamed(
                              context, UserDetailPage.routeName);

                          if (isReload != null && isReload is bool) {
                            _pagingController.refresh();
                          }
                        },
                        child: UserItem(item),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return const UsersShimmer();
                    },
                    noItemsFoundIndicatorBuilder: (context) {
                      return const ResultStateView(
                        AppImages.emptyData,
                        "Oppss.. Pengguna tidak ditemukan",
                      );
                    },
                  ),
                  separatorBuilder: (context, index) => Container(),
                ),
              ),
            ),
          ],
        ),
      ),

      //Add User Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var isReload =
              await Navigator.pushNamed(context, UserFormPage.routeName);

          if (isReload != null && isReload is bool) {
            _pagingController.refresh();
          }
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
