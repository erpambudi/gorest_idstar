import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants/app_images.dart';
import '../../common/constants/app_values.dart';
import '../../common/styles/app_text_styles.dart';
import '../../data/models/user_data.dart';
import '../bloc/user/user_detail_bloc.dart';
import '../bloc/user/user_manage_bloc.dart';
import '../widgets/app_dialog.dart';
import '../widgets/result_state_view.dart';

class UserDetailPage extends StatelessWidget {
  static const routeName = '/user-detail';

  UserDetailPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? gender;
    String? status;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pengguna"),
      ),
      body: BlocListener<UserManageBloc, UserManageState>(
        listener: (context, state) {
          if (state is UserManageLoading) {
            AppDialog.showMainLoading(context);
          }

          if (state is UserManageSuccess) {
            AppDialog.hideMainLoading(context);

            AppDialog.showMainSnackbar(
              context,
              state.message,
              isSuccess: true,
            );

            Navigator.of(context).pop(true);
          }

          if (state is UserManageError) {
            AppDialog.hideMainLoading(context);

            AppDialog.showMainSnackbar(
              context,
              state.message,
              isError: true,
            );
          }
        },
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: ((context, state) {
            if (state is UserDetailHasData) {
              nameController.text = state.user.name ?? "";
              emailController.text = state.user.email ?? "";

              gender = state.user.gender;
              status = state.user.status;

              return Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.padding,
                    vertical: AppValues.largePadding,
                  ),
                  children: [
                    //Image
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        bottom: AppValues.margin_18,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            state.user.gender == "male"
                                ? AppImages.male
                                : AppImages.female,
                          ),
                        ),
                      ),
                    ),

                    //Name
                    TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama tidak boleh kosong";
                        }

                        if (value.trim() == "") {
                          return "Masukkan nama dengan benar";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Nama",
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.margin,
                    ),

                    //Email
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      enableSuggestions: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email tidak boleh kosong";
                        }

                        if (!EmailValidator.validate(value)) {
                          return "Email yang dimasukkan tidak valid";
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.margin,
                    ),

                    //Gender
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jenis Kelamin",
                              style: AppTextStyle.title.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: AppValues.margin_4,
                            ),
                            RadioListTile(
                              title: const Text("Laki - Laki"),
                              dense: true,
                              value: "male",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppValues.paddingZero,
                                vertical: AppValues.paddingZero,
                              ),
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Perempuan"),
                              dense: true,
                              value: "female",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppValues.paddingZero,
                                vertical: AppValues.paddingZero,
                              ),
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: AppValues.margin,
                    ),

                    //Status
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status",
                              style: AppTextStyle.title.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: AppValues.margin_4,
                            ),
                            RadioListTile(
                              title: const Text("Aktif"),
                              dense: true,
                              value: "active",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppValues.paddingZero,
                                vertical: AppValues.paddingZero,
                              ),
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              groupValue: status,
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                            RadioListTile(
                              title: const Text("Tidak Aktif"),
                              dense: true,
                              value: "inactive",
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppValues.paddingZero,
                                vertical: AppValues.paddingZero,
                              ),
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              groupValue: status,
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: AppValues.margin_32,
                    ),

                    //Update User Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            int id = state.user.id!;
                            String name = nameController.text;
                            String email = emailController.text;

                            if (gender == null) {
                              AppDialog.showMainSnackbar(
                                  context, "Pilih jenis kelamin");
                              return;
                            }

                            if (status == null) {
                              AppDialog.showMainSnackbar(
                                  context, "Pilih status");
                              return;
                            }

                            var userData = UserData(
                              id: id,
                              name: name,
                              email: email,
                              gender: gender!,
                              status: status!,
                            );

                            AppDialog.showAlertDialog(
                              context,
                              "Perbaharui Pengguna",
                              "Apakah anda yakin ingin memperbaharui pengguna ini?",
                              positiveButtonText: "Ya",
                              negativeButtonText: "Tidak",
                              positiveButtonCallback: () {
                                context
                                    .read<UserManageBloc>()
                                    .add(UpdateUserEvent(userData));
                              },
                            );
                          }
                        },
                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.margin,
                    ),

                    //Delete User Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          int id = state.user.id!;

                          AppDialog.showAlertDialog(
                            context,
                            "Hapus Pengguna",
                            "Apakah anda yakin ingin menghapus pengguna ini?",
                            positiveButtonText: "Ya",
                            negativeButtonText: "Tidak",
                            positiveButtonCallback: () {
                              context
                                  .read<UserManageBloc>()
                                  .add(DeleteUserEvent(id));
                            },
                          );
                        },
                        child: const Text(
                          "Hapus Pengguna",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppValues.margin_40,
                    ),
                  ],
                ),
              );
            }

            if (state is UserDetailError) {
              return ResultStateView(
                AppImages.errorData,
                state.message,
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }
}
