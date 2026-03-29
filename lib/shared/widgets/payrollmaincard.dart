import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/format.dart';
import 'package:flutter_application_10/core/theme/constants/constants.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/payrollmodel.dart';
import 'package:flutter_application_10/modules/payroll/payrollcontroller/payrollcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Payrollmaincard extends StatefulWidget {
  final Data payrollData;
  final Function(double, int) onLoanDeductionChanged;

  Payrollmaincard({
    Key? key,
    required this.payrollData,
    required this.onLoanDeductionChanged,
  }) : super(key: key);

  @override
  State<Payrollmaincard> createState() => _PayrollmaincardState();
}

class _PayrollmaincardState extends State<Payrollmaincard> {
  final payrollcontroller = Get.find<Payrollcontroller>();
  final loandeduction = TextEditingController();


  // State variables for expandable sections
  final RxBool _isPersonalInfoExpanded = false.obs;
  final RxBool _isWorkInfoExpanded = false.obs;
  final RxBool _isSalaryInfoExpanded = true.obs;
  final RxBool _isDeductionsExpanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
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
              // Header Section (Always visible)
              _buildHeaderSection(),
              const SizedBox(height: 16),

              // Personal Information - Expandable
              _buildExpandableSection(
                title: 'ព័តមាន បុគ្គលិក',
                isExpanded: _isPersonalInfoExpanded,
                content: _buildPersonalInfoContent(),
              ),

              // Work Details - Expandable
              _buildExpandableSection(
                title: 'ព័តមាន ការងារ',
                isExpanded: _isWorkInfoExpanded,
                content: _buildWorkInfoContent(),
              ),

              // Salary Information - Expandable
              _buildExpandableSection(
                title: 'ព័តមាន ប្រាក់ខែ',
                isExpanded: _isSalaryInfoExpanded,
                content: _buildSalaryContent(),
              ),

              // Deductions - Expandable
              _buildExpandableSection(
                title: 'លុយកាត់សរុប',
                isExpanded: _isDeductionsExpanded,
                content: _buildDeductionsContent(),
              ),

