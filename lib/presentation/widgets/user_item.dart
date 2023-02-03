import 'package:flutter/material.dart';
import 'package:gorest_idstar/common/constants/app_images.dart';
import 'package:gorest_idstar/common/constants/app_values.dart';
import 'package:gorest_idstar/common/styles/app_colors.dart';
import 'package:gorest_idstar/common/styles/app_text_styles.dart';
import 'package:gorest_idstar/data/models/user_data.dart';

class UserItem extends StatelessWidget {
  final UserData user;

  const UserItem(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppValues.halfPadding,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppValues.radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppValues.padding),
          child: Row(
            children: [
              Image.asset(
                user.gender == "male" ? AppImages.male : AppImages.female,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: AppValues.margin,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? "-",
                      style: AppTextStyle.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: AppValues.margin_4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                          width: 10,
                          child: Icon(
                            Icons.email,
                            color: AppColors.grey,
                            size: 10,
                          ),
                        ),
                        const SizedBox(
                          width: AppValues.margin_4,
                        ),
                        Expanded(
                          child: Text(
                            user.email ?? "-",
                            maxLines: 1,
                            style: AppTextStyle.subtitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppValues.smallMargin,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: user.status == "active"
                                ? Colors.green
                                : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: AppValues.margin_4,
                        ),
                        Expanded(
                          child: Text(
                            user.status != null
                                ? user.status![0].toUpperCase() +
                                    user.status!.substring(1)
                                : "-",
                            maxLines: 1,
                            style: AppTextStyle.subtitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
