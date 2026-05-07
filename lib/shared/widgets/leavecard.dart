import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/leavemodel.dart';
import 'package:flutter_application_10/modules/leave/leavecontroller/leavecontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LeaveCard extends StatelessWidget {
  final leavecontroller = Get.find<Leavecontroller>();
  final Data leaveData;
  final VoidCallback? onTap;

  LeaveCard({Key? key, required this.leaveData, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: TheColors.orange, width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Employee Info and Status
                _buildHeader(context),

                const SizedBox(height: 16),

                // Leave Details
                _buildLeaveDetails(),

                const SizedBox(height: 12),
                _buildleave(),
                const SizedBox(height: 12),
                // Dates and Duration
                _buildDateInfo(),

                const SizedBox(height: 12),

                // Description (if available)
                if (leaveData.description != null &&
                    leaveData.description!.isNotEmpty)
                  _buildDescription(),

                const SizedBox(height: 8),

                // Approver Info (if available)
                if (leaveData.approveByName != null &&
                    leaveData.approveByName!.isNotEmpty)
                  _buildApproverInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Employee Avatar and Basic Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    leaveData.employeeNameKhmer ?? 'Unknown Employee',
                    style: TextStyles.siemreap(
                      context,
                      color: TheColors.black,
                      fontSize: 14,
                      fontweight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    leaveData.employeeNameEnglish ?? 'Unknown Employee',
                    style: TextStyles.siemreap(
                      context,
                      color: TheColors.successColor,
                      fontSize: 12,
                      fontweight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (leaveData.roleName != null)
                Row(
                  children: [
                    Text("តួនាទី :", style: TextStyles.siemreap(context,color: TheColors.errorColor,fontSize: 12),),
                    SizedBox(width: 6,),
                    Text(
                      leaveData.roleName!,
                      style: TextStyles.siemreap(context,color: TheColors.errorColor,fontSize: 12),
                      // style: Theme.of(
                      //   context,
                      // ).textTheme.bodySmall?.copyWith(color: TheColors.orange),
                    ),
                  ],
                ),
              const SizedBox(height: 4),
              if (leaveData.branchName != null)
                Text(
                  leaveData.branchName!,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 11,
                    color: TheColors.secondaryColor,
                  ),
                ),
            ],
          ),
        ),

        // Status Chip
        InkWell(
          onTap: () {
            leavecontroller.changstatusleave(leaveid: leaveData.id!);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor(leaveData.status),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _getStatusText(leaveData.status),
              style: TextStyles.siemreap(
                context,
                color: TheColors.lightGreyColor,
                fontSize: 11,
                fontweight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveDetails() {
    return Wrap(
      spacing: 8,
      runSpacing: 5,
      children: [
        if (leaveData.type != null)
          _InfoChip(
            icon: Icons.category_outlined,
            text: _getLeaveTypeText(leaveData.type!),
          ),
        if (leaveData.leaveDays != null)
          _InfoChip(
            
            icon: Icons.calendar_today_outlined,
            text:
                '${leaveData.leaveDays} ${leaveData.leaveDays == 1 ? 'ថ្ងៃ' : 'ថ្ងៃ'}',
          ),
      ],
    );
  }

  Widget _buildleave() {
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: [
        if (leaveData.isPermission == 1)
          _InfoChip1(
            icon: Icons.check_circle_outline,

            text: 'មានច្បាប់',
            color: TheColors.secondaryColor,
          ),
        if (leaveData.isWithoutPermission == 1)
          _InfoChip1(
            icon: Icons.warning_amber_outlined,
            text: 'អត់ច្បាប់',
            color: TheColors.red,
          ),
        if (leaveData.isWeekend == 1)
          _InfoChip1(
            icon: Icons.warning_amber_outlined,
            text: 'ឈប់សុក្រ~សៅរ៍',
            color: TheColors.errorColor,
          ),
      ],
    );
  }

  Widget _buildDateInfo() {
    return Row(
      children: [
        _DateInfoItem(
          icon: Icons.play_arrow_outlined,
          label: 'ចាប់ពីថ្ងៃ',
          date: leaveData.startDate,
        ),
        const SizedBox(width: 16),
        _DateInfoItem(
          icon: Icons.play_arrow_outlined,
          label: 'រហូតដល់',
          date: leaveData.endDate,
        ),
        const Spacer(),
        if (leaveData.shiftName != null)
          Text(
            leaveData.shiftName!,
            style: GoogleFonts.siemreap(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: TheColors.black,
            ),
          ),
      ],
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: TheColors.orange, width: 0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'បរិយាយ',
              style: GoogleFonts.siemreap(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: TheColors.errorColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              leaveData.description!,
              style: GoogleFonts.siemreap(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApproverInfo() {
    return Row(
      children: [
        Icon(Icons.verified_user_outlined, size: 16, color: TheColors.infoColor),
        const SizedBox(width: 6),
        Text(
          'អនុម័តដោយ : ${leaveData.approveByName}',
          style: GoogleFonts.siemreap(
            fontSize: 12,
            color: TheColors.secondaryColor,
          ),
        ),
      ],
    );
  }

  // Helper methods
  Color _getStatusColor(int? status) {
    switch (status) {
      case 1: // Approved
        return TheColors.warningColorv2;
      case 0: // Rejected
        return TheColors.successColor;
      case 2: // Pending
      default:
        return TheColors.red;
    }
  }

  String _getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'កំពុងស្នេីរ';
      case 2:
        return 'បដិសេដ';
      case 0:
      default:
        return 'បានអនុម័ត្ត';
    }
  }

  String _getLeaveTypeText(int type) {
    // You can customize this based on your type values
    switch (type) {
      case 1:
        return 'Part Time';
      case 2:
        return 'Full Time';
      case 3:
        return 'other';
      default:
        return '';
    }
  }
}

// Custom chip for leave details
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const _InfoChip({required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? Colors.blue[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? Colors.blue),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.siemreap(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color ?? Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip1 extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const _InfoChip1({required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? Colors.blue[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: GoogleFonts.siemreap(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: TheColors.bgColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Date information item
class _DateInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? date;

  const _DateInfoItem({
    required this.icon,
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: TheColors.errorColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.siemreap(
                fontSize: 12,
                color: TheColors.secondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Text(
            _formatDate(date) ?? 'N/A',
            style: GoogleFonts.siemreap(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  String? _formatDate(String? dateString) {
    if (dateString == null) return null;
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

// Usage example:
class LeaveListWidget extends StatelessWidget {
  final LeaveModel leaveModel;

  const LeaveListWidget({Key? key, required this.leaveModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: leaveModel.data?.length ?? 0,
      itemBuilder: (context, index) {
        final leaveData = leaveModel.data![index];
        return LeaveCard(
          leaveData: leaveData,
          onTap: () {
            // Handle card tap
          },
        );
      },
    );
  }
}
