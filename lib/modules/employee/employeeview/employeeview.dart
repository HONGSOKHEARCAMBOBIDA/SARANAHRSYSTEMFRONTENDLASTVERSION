import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_isactive_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_role_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_shitf_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart' as myModel;
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/employee/employeebinding/updateemployeebinding.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/employee/employeeview/updateemployeeview.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/salary/view/editsalaryview.dart';
import 'package:flutter_application_10/modules/salary/view/increasesalaryview.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/employeecard.dart';
import 'package:flutter_application_10/shared/widgets/employeedetailbuttonsheet.dart';
import 'package:flutter_application_10/shared/widgets/employeeshifteditview.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Employeeview extends StatefulWidget {
  Employeeview({super.key});

  @override
  State<Employeeview> createState() => _EmployeeviewState();
}

class _EmployeeviewState extends State<Employeeview> {
  final employeecontroller = Get.find<Employeecontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final shiftcontroller = Get.find<Shiftcontroller>();
  final TextEditingController searchController = TextEditingController();
  final selectroleid = Rxn<int>();
  final selectshiftid = Rxn<int>();
  final selectbranchid = Rxn<int>();
  final selectisactive = Rxn<bool>();
  final currentstate = Rxn<int>();
  final ScrollController _scrollController = ScrollController();
  
  // Refresh function
  Future<void> _refreshData() async {
    searchController.clear();
    employeecontroller.searchQuery.value = '';
    selectbranchid.value = null;
    selectroleid.value = null;
    currentstate.value = null;
    selectshiftid.value = null;
    shiftcontroller.shift.clear();
    
    // Fetch all data in parallel
    await Future.wait([
      employeecontroller.fetchemployee(),
      rolecontroller.fetchrole(),
      branchcontroller.fetchbranch(),
    ]);
  }

  void _handleViewEmployee(myModel.Data employee) {
    Get.bottomSheet(
      Employeedetailbuttonsheet(employee: employee),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "បុគ្គលិក"),
        backgroundColor: TheColors.bgColor,
        body: RefreshIndicator(
          backgroundColor: TheColors.bgColor,
          color: TheColors.errorColor,
          onRefresh: _refreshData,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Header section with search and filters
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: SizedBox(
                                height: 55,
                                child: CustomTextField(
                                  controller: searchController,
                                  hintText: "ស្វែងរក".tr,
                                  prefixIcon: Icons.search,
                                  onChanged: (value) =>
                                      employeecontroller.searchQuery.value = value,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      minimumSize: Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      side: BorderSide(
                                        color: TheColors.errorColor,
                                        width: 0.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      showBranchSelectorSheet(
                                        context: context,
                                        branch: branchcontroller.branch,
                                        selectedBranchId: selectbranchid.value,
                                        onSelected: (id) {
                                          setState(() {
                                            selectbranchid.value = id;
                                            employeecontroller.fetchemployee(
                                              branchid: selectbranchid.value,
                                            );
                                            shiftcontroller.fetchshift(
                                              selectbranchid.value,
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: _buildlabel("សាខា"),
                                  ),
                                  SizedBox(width: 3),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      minimumSize: Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      side: BorderSide(
                                        color: TheColors.errorColor,
                                        width: 0.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      showRoleSelectorsheet(
                                        context: context,
                                        role: rolecontroller.role,
                                        selectedSelectId: selectroleid.value,
                                        onSelected: (id) {
                                          setState(() {
                                            selectroleid.value = id;
                                            employeecontroller.fetchemployee(
                                              roleid: selectroleid.value,
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: _buildlabel("តួនាទី"),
                                  ),
                                  SizedBox(width: 3),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      minimumSize: Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      side: BorderSide(
                                        color: TheColors.errorColor,
                                        width: 0.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      showIsActiveSelectorSheet(
                                        context: context,
                                        selectedValue: currentstate.value,
                                        onSelected: (value) {
                                          setState(() {
                                            currentstate.value = value;
                                            employeecontroller.fetchemployee(
                                              isActive: currentstate.value!,
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: _buildlabel("ស្ថានភាព"),
                                  ),
                                  SizedBox(width: 3),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 3,
                                      ),
                                      minimumSize: Size(0, 0),
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      side: BorderSide(
                                        color: TheColors.errorColor,
                                        width: 0.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      showshiftbuttonsheet(
                                        context: context,
                                        shift: shiftcontroller.shift,
                                        selectedShiftId: selectshiftid.value,
                                        onSelected: (id) {
                                          setState(() {
                                            selectshiftid.value = id;
                                            employeecontroller.fetchemployee(
                                              shiftid: selectshiftid.value,
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: _buildlabel("វេនការងារ"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Employee list section
              Obx(() {
                if (employeecontroller.isLoading.value) {
                  return SliverFillRemaining(
                    child: Center(
                      child: const CustomLoading(),
                    ),
                  );
                }

                if (employeecontroller.employees.isEmpty) {
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
                      final employee = employeecontroller.employees[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 13,
                            right: 13,
                          
                           
                          ),
                          child: CustomEmployeeCard(
                            
                            currencycode: employee.currencyCode!,
                            currencysymbol: employee.currencySymbol!,
                            currencyname: employee.currencyName!,
                            profileImage: employee.profileImage!,
                            basesalary: employee.baseSalary!,
                            start_time: employee.startTime!,
                            end_time: employee.endTime!,
                            shiftname: employee.shiftName,
                            namekh: employee.name ?? "អត់មាន",
                            role: employee.roleName ?? "អត់មាន".tr,
                            nameenglish: employee.nameEn ?? "",
                            branchname: employee.branchName,
                            isActive: employee.isActive,
                            isPromote: employee.isPromote,
                            onEdit: () {
                              Get.to(
                                () => Updateemployeeview(
                                  employeemodel: employee,
                                ),
                                transition: Transition.rightToLeft,
                                binding: Updateemployeebinding(),
                              );
                            },
                            onDelete: () {
                              employeecontroller.changestatusemployee(employee.id);
                            },
                            onPromote: () {
                              employeecontroller.promoteemployee(employee.id);
                            },
                            onTap: () => _handleViewEmployee(employee),
                            onchangeshift: () {
                              Get.bottomSheet(
                             
                                Employeeshifteditview(
                                  employeemodel: employee,
                                  employeeId: employee.id!,
                                  employeeShiftId: employee.employeeShitfId,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                              );
                            },
                            chnagesalary: () {
                              Get.bottomSheet(
                               isScrollControlled: true,
                                EditSalaryView(
                                  employeemodel: employee,
                                  salaryID: employee.salaryId!,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                              );
                            },
                            increasesalry: () {
                              Get.bottomSheet(
                                isScrollControlled: true,
                                Increasesalaryview(
                                  employeemodel: employee,
                                  employeeId: employee.id!,
                                  employeeShiftId: employee.employeeShitfId,
                                  salaryID: employee.salaryId,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    childCount: employeecontroller.employees.length,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}