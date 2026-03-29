import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';

class CustomRoleCard extends StatelessWidget {
  final String name;
  final String displayname;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback? deletepermission;
  final bool? isActive;
  final String? avatarUrl;
  final String? roleDescription;
  final DateTime? createdAt;

  const CustomRoleCard({
    Key? key,
    required this.name,
    required this.displayname,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    this.deletepermission,
    this.isActive,
    this.avatarUrl,
    this.roleDescription,
    this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar Section
                _buildAvatar(isDarkMode),
                const SizedBox(width: 16),
                // Content Section
                Expanded(
                  child: _buildContentSection(context),
                ),
                // Actions Section
                _buildActionMenu(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(bool isDarkMode) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                TheColors.primaryColor.withOpacity(0.2),
                TheColors.secondaryColor.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: CachedNetworkImage(
              imageUrl: avatarUrl ??
                  "https://cdn-icons-png.flaticon.com/512/9940/9940338.png",
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 56,
                height: 56,
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.grey[400],
                  size: 32,
                ),
              ),
            ),
          ),
        ),
        // Status Indicator with animation
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: isActive == true
                ? TheColors.successColor
                : isActive == false
                    ? TheColors.red
                    : Colors.orange,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDarkMode ? Colors.grey[850]! : Colors.white,
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: (isActive == true
                        ? TheColors.successColor
                        : Colors.grey)
                    .withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                displayname,
                style: GoogleFonts.siemreap(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
           
          ],
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyles.siemreap(
            context,
            fontSize: 12,
            color: TheColors.secondaryColor.withOpacity(0.7),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (roleDescription != null) ...[
          const SizedBox(height: 8),
          Text(
            roleDescription!,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        // Status Badge (optional)
        if (isActive != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (isActive == true
                      ? TheColors.successColor
                      : TheColors.red)
                  .withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive == true ? Icons.circle : Icons.circle_outlined,
                  size: 8,
                  color: isActive == true ? TheColors.successColor : TheColors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive == true ? 'សកម្ម' : 'អសកម្ម',
                  style: GoogleFonts.siemreap(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isActive == true
                        ? TheColors.successColor
                        : TheColors.bgColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionMenu(BuildContext context) {
    final theme = Theme.of(context);

    return Builder(
      builder: (innerContext) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.1),
          ),
          child: IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: theme.iconTheme.color?.withOpacity(0.7),
              size: 20,
            ),
            onPressed: () {
              final box = innerContext.findRenderObject() as RenderBox;
              final overlay =
                  Overlay.of(innerContext).context.findRenderObject()
                      as RenderBox;
              final position = RelativeRect.fromRect(
                Rect.fromPoints(
                  box.localToGlobal(Offset.zero, ancestor: overlay),
                  box.localToGlobal(
                    box.size.bottomRight(Offset.zero),
                    ancestor: overlay,
                  ),
                ),
                Offset.zero & overlay.size,
              );

              showPopover(
                context: innerContext,
                bodyBuilder: (context) => _buildPopoverContent(context),
                direction: PopoverDirection.bottom,
                width: 160,
                height: 150,
                arrowHeight: 8,
                arrowWidth: 16,
                radius: 12,
                backgroundColor: Colors.transparent,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPopoverContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Material(
      elevation: 8,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMenuItem(
            context,
            icon: Icons.edit_outlined,
            color: theme.colorScheme.primary,
            text: 'កែប្រែ',
            onTap: onEdit,
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: isActive == true ? Icons.block_outlined : Icons.check_circle_outline,
            color: isActive == true ? Colors.orange : TheColors.successColor,
            text: isActive == true ? 'បិទ' : 'បើក',
            onTap: () => _confirmStatusChange(context),
          ),
          _buildDivider(),
          _buildMenuItem(
            context,
            icon: Icons.lock_outline,
            color: TheColors.errorColor,
            text: "ដកសិទ្ធ",
            onTap: deletepermission!,
          ),
        ],
      ),
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
        Navigator.of(context).pop(); // Close the popover
        onTap();
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.siemreap(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.withOpacity(0.2),
    );
  }

  void _confirmStatusChange(BuildContext context) {
    final actionText = isActive == true ? 'បិទ' : 'បើក';
    final confirmMessage = isActive == true
        ? 'តើអ្នកពិតជាចង់បិទតួនាទីនេះមែនទេ?'
        : 'តើអ្នកពិតជាចង់បើកតួនាទីនេះមែនទេ?';

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]
                : Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (isActive == true ? Colors.orange : TheColors.successColor)
                      .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isActive == true ? Icons.warning_amber_rounded : Icons.check_circle,
                  color: isActive == true ? Colors.orange : TheColors.successColor,
                  size: 32,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                confirmMessage,
                style: GoogleFonts.siemreap(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){Get.back();},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('បោះបង់', style: GoogleFonts.siemreap()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onDelete();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isActive == true
                            ? Colors.orange
                            : TheColors.successColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        actionText,
                        style: GoogleFonts.siemreap(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

 
}