import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/constants/app_values.dart';
import '../../common/styles/app_text_styles.dart';
import '../../data/models/user_data.dart';
import '../bloc/user/user_manage_bloc.dart';
import '../widgets/app_dialog.dart';

class UserFormPage extends StatelessWidget {
  static const routeName = '/user-form';

  UserFormPage({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? gender;
    String? status;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pengguna"),
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
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppValues.padding,
              vertical: AppValues.largePadding,
            ),
            child: ListView(
              children: [
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
                  height: AppValues.margin_40,
                ),

                //Button Submit
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String name = nameController.text;
                        String email = emailController.text;

                        if (gender == null) {
                          AppDialog.showMainSnackbar(
                              context, "Pilih jenis kelamin");
                          return;
                        }

                        if (status == null) {
                          AppDialog.showMainSnackbar(context, "Pilih status");
                          return;
                        }

                        final userData = UserData(
                          name: name,
                          email: email,
                          gender: gender!,
                          status: status!,
                        );

                        AppDialog.showAlertDialog(
                          context,
                          "Tambah Pengguna",
                          "Apakah anda yakin data yang anda masukkan sudah benar?",
                          positiveButtonText: "Ya",
                          negativeButtonText: "Tidak",
                          positiveButtonCallback: () {
                            context
                                .read<UserManageBloc>()
                                .add(AddUserEvent(userData));
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Buat Pengguna",
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
          ),
        ),
      ),
    );
  }
}
