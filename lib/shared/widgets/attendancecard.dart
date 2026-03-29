import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';

class CustomAttendanceCard extends StatelessWidget {
  final String profile;
  final String nameKh;
  final String nameEn;
  final String role;
  final String checkIn;
  final String checkOut;
  final String shiftName;
  final String branchName;
  final String checkDate;
  final int isLate;
  final int? isLeftEarly;
  final String? latitudeCheckIn;
  final String? longitudeCheckIn;
  final String? latitudeCheckOut;
  final String? longitudeCheckOut;
  final bool? isZoonCheckIn;
  final bool? isZoonCheckOut;
  final String? notes;
  final VoidCallback onTap;
  final VoidCallback? onViewCheckInLocation;
  final VoidCallback? onViewCheckOutLocation;

  const CustomAttendanceCard({
    super.key,
    required this.profile,
    required this.nameKh,
    required this.nameEn,
    required this.role,
    required this.checkIn,
    required this.checkOut,
    required this.shiftName,
    required this.branchName,
    required this.checkDate,
    required this.isLate,
    required this.isLeftEarly,
    this.latitudeCheckIn,
    this.longitudeCheckIn,
    this.latitudeCheckOut,
    this.longitudeCheckOut,
    this.isZoonCheckIn,
    this.isZoonCheckOut,
    this.notes,
    required this.onTap,
    this.onViewCheckInLocation,
    this.onViewCheckOutLocation,
  });

  @override
  Widget build(BuildContext context) {
    final bool late = isLate == 1;
    final bool leftEarly = (isLeftEarly ?? 0) == 1;
    final bool hasCheckInLocation = latitudeCheckIn != null && longitudeCheckIn != null;
    final bool hasCheckOutLocation = latitudeCheckOut != null && longitudeCheckOut != null;
    final bool hasNotes = notes != null && notes!.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: TheColors.bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: TheColors.black, 
              width: 0.5
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      TheColors.orange.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(19),
                    topRight: Radius.circular(19),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar/Initials Circle
                         Container(
                          decoration: BoxDecoration(
      border: Border.all(
        color: isLate == true ? TheColors.red : TheColors.lightOrage,// Border color
        width: 0.9,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
                     child: Padding(
                       padding: const EdgeInsets.all(2.0),
                       child: CircleAvatar(
                                 radius: 30,
                                 backgroundColor: TheColors.bgColor,
                                 backgroundImage: profile!.isNotEmpty
                                     ? NetworkImage("${Appconstants.baseUrl}/profileimage/${profile}")
                                     : const NetworkImage(
                                         'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                                       ) as ImageProvider,
                               ),
                     ),
                   ),
                    const SizedBox(width: 12),
                    // Name and Role Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  nameKh,
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 16,
                                    fontweight: FontWeight.bold,
                                    color: TheColors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (nameEn.isNotEmpty)
                                Text(
                                  "($nameEn)",
                                  style: GoogleFonts.siemreap(
                                    fontSize: 12,
                                    color: TheColors.black.withOpacity(0.6),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: TheColors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.badge_outlined, size: 12, color: TheColors.orange),
                                const SizedBox(width: 4),
                                Text(
                                  role,
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 11,
                                    color: TheColors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Status Badge
                    if (late || leftEarly)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: late ? TheColors.errorColor.withOpacity(0.1) : TheColors.secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              late ? Icons.warning_amber_rounded : Icons.alarm_off_rounded,
                              size: 12,
                              color: late ? TheColors.errorColor : TheColors.secondaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              late ? "យឺត" : "ចេញមុន",
                              style: TextStyles.siemreap(
                                context,
                                fontSize: 10,
                                fontweight: FontWeight.w600,
                                color: late ? TheColors.warningColor : TheColors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              
              const Divider(height: 1, thickness: 1),
              
              // Content Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shift & Date Card
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.business_center, size: 16, color: TheColors.secondaryColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "$shiftName (${"សាខា: "+branchName})",
                              style: TextStyles.siemreap(
                                context,
                                fontSize: 12,
                                color: TheColors.secondaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_today, size: 10, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  checkDate,
                                  style: GoogleFonts.siemreap(
                                    fontSize: 11,
                                    color: TheColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Check-in/Check-out Section
                    Row(
                      children: [
                        // Check-in Card
                        Expanded(
                          child: _buildTimeCard(
                            context: context,
                            title: "ចូល",
                            time: checkIn,
                            color: TheColors.successColor,
                            icon: Icons.login,
                            hasLocation: hasCheckInLocation,
                            isInZone: isZoonCheckIn,
                            onViewLocation: onViewCheckInLocation,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Check-out Card
                        Expanded(
                          child: _buildTimeCard(
                            context: context,
                            title: "ចេញ",
                            time: checkOut,
                            color: TheColors.errorColor,
                            icon: Icons.logout,
                            hasLocation: hasCheckOutLocation,
                            isInZone: isZoonCheckOut,
                            onViewLocation: onViewCheckOutLocation,
                          ),
                        ),
                      ],
                    ),
                    
                    // Notes Section
                    if (hasNotes) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: TheColors.orange.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: TheColors.orange.withOpacity(0.2)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.note_outlined, size: 14, color: TheColors.gray),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                notes!,
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 11,
                                  color: TheColors.gray,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeCard({
    required BuildContext context,
    required String title,
    required String time,
    required Color color,
    required IconData icon,
    required bool hasLocation,
    required bool? isInZone,
    required VoidCallback? onViewLocation,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color,width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                title,
                style: TextStyles.siemreap(
                  context,
                  fontSize: 12,
                  fontweight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            time.isEmpty ? "---" : time,
            style: TextStyles.siemreap(
              context,
              fontSize: 14,
              fontweight: FontWeight.bold,
              color: time.isEmpty ? Colors.grey : color,
            ),
          ),
          const SizedBox(height: 8),
          if (isInZone != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isInZone ? TheColors.successColor.withOpacity(0.1) : TheColors.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isInZone ? Icons.check_circle : Icons.cancel,
                    size: 10,
                    color: isInZone ? TheColors.successColor : TheColors.errorColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isInZone ? "ក្នុងតំបន់" : "ក្រៅតំបន់",
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 9,
                      color: isInZone ? TheColors.successColor : TheColors.errorColor,
                    ),
                  ),
                ],
              ),
            ),
          if (hasLocation && onViewLocation != null) ...[
            const SizedBox(height: 8),
            InkWell(
              onTap: onViewLocation,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(
                      "មើលទីតាំង",
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 10,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}