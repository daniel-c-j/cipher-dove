import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/_constants.dart';
import '../../../../../util/context_shortcut.dart';

class AlgorithmSelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AlgorithmSelectionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: kColor(context).surfaceDim,
      actions: [
        Flexible(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Flexible(
                child: TextFormField(
                  style: kTextStyle(context).bodySmall,
                  autofocus: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(gapPadding: 0),
                    hintText: "Search here",
                    hintStyle: kTextStyle(context).bodySmall,
                    contentPadding: const EdgeInsets.only(top: 8, bottom: 8, right: 12, left: 12),
                    isDense: true,
                    suffixIcon: Icon(
                      Icons.public,
                      size: 20,
                    ),
                  ),
                ),
              ),
              GAP_W12,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
