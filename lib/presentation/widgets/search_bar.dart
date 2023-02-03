import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../common/constants/app_values.dart';
import '../../common/styles/app_colors.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    Key? key,
    this.onChanged,
    this.debounceTime,
  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final StreamController<String> _textChangeStreamController =
      StreamController();
  late StreamSubscription _textChangesSubscription;

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
          widget.debounceTime ?? const Duration(seconds: 1),
        )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        setState(() {
          onChanged(text);
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppValues.margin,
        AppValues.margin,
        AppValues.margin,
        AppValues.marginZero,
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Cari pengguna",
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? InkWell(
                  onTap: () {
                    setState(() {
                      _searchController.clear();
                      widget.onChanged?.call("");
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.grey,
                  ),
                )
              : null,
        ),
        onChanged: _textChangeStreamController.add,
      ),
    );
  }
}
