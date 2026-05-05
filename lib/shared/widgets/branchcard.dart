import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';

class CustomBranchcard extends StatelessWidget {
  final String name;
  final double latitube;
  final double longitude;
  final int radius;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final int? isActive;

  const CustomBranchcard({
    Key? key,
    required this.latitube,
    required this.longitude,
    required this.radius,
    required this.name,
    required this.onEdit,
    required this.onDelete,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏢 Branch icon + status
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Container(
                                 decoration: BoxDecoration(
      border: Border.all(
        color: TheColors.warningColor,// Border color
        width: 0.9,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdn-icons-png.flaticon.com/128/10601/10601172.png",
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isActive == 1
                        ? TheColors.successColor
                        : TheColors.red,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[850]! : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
    
          const SizedBox(width: 12),
    
          // 🧭 Branch details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 12,
                    fontweight: FontWeight.bold,
                    color: TheColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: TheColors.errorColor),
                    const SizedBox(width: 4),
                    Text(
                      "Lat: ${latitube.toStringAsFixed(5)}, Lng: ${longitude.toStringAsFixed(5)}",
                      style: TextStyles.siemreap(context,
                          fontSize: 10, color:TheColors.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.circle_outlined, size: 14, color: TheColors.orange),
                    const SizedBox(width: 4),
                    Text(
                      "Radius: ${radius.toStringAsFixed(1)}m",
                      style: TextStyles.siemreap(context,
                          fontSize: 10, color: TheColors.gray),
                    ),
                  ],
                ),
              ],
            ),
          ),
    
          // ⋮ Action menu
          _buildActionMenu(context),
        ],
      ),
    );
  }

  Widget _buildActionMenu(BuildContext context) {
    final theme = Theme.of(context);

    return Builder(
      builder: (innerContext) {
        return IconButton(
          icon: Icon(
            Icons.more_vert,
            color: theme.iconTheme.color?.withOpacity(0.7),
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            showPopover(
              context: innerContext,
              bodyBuilder: (context) => Material(
                elevation: 6,
                color: TheColors.bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.edit,
                      color: theme.colorScheme.primary,
                      text: 'កែប្រែ',
                      onTap: onEdit,
                    ),
                    _buildMenuItem(
                      context,
                      icon: isActive == 1
                          ? Icons.block
                          : Icons.check_circle_outline,
                      color: isActive == 1
                          ? TheColors.errorColor
                          : TheColors.successColor,
                      text: isActive == 1 ? 'បិទ' : 'បើក',
                      onTap: () => _confirmDelete(context),
                    ),
                  ],
                ),
              ),
              direction: PopoverDirection.bottom,
              width: 140,
              height: 90,
              arrowHeight: 10,
              arrowWidth: 20,
              radius: 8,
            );
          },
        );
      },
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyles.siemreap(context, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    final actionText = isActive == 1 ? 'បិទ' : 'បើក';
    final confirmMessage =
        isActive == 1 ? 'តើអ្នកពិតជាចង់បិទសាខានេះមែនទេ?' : 'តើអ្នកពិតជាចង់បើកសាខានេះមែនទេ?';

    showDialog(
      
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: TheColors.bgColor,
        title: Text('បញ្ជាក់', style: GoogleFonts.siemreap(fontWeight: FontWeight.bold)),
        content: Text(confirmMessage, style: GoogleFonts.siemreap()),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('បោះបង់', style: GoogleFonts.siemreap()),
          ),
          TextButton(
            onPressed: () {
              onDelete();
             // Get.back();
            },
            child: Text(actionText, style: GoogleFonts.siemreap()),
          ),
        ],
      ),
    );
  }
}