              // Loan Information - Expandable (if exists)
            ],
          ),
        ),
      ),
    );
  }

  // Header Section (Always visible)
  Widget _buildHeaderSection() {
    return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.payrollData.nameKh ?? 'Unknown Employee',
                    style: GoogleFonts.siemreap(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: TheColors.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.payrollData.roleName ?? 'No Role',
                    style: GoogleFonts.siemreap(
                      fontSize: 11,
                      color: TheColors.orange,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8,),
                   Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: TheColors.yellow,width: 0.5),
    color: TheColors.bgColor,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: widget.payrollData.employee_profile!.isNotEmpty
          ? NetworkImage("${Appconstants.baseUrl}/profileimage/${widget.payrollData.employee_profile}")
          : const NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
            ),
    ),
  ),
),
            ],
          ),
        ),
 SizedBox(width: 4,),
        // Net Salary Display
    Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
     Expanded(
      child: Row(
        children: [
  
    Container(
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: TheColors.yellow,width: 0.5),
    color: TheColors.bgColor,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: widget.payrollData.qrcode!.isNotEmpty
          ? NetworkImage("${Appconstants.baseUrl}/qrcodeimage/${widget.payrollData.qrcode}")
          : const NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
            ),
    ),
  ),
),
        ],
      ),
    ),
           GestureDetector(
            onTap: ()async{
              payrollcontroller.deletepayroll(ID: widget.payrollData.id!);
            },
            child: Icon(Icons.delete,color: const Color.fromARGB(255, 255, 17, 0),))
        ],
      ),
    ),
    
    
    
      ],
    );
  }

  // Reusable Expandable Section Widget
  Widget _buildExpandableSection({
    required String title,
    required RxBool isExpanded,
    required Widget content,
  }) {
    return Obx(
      () => Column(
        children: [
          // Section Header with Expand/Collapse button
          Container(
            decoration: BoxDecoration(
              color: isExpanded.value
                  ? TheColors.orange.withOpacity(0.05)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () => isExpanded.value = !isExpanded.value,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.siemreap(
                        fontSize: 13,

                        color: TheColors.secondaryColor,
                      ),
                    ),
                    Icon(
                      isExpanded.value ? Icons.expand_less : Icons.expand_more,
                      color: TheColors.orange,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Animated content
          if (isExpanded.value) ...[
            const SizedBox(height: 8),
            content,
            const SizedBox(height: 8),
            Divider(
              color: TheColors.orange.withOpacity(0.3),
              thickness: 0.5,
              height: 1,
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  // Personal Information Content
  Widget _buildPersonalInfoContent() {
    return _buildInfoGrid([
      _InfoItem('ឈ្មោះ ខ្មែរ', widget.payrollData.nameKh ?? 'N/A'),
      _InfoItem('អង់គ្លេស', widget.payrollData.nameEn ?? 'N/A'),
      _InfoItem(
        'ភេទ',
        widget.payrollData.gender == 1
            ? 'ប្រុស'
            : widget.payrollData.gender == 2
            ? 'ស្រី'
            : 'N/A',
      ),
      _InfoItem('តួនាទី', widget.payrollData.roleName ?? 'N/A'),
    ]);
  }

  // Work Information Content
  Widget _buildWorkInfoContent() {
    return _buildInfoGrid([
      _InfoItem('សាខា', widget.payrollData.branchName ?? 'N/A'),
      _InfoItem('វ៉េនធ្វេីការ', widget.payrollData.shiftName ?? 'N/A'),
      _InfoItem(
        'ម៉ោង ធ្វេីការ',
        '${FormatUtils.formatTime(widget.payrollData.startTime)} - ${FormatUtils.formatTime(widget.payrollData.endTime)}',
      ),
      _InfoItem(
        'ចំនូន ថ្ងៃធ្វេីការ',
        widget.payrollData.workedDay?.toString() ?? '0',
      ),
    ]);
  }

  // Salary Information Content
Widget _buildSalaryContent() {
  final bonus = (widget.payrollData.isAttendanceBonus == 1) ? 10.0 : 0;

  return Column(
    children: [
      _buildAmountRow(
        'ប្រាក់ខែ',
        widget.payrollData.baseSalary?.toString() ?? '0',
        widget.payrollData.currencySymbol ?? '',
      ),
      _buildAmountRow(
        'ប្រាក់ជួលក្នុងមួយថ្ងៃ',
        widget.payrollData.dailyRate?.toString() ?? '0',
        widget.payrollData.currencySymbol ?? '',
      ),
      _buildAmountRow(
        'ប្រាក់លើកទឹកចិត្ត',
        bonus.toString(),
        widget.payrollData.currencySymbol ?? '',
      ),
      const SizedBox(height: 8),
      _buildAmountRow(
        'ប្រាក់ត្រូវបើកសរុប',
        widget.payrollData.netsalary?.toString() ?? '0',
        widget.payrollData.currencySymbol ?? '',
        isTotal: true,
      ),
    ],
  );
}


  // Deductions Content
  Widget _buildDeductionsContent() {
    final penaltyleavwithoudpermission = int.tryParse(widget.payrollData.penaltyLeaveWithoutPermission!) ?? 0;
    return Column(
      children: [
        if (widget.payrollData.totalLate != null &&
            widget.payrollData.totalLate! > 0)
          _buildDeductionRow(
            'ចំនូនមកយឺត',
            widget.payrollData.totalLate,
            widget.payrollData.latepenalty!,
          ),
        if (widget.payrollData.totalEarlyexit != null &&
            widget.payrollData.totalEarlyexit! > 0)
          _buildDeductionRow(
            'ចំនួនចេញមុនម៉ោង',
            widget.payrollData.totalEarlyexit,
            widget.payrollData.totalexitpenalty,
          ),
        if (widget.payrollData.leaveWithPermission != null &&
            widget.payrollData.leaveWithPermission! > 0)
          _buildDeductionRow(
            'ឈប់មានច្បាប់',
            widget.payrollData.leaveWithPermission,
            widget.payrollData.penaltyLeaveWithPermission,
          ),
        if (widget.payrollData.leaveWithoutPermission != null &&
            widget.payrollData.leaveWithoutPermission! > 0)
          _buildDeductionRow(
            'ឈប់អត់ច្បាប់',
            widget.payrollData.leaveWithoutPermission,
            penaltyleavwithoudpermission,
          ),
        if (widget.payrollData.leaveWeekend != null &&
            widget.payrollData.leaveWeekend! > 0)
          _buildDeductionRow(
            'ឈប់សុក្រ/សៅរ៍',
            widget.payrollData.leaveWeekend,
            widget.payrollData.penaltyLeaveWeekend,
          ),
        const SizedBox(height: 8),
        _buildAmountRow(
          'លុយត្រូវកាត់សរុប',
          widget.payrollData.totalDeductions.toString(),
          widget.payrollData.currencySymbol!,
          isDeduction: true,
        ),
      ],
    );
  }

  // Loan Information Content

  // Helper Methods (Keep from original)
  Widget _buildInfoGrid(List<_InfoItem> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final rowCount = (items.length / 2).ceil();
        return Column(
          children: List.generate(rowCount, (rowIndex) {
            final firstIndex = rowIndex * 2;
            final secondIndex = firstIndex + 1;
            final firstItem = items[firstIndex];
            final secondItem = secondIndex < items.length
                ? items[secondIndex]
                : null;

            return Row(
              children: [
                Expanded(
                  child: _buildInfoRow(firstItem.label, firstItem.value),
                ),
                if (secondItem != null)
                  Expanded(
                    child: _buildInfoRow(secondItem.label, secondItem.value),
                  )
                else
                  const Spacer(),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label:',
              style: GoogleFonts.siemreap(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: TheColors.secondaryColor,
              ),
            ),
            SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.siemreap(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: TheColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRow(
    String label,
    String amount,
    String symbol, {
    bool isTotal = false,
    bool isDeduction = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.siemreap(
              fontSize: 11,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDeduction
                  ? TheColors.errorColor
                  : TheColors.secondaryColor,
            ),
          ),
          Row(
            children: [
              Text(
                amount,
                style: GoogleFonts.siemreap(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isDeduction
                      ? TheColors.errorColor
                      : TheColors.successColor,
                ),
              ),
              SizedBox(width: 6),
              Text(
                symbol,
                style: GoogleFonts.siemreap(
                  fontSize: 11,
                  color: isDeduction
                      ? TheColors.errorColor
                      : TheColors.successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildDeductionRow(String label, int? count, int? penalty) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '$label ($count ដង)',
              style: GoogleFonts.siemreap(
                fontSize: 11,
                color: TheColors.errorColor,
              ),
            ),
          ),
          Text(
           penalty.toString(),
            style: const TextStyle(
              fontSize: 11,
              color: TheColors.errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getNetSalaryColor(double netSalary) {
    if (netSalary > 0) {
      return TheColors.successColor;
    } else if (netSalary <= 0) {
      return TheColors.errorColor;
    } else {
      return Colors.blueGrey;
    }
  }


}

class _InfoItem {
  final String label;
  final String value;

  _InfoItem(this.label, this.value);
}
