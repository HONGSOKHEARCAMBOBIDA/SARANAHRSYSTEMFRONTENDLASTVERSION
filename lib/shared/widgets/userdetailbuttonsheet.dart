import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/data/models/usermodel.dart' as mymodel;
import 'package:google_fonts/google_fonts.dart';

class UserDetailBottomSheet extends StatelessWidget {
  final mymodel.Data user;

  const UserDetailBottomSheet({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            // Modern drag handle
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            _buildHeader(context),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildModernInfoCard(
                    icon: Icons.person_outline_rounded,
                    title: 'ព័ត៌មានផ្ទាល់ខ្លួន',
                    children: [
                      _buildModernDetailRow('ឈ្មោះ', user.name ?? 'N/A'),
                      _buildModernDetailRow('ឈ្មោះអង់គ្លេស', user.nameEn ?? 'N/A'),
                      _buildModernDetailRow('ភេទ', _getGender(user.gender)),
                      _buildModernDetailRow('លេខអត្តសញ្ញាណ', user.nationalIdNumber ?? 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildModernInfoCard(
                    icon: Icons.business_outlined,
                    title: 'ព័ត៌មានការងារ',
                    children: [
                      _buildModernDetailRow('តួនាទី', user.roleName ?? 'N/A'),
                      _buildModernDetailRow('សាខា', user.branchName ?? 'N/A'),
                      _buildModernDetailRow(
                        'ស្ថានភាព',
                        user.isActive == true ? 'សកម្ម' : 'អសកម្ម',
                        status: true,
                        isActive: user.isActive ?? false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildModernInfoCard(
                    icon: Icons.contact_phone_outlined,
                    title: 'ទំនាក់ទំនង',
                    children: [
                      _buildModernDetailRow('អ៊ីម៉ែល', user.email ?? 'N/A'),
                      _buildModernDetailRow('ទូរស័ព្ទ', user.contact ?? 'N/A'),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Modern avatar with gradient background and shadow
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                TheColors.orange.withOpacity(0.2),
                TheColors.warningColor.withOpacity(0.3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: TheColors.orange.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 55,
              backgroundImage: const AssetImage('assets/user/information.png'),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          user.name ?? 'N/A',
          style: GoogleFonts.siemreap(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A2C3E),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: TheColors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            user.roleName ?? 'N/A',
            style: GoogleFonts.siemreap(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: TheColors.orange,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildModernInfoCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            TheColors.orange.withOpacity(0.15),
                            TheColors.warningColor.withOpacity(0.25),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: TheColors.orange, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: GoogleFonts.siemreap(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A2C3E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernDetailRow(String label, String value, {bool status = false, bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: GoogleFonts.siemreap(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            child: status
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive 
                          ? Colors.green.withOpacity(0.1) 
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      value,
                      style: GoogleFonts.siemreap(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isActive ? Colors.green[700] : Colors.red[700],
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: GoogleFonts.siemreap(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2C3E50),
                      height: 1.4,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  String _getGender(int? gender) {
    if (gender == null) return 'N/A';
    return gender == 1 ? 'ប្រុស' : 'ស្រី';
  }
}