import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/rolemodel.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/role/roleview/createroleview.dart';
import 'package:flutter_application_10/modules/role/roleview/roleassignpermissionview.dart';
import 'package:flutter_application_10/modules/role/roleview/rolepermissionfordelete.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customrolecard.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Roleview extends StatefulWidget {
  Roleview({super.key});

  @override
  State<Roleview> createState() => _RoleviewState();
}

class _RoleviewState extends State<Roleview> {
  final roleController = Get.find<Rolecontroller>();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "តួនាទី"),
      body: RefreshIndicator(
        color: TheColors.errorColor,
        backgroundColor: TheColors.bgColor,
        onRefresh: () async {
          await roleController.fetchrole();
          roleController.changedPermissionIds.clear();
          roleController.deletepermissionIDs.clear();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (roleController.isLoading.value) {
                    return const CustomLoading();
                  }

                  if (roleController.role.isEmpty) {
                    return Center(
                      child: Text(
                        "អត់មានទិន្ន័យ",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: roleController.role.length,
                    itemBuilder: (context, index) {
                      final role = roleController.role[index];
                      return Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 2),
                              child: CustomRoleCard(
                                displayname: role.displayName ?? "អត់មាន",
                                isActive: role.isActive,
                                name: role.name ?? "អត់មាន",
                                onEdit: () {
                                  showupdaterolebotthomsheet(role);
                                },
                                onDelete: () {
                                  roleController.Changestatusrole(role.id);
                                },
                                onTap: () {
                                  Get.to(
                                    () => Roleassignpermissionview(),
                                    binding: Rolebinding(),
                                    arguments: role.id,
                                    transition: Transition.rightToLeft,
                                  );
                                },
                                deletepermission: () {
                                  Get.to(
                                    () => Rolepermissionfordelete(),
                                    binding: Rolebinding(),
                                    transition: Transition.rightToLeft,
                                    arguments: role.id,
                                  );
                                },
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
      ),
      floatingActionButton: CustomFloatingActionButton(
        backgroundColor: TheColors.errorColor,
        heroTag: "gotocreaterole",
        onPressed: () {
          // Navigate to create department page
          Get.to(
            () => Createroleview(),
            transition: Transition.rightToLeftWithFade,
            binding: Rolebinding(),
          );
        },
      ),
    );
  }

  void showupdaterolebotthomsheet(Data rolemodel) {
    final namecontroller = TextEditingController(text: rolemodel.name);
    final displaynamecontroller = TextEditingController(
      text: rolemodel.displayName,
    );

    Get.bottomSheet(
      SingleChildScrollView(
        child: SizedBox(
          height: Get.height * 0.45, // ✅ Fixed height
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: TheColors.bgColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(14),
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
                          Center(
                            child: Container(
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              "កែប្រែតួនាទី",
                              style: TextStyles.siemreap(
                                context,
                                fontSize: 18,
                                fontweight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "ឈ្មោះបង្ហាញ",
                            style: TextStyles.siemreap(
                              fontSize: 12,
                              color: TheColors.gray,
                              context,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: displaynamecontroller,
                            hintText: 'ពិពណ៌នាឈ្មោះតួនាទី (ឧទាហរណ៍: បេឡា)',
                            prefixIcon: Icons.description,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'សូមបំពេញការពិពណ៌នា';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          // Name field
                          Text(
                            "ឈ្មោះ",
                            style: TextStyles.siemreap(
                              fontSize: 12,
                              color: TheColors.gray,
                              context,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: namecontroller,
                            hintText: 'ឈ្មោះតួនាទី (ឧទាហរណ៍: Teller)',
                            prefixIcon: Icons.business,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'សូមបំពេញឈ្មោះតួនាទី';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    // Description field
                    SizedBox(height: 10,),
                  

                    // Update button
                    CustomElevatedButton(
                      text: "កែប្រែ",
                      onPressed: () async {
                        final role = Data(
                          id: rolemodel.id,
                          name: namecontroller.text.trim(),
                          displayName: displaynamecontroller.text.trim(),
                        );

                        if (formkey.currentState!.validate()) {
                          await roleController.updaterole(role);
                          
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      isScrollControlled:
          true, // ✅ Makes sure the sheet uses full height if needed
    );
  }
}
