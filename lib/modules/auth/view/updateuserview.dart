import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/userupdatemodel.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/part/controller/partcontroller.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/shared/partcard.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class Updateuserview extends StatefulWidget {
  final dynamic userModel; // Use your actual user model type


  const Updateuserview({super.key, required this.userModel});

  @override
  State<Updateuserview> createState() => _UpdateuserviewState();
}

class _UpdateuserviewState extends State<Updateuserview> {
  final authcontroller = Get.find<Authcontroller>();

  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final partcontroller = Get.find<Partcontroller>();

  final _formkey = GlobalKey<FormState>();
  final selectbranchid = Rxn<int>();

  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();

  final contactcontroller = TextEditingController();

  final selectroleid = Rxn<int>();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _loadInitialData();
  }

  void _initializeData() {
    // Initialize controllers with existing data

    usernamecontroller.text = widget.userModel.username ?? "";
    emailcontroller.text = widget.userModel.email ?? "";
    contactcontroller.text = widget.userModel.contact ?? "";

    selectbranchid.value = widget.userModel.branchId;

    selectroleid.value = widget.userModel.roleId;
    authcontroller.selectedPartIds.clear();
  
  // Check if parts exist and add them

    if (widget.userModel.parts != null) {
    for (var part in widget.userModel.parts!) {
      if (part.partId != null) {
        authcontroller.selectedPartIds.add(part.partId!);
      }
    }
  }

  }

  void _loadInitialData() {
    branchcontroller.fetchbranch();
    rolecontroller.fetchrole();
    partcontroller.fetchpart();
  }

  Future<void> _updateUser() async {
    if (_formkey.currentState!.validate()) {
      if (selectbranchid.value == null || selectroleid.value == null) {
        CustomSnackbar.error(
          title: "បញ្ចូលមិនពេញលេញ",
          message: "សូមបញ្ចូលព័ត៌មានឲ្យបានពេញលេញ!",
        );
        return;
      }

      final user = Userupdatemodel(
        ID: widget.userModel.id, // Make sure to include the user ID
        branchID: selectbranchid.value!,

        username: usernamecontroller.text.trim(),
        email: emailcontroller.text.trim(),

        contact: contactcontroller.text.trim(),

        roleId: selectroleid.value!,
        partIds: authcontroller.selectedPartIds.toList(), 
      );

      try {
      //  print(user.toJson());
        await authcontroller.updateuser(user.ID,user);
        Get.back(); // Navigate back after successful update
      } catch (e) {
        CustomSnackbar.error(
          title: "កំហុស",
          message: "មិនអាចកែប្រែព័ត៌មានបាន: $e",
        );
      }
    }
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 12)),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildHeader(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.siemreap(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: TheColors.black,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    emailcontroller.dispose();
    contactcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "កែប្រែព័ត៌មានអ្នកប្រើប្រាស់"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                     
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            _buildLabel("លេខទូរសព្ទ"),
                            CustomTextField(
                              keyboardType: TextInputType.phone,
                              controller: contactcontroller,
                              hintText: "070366214",
                              prefixIcon: Icons.phone_callback,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("សាខា"),
                            CustomDropdown(
                              selectedValue: selectbranchid,
                              items: branchcontroller.branch,
                              hintText: "រេីសសាខា",
                              onChanged: (Value) {
                                selectbranchid.value = Value;
                              },
                            ),
                            SizedBox(height: 8),
                            _buildLabel("តួនាទី"),
                            CustomDropdown(
                              selectedValue: selectroleid,
                              items: rolecontroller.role,
                              hintText: "រេីសតួនាទី",
                              onChanged: (Value) {
                                selectroleid.value = Value;
                              },
                            ),
                            SizedBox(height: 8,),
                            Obx(() {
  if (partcontroller.isLoading.value) {
    return CustomLoading();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel("ផ្នែកដែលអាចមេីលបាន"),
  SingleChildScrollView(
    child: SizedBox(
    height: 165,
    child: GetBuilder<Authcontroller>(
      builder: (authController) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 3 / 1.2,
          ),
          itemCount: partcontroller.parts.length,
          itemBuilder: (context, index) {
            final part = partcontroller.parts[index];
            final isSelected = authController.selectedPartIds.contains(part.id);
            return Partcard(
              part: part,
              isSelected: isSelected,
              onTap: () => authController.selectPart(part.id!),
            );
          },
        );
      },
    ),
    ),
  ),
    ],
  );
}),
                          ],
                        ),
                        SizedBox(height: 5),
                    
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("ឈ្មោះសម្រាប់ចូលប្រព័ន្ធ"),
                            CustomTextField(
                              controller: usernamecontroller,
                              hintText: "hongsokhear",
                              prefixIcon: Icons.person,
                            ),
                            SizedBox(height: 8),
                            _buildLabel("អ៊ីម៉ែល"),
                            CustomTextField(
                              controller: emailcontroller,
                              hintText: "hongsokhear@gmail.com",
                              prefixIcon: Icons.email,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(title: "កែប្រែ", onTap: _updateUser),
    );
  }
}
