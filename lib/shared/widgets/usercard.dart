import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUserCard extends StatelessWidget {
  final String namekh;
  final String nameenglish;
  final String role;
  final String branch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool? isActive;

  const CustomUserCard({
    Key? key,
    required this.namekh,
    required this.nameenglish,
    required this.role,
    required this.branch,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [
                        Colors.grey[900]!,
                        Colors.grey[850]!,
                      ]
                    : [
                        Colors.white,
                        Colors.grey[50]!,
                      ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isActive == true 
                    ? TheColors.successColor.withOpacity(0.3)
                    : TheColors.red.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Modern avatar with gradient border
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isActive == true
                          ? [TheColors.successColor, TheColors.successColor.withOpacity(0.7)]
                          : [TheColors.red, TheColors.red.withOpacity(0.7)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isActive == true ? TheColors.successColor : TheColors.red).withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Image.asset(
                            'assets/user/information.png',
                            width: 52,
                            height: 52,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // User info with modern typography
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              namekh,
                              style: GoogleFonts.siemreap(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? Colors.white : Colors.grey[800],
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: TheColors.secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              branch,
                              style: GoogleFonts.siemreap(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: TheColors.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Role with modern pill design
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: TheColors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          role,
                          style: GoogleFonts.siemreap(
                            color: TheColors.orange,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // English name with subtle style
                      Text(
                        nameenglish,
                        style: GoogleFonts.siemreap(
                          fontSize: 11,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Modern action menu
                _buildModernActionMenu(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernActionMenu(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_horiz,
          color: theme.iconTheme.color?.withOpacity(0.7),
          size: 20,
        ),
        padding: EdgeInsets.zero,
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        offset: const Offset(0, 40),
        onSelected: (value) {
          if (value == 'edit') {
            onEdit();
          } else if (value == 'delete') {
            onDelete();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: TheColors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.edit, color: TheColors.orange, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  'កែប្រែ',
                  style: GoogleFonts.siemreap(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white : Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: (isActive == true 
                        ? TheColors.errorColor 
                        : TheColors.successColor).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isActive == true ? Icons.person_remove : Icons.person_add,
                    color: isActive == true
                        ? TheColors.errorColor
                        : TheColors.successColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  isActive == true ? 'បិទគណនី' : 'បើកគណនី',
                  style: GoogleFonts.siemreap(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isActive == true
                        ? TheColors.errorColor
                        : TheColors.successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}