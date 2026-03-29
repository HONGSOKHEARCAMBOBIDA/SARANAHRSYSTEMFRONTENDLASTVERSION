import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/constants.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomEmployeeCard extends StatelessWidget {
  final String namekh;
  final String nameenglish;
  final String role;
  final String start_time;
  final String end_time;
  final String basesalary;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback onPromote;
  final VoidCallback onchangeshift;
  final VoidCallback chnagesalary;
  final VoidCallback increasesalry;
  final bool? isActive;
  final bool? isPromote;
  final String? shiftname;
  final String? branchname;
  final String profileImage;
  final String currencycode;
  final String currencysymbol;
  final String currencyname;

  const CustomEmployeeCard({
    Key? key,
    required this.increasesalry,
    required this.onchangeshift,
    required this.basesalary,
    required this.start_time,
    required this.end_time,
    required this.namekh,
    required this.nameenglish,
    required this.role,
    required this.onEdit,
    required this.onDelete,
    required this.onPromote,
    required this.onTap,
    required this.profileImage,
    required this.currencycode,
    required this.currencyname,
    required this.currencysymbol,
    this.shiftname,
    this.isActive,
    this.isPromote,
    this.branchname,
    required this.chnagesalary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar with online/offline dot
              Stack(
                children: [
                   Container(
                          decoration: BoxDecoration(
      border: Border.all(
        color: TheColors.warningColor,// Border color
        width: 0.9,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
                     child: Padding(
                       padding: const EdgeInsets.all(2.0),
                       child: CircleAvatar(
                                 radius: 30,
                                 backgroundColor: TheColors.bgColor,
                                 backgroundImage: profileImage!.isNotEmpty
                                     ? NetworkImage("${Appconstants.baseUrl}/profileimage/${profileImage}")
                                     : const NetworkImage(
                                         'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                                       ) as ImageProvider,
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
                        color: isActive == true
                            ? TheColors.successColor
                            : TheColors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isDarkMode ? Colors.grey[850]! : Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Employee info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name row
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            namekh,
                            style: TextStyles.siemreap(
                              context,
                              fontSize: 13,
                              fontweight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "(${nameenglish})",
                            style: GoogleFonts.siemreap(
                              fontSize: 11,
                              color: TheColors.orange,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                         
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Role
                    Row(
                      children: [
                        const Icon(Icons.security_outlined,
                            size: 14, color: TheColors.orange),
                        const SizedBox(width: 4),
                        Text(
                          role,
                          style: GoogleFonts.siemreap(
                            fontSize: 11,
                            color: TheColors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Shift time
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
   
                          Text(
                            "$start_time - $end_time",
                            style: TextStyles.siemreap(context,color: TheColors.secondaryColor,fontSize: 11)
                          ),
                          SizedBox(width: 3,),
                          Text("("),
                          Padding(
                            padding: const EdgeInsets.only(right: 2,left: 2),
                            child: Text("${shiftname}",style: TextStyles.siemreap(context,color: TheColors.secondaryColor,fontSize: 11),),
                          ),
                          Text(")")
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Base salary
                    Row(
                      children: [
                      
                      
                        Row(
                          children: [
                            Text(
                              "$basesalary",
                              style: GoogleFonts.siemreap(
                                fontSize: 12,
                                color: TheColors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("$currencysymbol",style: GoogleFonts.siemreap(fontSize: 13,color: TheColors.red),)
                          ],
                        ),
                        SizedBox(width: 1,),
                        Text("~"),
                        SizedBox(width: 2,),
                                                  Text("${branchname}",style: TextStyles.siemreap(context,fontSize: 9,color: TheColors.secondaryColor),)
                      ],
                    ),
                  ],
                ),
              ),
              _buildActionMenu(context),
            ],
          ),
        ),
      ),
    );
  }

Widget _buildActionMenu(BuildContext context) {
  final theme = Theme.of(context);

  return PopupMenuButton<String>(
    icon: Icon(
      Icons.more_vert,
      color: theme.iconTheme.color?.withOpacity(0.7),
    ),
    
    color: TheColors.bgColor,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    onSelected: (value) {
      if (value == 'edit') {
        onEdit();
      } else if (value == 'delete') {
        onDelete();
      } else if (value == 'promote'){
        onPromote();
      }
      else if (value == 'changeshift') {
          onchangeshift();
  } else if (value == 'changesalary'){
          chnagesalary();

  } else if (value == 'increasesalary'){
    increasesalry();
  }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        
        value: 'edit',
        child: Row(
          children: [
            const Icon(Icons.edit, color: TheColors.orange, size: 20),
            const SizedBox(width: 8),
            Text('កែប្រែ', style: TextStyles.siemreap(context, fontSize: 12)),
          ],
        ),
      ),
      PopupMenuItem(
        
        value: 'delete',
        child: Row(
          children: [
            Icon(
              isActive == true ? Icons.block : Icons.check_circle,
              color: isActive == true
                  ? TheColors.errorColor
                  : TheColors.successColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              isActive == true ? 'បិទ' : 'បើក',
              style: TextStyles.siemreap(context, fontSize: 12),
            ),
          ],
        ),
      ),
            PopupMenuItem(
        
        value: 'promote',
        child: Row(
          children: [
            Icon(
              isPromote == true ? Icons.check_circle : Icons.pending,
              color: isPromote == true
                  ? TheColors.errorColor
                  : TheColors.successColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              isPromote == true ? 'បានវាយតម្លៃ' : 'មិនទាន់វាយតម្លៃ',
              style: TextStyles.siemreap(context, fontSize: 12),
            ),
          ],
        ),
      ),
      PopupMenuItem(
      
        value: 'changeshift',
        child: Row(
          children: [
            const Icon(Icons.lock_clock, color: TheColors.orange, size: 20),
            const SizedBox(width: 8),
            Text('ដូម៉ោងធ្វេីការ',
                style: TextStyles.siemreap(context, fontSize: 12)),
          ],
        ),
      ),
            PopupMenuItem(
      
        value: 'changesalary',
        child: Row(
          children: [
            const Icon(Icons.money_off, color: TheColors.secondaryColor, size: 20),
            const SizedBox(width: 8),
            Text('កែប្រាក់ខែ',
                style: TextStyles.siemreap(context, fontSize: 12)),
          ],
        ),
      ),
                  PopupMenuItem(
      
        value: 'increasesalary',
        child: Row(
          children: [
            const Icon(Icons.money_off, color: TheColors.secondaryColor, size: 20),
            const SizedBox(width: 8),
            Text('ដំឡេីងប្រាក់ខែ',
                style: TextStyles.siemreap(context, fontSize: 12)),
          ],
        ),
      ),
    ],
  );
}

}
