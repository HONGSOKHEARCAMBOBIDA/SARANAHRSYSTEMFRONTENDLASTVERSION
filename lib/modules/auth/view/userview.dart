import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_isactive_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_role_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/usermodel.dart' as mymodel;
import 'package:flutter_application_10/modules/auth/binding/updateuserbinding.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/auth/view/updateuserview.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:flutter_application_10/shared/widgets/usercard.dart';
import 'package:flutter_application_10/shared/widgets/userdetailbuttonsheet.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Userview extends StatefulWidget {
  Userview({super.key});

  @override
  State<Userview> createState() => _UserviewState();
}

class _UserviewState extends State<Userview> {
  final authcontroller = Get.find<Authcontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final TextEditingController searchController = TextEditingController();
  final selectroleid = Rxn<int>();
  final selectbranchid = Rxn<int>();
  final selectisactive = Rxn<bool>();
  final currentstate = Rxn<int>();
  final ScrollController _scrollController = ScrollController();
  
  void _handleViewUser(mymodel.Data user) {
    Get.bottomSheet(
      UserDetailBottomSheet(user: user),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }
  void _showChangePasswordSheet(int userId) {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final RxBool obscureNew = true.obs;
  final RxBool obscureConfirm = true.obs;

  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ដូរពាក្យសម្ងាត់',
            style: GoogleFonts.siemreap(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => TextField(
            controller: newPassController,
            obscureText: obscureNew.value,
            decoration: InputDecoration(
              labelText: 'ពាក្យសម្ងាត់ថ្មី',
              labelStyle: GoogleFonts.siemreap(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: IconButton(
                icon: Icon(obscureNew.value ? Icons.visibility_off : Icons.visibility),
                onPressed: () => obscureNew.value = !obscureNew.value,
              ),
            ),
          )),
          const SizedBox(height: 12),
          Obx(() => TextField(
            controller: confirmPassController,
            obscureText: obscureConfirm.value,
            decoration: InputDecoration(
              labelText: 'បញ្ជាក់ពាក្យសម្ងាត់',
              labelStyle: GoogleFonts.siemreap(),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: IconButton(
                icon: Icon(obscureConfirm.value ? Icons.visibility_off : Icons.visibility),
                onPressed: () => obscureConfirm.value = !obscureConfirm.value,
              ),
            ),
          )),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TheColors.errorColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (newPassController.text.isEmpty || confirmPassController.text.isEmpty) {
                  CustomSnackbar.error(title: "បញ្ហា", message: "សូមបំពេញទាំងអស់");
                  return;
                }
                if (newPassController.text != confirmPassController.text) {
                  CustomSnackbar.error(title: "បញ្ហា", message: "ពាក្យសម្ងាត់មិនដូចគ្នា");
                  return;
                }
               
                authcontroller.changePassword(
                  userId: userId,
                  newPassword: newPassController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: Text(
                'រក្សាទុក',
                style: GoogleFonts.siemreap(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

  Widget _buildlabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 10)),
          const SizedBox(width: 4),
          const Icon(
            color: TheColors.errorColor,
            Icons.arrow_drop_down,
            size: 18,
          ),
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    searchController.clear();
    authcontroller.searchQuery.value = '';
    selectbranchid.value = null;
    selectroleid.value = null;
    currentstate.value = null;
    await authcontroller.fetchUser();
    await rolecontroller.fetchrole();
    await branchcontroller.fetchbranch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "អ្នកប្រេីប្រាស់"),
      backgroundColor: TheColors.bgColor,
      body: RefreshIndicator(
        backgroundColor: TheColors.bgColor,
        color: TheColors.errorColor,
        onRefresh: _refreshData,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: 60,
                        child: CustomTextField(
                          controller: searchController,
                          hintText: "ស្វែងរក".tr,
                          prefixIcon: Icons.search,
                          onChanged: (value) =>
                              authcontroller.searchQuery.value = value,
                        ),
                      ),
                    ),
                   // SizedBox(height: 10),
                Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        _buildModernFilterButton(
          label: "សាខា",
          icon: Icons.store_outlined,
          onPressed: () {
            showBranchSelectorSheet(
              context: context,
              branch: branchcontroller.branch,
              selectedBranchId: selectbranchid.value,
              onSelected: (id) {
                setState(() {
                  selectbranchid.value = id;
                  authcontroller.fetchUser(
                    branchID: selectbranchid.value,
                  );
                });
              },
            );
          },
        ),
        _buildDivider(),
        _buildModernFilterButton(
          label: "តួនាទី",
          icon: Icons.people_outline,
          onPressed: () {
            showRoleSelectorsheet(
              context: context,
              role: rolecontroller.role,
              selectedSelectId: selectroleid.value,
              onSelected: (id) {
                setState(() {
                  selectroleid.value = id;
                  authcontroller.fetchUser(
                    roleId: selectroleid.value,
                  );
                });
              },
            );
          },
        ),
        _buildDivider(),
        _buildModernFilterButton(
          label: "ស្ថានភាព",
          icon: Icons.toggle_on_outlined,
          onPressed: () {
            showIsActiveSelectorSheet(
              context: context,
              selectedValue: currentstate.value,
              onSelected: (value) {
                setState(() {
                  currentstate.value = value;
                  authcontroller.fetchUser(
                    is_active: currentstate.value!,
                  );
                });
              },
            );
          },
        ),
      ],
    ),
  ),
),
                  ],
                ),
              ),
            ),
            Obx(() {
              if(authcontroller.isLoading.value){
                return SliverFillRemaining(
                    child: Center(
                      child: const CustomLoading(),
                    ),
                  );
              }
                           if (authcontroller.users.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'អត់ទាន់មានទិន្ន័យ',
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                    ),
                  );
                }
            
                      
              return SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      final user = authcontroller.users[index];
      return Center(
        child: CustomUserCard(
  phone: user.contact!,
  namekh: user.name ?? "អត់មាន",
  role: user.roleName ?? "អត់មាន".tr,
  branch: user.branchName!,
  nameenglish: user.nameEn ?? "",
  isActive: user.isActive,
  onEdit: () {
    Get.to(
      () => Updateuserview(userModel: user),
      transition: Transition.rightToLeft,
      binding: UpdateUserBindings(),
    );
  },
  onDelete: () {
    authcontroller.changestatususer(user.id!);
  },
  onTap: () {
    _handleViewUser(user);
  },
  onChangePassword: () => _showChangePasswordSheet(user.id!), // 👈 add this
),
      );
    },
    childCount: authcontroller.users.length,
  ),
);
            }),
          ],
        ),
      ),
    );
  }
}
Widget _buildModernFilterButton({
  required String label,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: TheColors.errorColor.withOpacity(0.7),
              ),
              SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.siemreap(

                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: TheColors.errorColor,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                size: 18,
                color: TheColors.errorColor.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildDivider() {
  return Container(
    width: 1,
    height: 30,
    color: Colors.grey.withOpacity(0.2),
  );
}
