import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final double height;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = TheColors.yellow, // Default color
    this.height = 50, // Default height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // borderRadius: const BorderRadius.only(
      //   bottomLeft: Radius.circular(30),
      //   bottomRight: Radius.circular(30),
      // ),
      child: AppBar(
        title: Text(title, style: TextStyles.siemreap(context,color: TheColors.bgColor,fontSize: 16)),
        centerTitle: true,
        backgroundColor: backgroundColor,
          iconTheme: IconThemeData(
    color: TheColors.bgColor, // set your drawer icon color here
  ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}