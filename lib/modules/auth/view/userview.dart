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
            SliverFillRemaining(
              child: Obx(() {
                if (authcontroller.isLoading.value) {
                  return const CustomLoading();
                }
          
                if (authcontroller.users.isEmpty) {
                  // Always return a scrollable widget, even when empty
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Center(
                            child: Text(
                              'អត់ទាន់មានអ្នកប្រេីប្រាស់',
                              style: TextStyles.siemreap(context, fontSize: 12),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
          
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: authcontroller.users.length,
                  itemBuilder: (context, index) {
                    final user = authcontroller.users[index];
                    return Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8,),
                            child: CustomUserCard(
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
                              onTap: () => {
                                _handleViewUser(user),
                                 
                              }
                            ),
                          ),
                        
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
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