import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/constants.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart' as mymodel;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Employeedetailbuttonsheet extends StatefulWidget {
  final mymodel.Data employee;

  const Employeedetailbuttonsheet({Key? key, required this.employee})
      : super(key: key);

  @override
  State<Employeedetailbuttonsheet> createState() => _EmployeedetailbuttonsheetState();
}

class _EmployeedetailbuttonsheetState extends State<Employeedetailbuttonsheet> {
  @override
  Widget build(BuildContext context) {
    final theme = TheColors.bgColor;

    String formatDate(String? isoDate) {
      if (isoDate == null || isoDate.isEmpty) return 'N/A';
      try {
        final date = DateTime.parse(isoDate);
        return DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        return 'N/A';
      }
    }

    String getMaritalStatus(int? status) {
      if (status == null) return 'N/A';
      switch (status) {
        case 1: return 'នៅលីវ';
        case 2: return 'រៀបការ';
        case 3: return 'លែងលះ';
        case 4: return 'ស្វាមី/ភរិយាស្លាប់';
        default: return 'N/A';
      }
    }

    return DraggableScrollableSheet(
      
      expand: false,
      initialChildSize: 0.9,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: TheColors.bgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            _buildHeader(context),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildSection(
                    icon: Icons.person,
                    title: 'ព័ត៌មានផ្ទាល់ខ្លួន',
                    children: [
                      _buildDetailItem('ឈ្មោះ', widget.employee.name ?? 'N/A'),
                      _buildDetailItem('ឈ្មោះអង់គ្លេស', widget.employee.nameEn ?? 'N/A'),
                      _buildDetailItem('ភេទ', _getGender(widget.employee.gender)),
                      _buildDetailItem('ថ្ងៃកំណើត', formatDate(widget.employee.dateOfBirth)),
                      _buildDetailItem('លេខអត្តសញ្ញាណ', widget.employee.nationalIdNumber ?? 'N/A'),
                      _buildDetailItem('លេខទូរស័ព្ទ', widget.employee.contact ?? 'N/A'),
                      _buildDetailItem('ស្ថានភាពគ្រួសារ', getMaritalStatus(widget.employee.maritalStatus)),
                      _buildDetailItem('លេខទូរស័ព្ទគ្រួសារ', widget.employee.familyPhone ?? 'N/A'),
                    ],
                  ),
                  
                  _buildSection(
                    icon: Icons.work_outline,
                    title: 'ព័ត៌មានការងារ',
                    children: [
                      _buildDetailItem('តួនាទី', widget.employee.roleName ?? 'N/A'),
                      _buildDetailItem('សាខា', widget.employee.branchName ?? 'N/A'),
                      _buildDetailItem('ប្រភេទការងារ', widget.employee.type == 1 ? 'ពេញម៉ោង' : 'កាលកំណត់'),
                      _buildDetailItem('ថ្ងៃចូលបំពេញការងារ', formatDate(widget.employee.hireDate)),
                      _buildDetailItem('ថ្ងៃតម្លើងតួនាទី', formatDate(widget.employee.promoteDate)),
                      _buildDetailItem('តម្លើងតួនាទី', widget.employee.isPromote == true ? 'បានវាយតម្លៃ' : 'មិនទាន់វាយតម្លៃ'),
                      _buildDetailItem('កម្រិតតួនាទី', widget.employee.positionLevel == 1 ? "បុគ្គលិកធម្មតា" : "បុគ្គលិកជំនាញ"),
                      _buildDetailItem('វេន', widget.employee.shiftName ?? 'N/A'),
                      _buildDetailItem('ម៉ោងធ្វើការ', '${widget.employee.startTime ?? ''} - ${widget.employee.endTime ?? ''}'),

                    ],
                  ),

                  _buildSection(
                    icon: Icons.attach_money,
                    title: 'ព័ត៌មានផ្នែកហិរញ្ញវត្ថុ',
                    children: [
                      _buildDetailItem('រូបិយប័ណ្ណប្រេី', widget.employee.currencyName!),
                      _buildDetailItem('ប្រាក់ខែគោល', widget.employee.baseSalary != null ? '${widget.employee.baseSalary} ${widget.employee.currencyName}' : 'N/A'),
                      _buildDetailItem('អត្រាប្រាក់ឈ្នួលប្រចាំថ្ងៃ', widget.employee.dailyRate != null ? '${widget.employee.dailyRate} ${widget.employee.currencyName}' : 'N/A'),
                      _buildDetailItem('ថ្ងៃធ្វើការ', widget.employee.workedDay!= null ? '${widget.employee.workedDay} ថ្ងៃ': 'N/A'),
                      _buildDetailItem('ធនាគារ', widget.employee.bankName ?? 'N/A'),
                      _buildDetailItem('លេខគណនីធនាគារ', widget.employee.bankAccountNumber ?? 'N/A'),
                           Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      "QR Code",
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    ),
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: TheColors.warningColor,width: 0.3),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8), // keep corners slightly rounded (optional)
          child: Image.network(
            widget.employee.qrCodeBankAccount != null && widget.employee.qrCodeBankAccount!.isNotEmpty
                ? "${Appconstants.baseUrl}/qrcodeimage/${widget.employee.qrCodeBankAccount}"
                : "https://cdn-icons-png.flaticon.com/512/17634/17634775.png",
            width: 100, // adjust size
            height: 100,
            fit: BoxFit.cover,
            
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.broken_image, size: 100);
            },
          ),
        ),
      ),
    ),
  ],
)

                    ],
                  ),

                  _buildSection(
                    icon: Icons.school_outlined,
                    title: 'ព័ត៌មានអប់រំ និងបទពិសោធន៍',
                    children: [
                      _buildDetailItem('កម្រិតវប្បធម៌', widget.employee.educationLevel ?? 'N/A'),
                      _buildDetailItem('ឆ្នាំបទពិសោធន៍', widget.employee.experienceYears?.toString() ?? 'N/A'),
                      _buildDetailItem('ក្រុមហ៊ុនពីមុន', widget.employee.previousCompany ?? 'N/A'),
                    ],
                  ),

                  _buildSection(
                    icon: Icons.location_on_outlined,
                    title: 'ទីកន្លែងកំណើត',
                    children: [
                      _buildDetailItem('ខេត្ត', widget.employee.provinceNameOfBirth ?? 'N/A'),
                      _buildDetailItem('ស្រុក', widget.employee.districtNameOfBirth ?? 'N/A'),
                      _buildDetailItem('ឃុំ', widget.employee.communceNameOfBirth ?? 'N/A'),
                      _buildDetailItem('ភូមិ', widget.employee.villageNameOfBirth ?? 'N/A'),
                    ],
                  ),

                  _buildSection(
                    icon: Icons.home_outlined,
                    title: 'ទីកន្លែងបច្ចុប្បន្ន',
                    children: [
                      _buildDetailItem('ខេត្ត', widget.employee.provinceNameCurrentAddress ?? 'N/A'),
                      _buildDetailItem('ស្រុក', widget.employee.districtNameCurrentAddress ?? 'N/A'),
                      _buildDetailItem('ឃុំ', widget.employee.communceNameCurrentAddress ?? 'N/A'),
                      _buildDetailItem('ភូមិ', widget.employee.villageNameCurrentAddress ?? 'N/A'),
                    ],
                  ),

                  _buildSection(
                    icon: Icons.note_outlined,
                    title: 'ព័ត៌មានបន្ថែម',
                    children: [
                      _buildDetailItem('កំណត់សម្គាល់', widget.employee.notes ?? 'N/A'),
                      _buildDetailItem('ស្ថានភាព', widget.employee.isActive == true ? 'សកម្ម' : 'អសកម្ម'),
                      _buildDetailItem('លេខសម្គាល់', widget.employee.id?.toString() ?? 'N/A'),
                      _buildDetailItem('លេខសម្គាល់វេន', widget.employee.employeeShitfId?.toString() ?? 'N/A'),
                      _buildDetailItem('លេខសម្គាល់ប្រាក់ខែ', widget.employee.salaryId?.toString() ?? 'N/A'),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HEADER =====================
  Widget _buildHeader(BuildContext context) {
    return Column(
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
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: TheColors.bgColor,
              backgroundImage: widget.employee.profileImage != null && widget.employee.profileImage!.isNotEmpty
                  ? NetworkImage("${Appconstants.baseUrl}/profileimage/${widget.employee.profileImage}")
                  : const NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/17634/17634775.png',
                    ) as ImageProvider,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.employee.name ?? 'N/A',
          style: GoogleFonts.siemreap(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TheColors.secondaryColor,
          ),
        ),
        if (widget.employee.roleName != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.employee.roleName!,
            style: GoogleFonts.siemreap(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: widget.employee.isActive == true
                ? TheColors.successColor.withOpacity(0.2)
                : TheColors.errorColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.employee.isActive == true ? 'សកម្ម' : 'អសកម្ម',
            style: GoogleFonts.siemreap(
              color: widget.employee.isActive == true
                  ? TheColors.successColor
                  : TheColors.errorColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // ==================== SECTION WRAPPER =====================
  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        TheColors.orange.withOpacity(0.1),
        TheColors.orange.withOpacity(0.1),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
 
    borderRadius: BorderRadius.circular(25),
  ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: TheColors.orange, size: 18),
              const SizedBox(width: 6),
              Text(
                title,
                style: GoogleFonts.siemreap(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: TheColors.secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
           Divider(height: 8,color: TheColors.orange),
          ...children,
        ],
      ),
    );
  }

  // ==================== DETAIL ROW =====================
  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label: ',
              style: GoogleFonts.siemreap(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.siemreap(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== HELPERS =====================
  String _getGender(int? gender) {
    if (gender == null) return 'N/A';
    return gender == 1 ? 'ប្រុស' : 'ស្រី';
  }
}