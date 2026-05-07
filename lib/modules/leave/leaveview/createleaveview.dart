import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/employeeshift/employeeshiftcontroller.dart';
import 'package:flutter_application_10/modules/leave/leavecontroller/leavecontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customdatepicker.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/employeeshiftcard.dart';
import 'package:flutter_application_10/shared/widgets/leavetypecard.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class CreateLeaveView extends StatelessWidget {
  final leaveController = Get.find<Leavecontroller>();
  final employeeShiftController = Get.put(Employeeshiftcontroller());
  final authController = Get.find<Authcontroller>();
  final leaveTypeController = Get.put(LeaveTypeController());
  final leavedaycontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final selectApproveById = Rxn<int>();
  final selectStartDate = Rxn<DateTime>();
  final selectEndDate = Rxn<DateTime>();

  CreateLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "សុំច្បាប់"),
      body: Obx(
        () => leaveController.isLoading.value
            ? const Center(child: CustomLoading())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                  border: Border.all(color: TheColors.orange, width: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4,right: 4,top: 10,bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle("ជ្រើសរើសម៉ោងធ្វេីការ"),
                                const SizedBox(height: 5),
                         SizedBox(
                          height: 75,
                           child: ListView.builder(
                             itemCount: employeeShiftController.employeeshift.length,
                             itemBuilder: (context, index) {
                               final shift = employeeShiftController.employeeshift[index];
                               return Obx(() {
                                 final isSelected =
                                                       employeeShiftController.selectedShiftId.value ==
                                                       shift.id;
                                 return Employeeshiftcard(
                                   employeeshiftmodel: shift,
                                   isSelected: isSelected,
                                   onTap: () =>
                                                         employeeShiftController.selectShift(shift.id!),
                                 );
                               });
                             },
                           ),
                         ),
                          ],
                          
                        ),
                      ),
                    ),
                

                
                    LeaveTypeCard(), // ✅ your custom card here

                    const SizedBox(height: 10),
                    Container(
                            decoration: BoxDecoration(
                  border: Border.all(color: TheColors.orange, width: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                      child: Padding(
                         padding: const EdgeInsets.only(left: 4,right: 4,top: 10,bottom: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle("អ្នកអនុម័ត"),
                              const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: CustomDropdown(
                        selectedValue: selectApproveById,
                        items: authController.users,
                        hintText: "ជ្រើសរើសអ្នកអនុម័ត",
                        onChanged: (value) => selectApproveById.value = value,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("ថ្ងៃចាប់ផ្តើម"),
                                CustomDatePickerField(
                                  label: "",
                                  selectedDate: selectStartDate,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLabel("ថ្ងៃបញ្ចប់"),
                                CustomDatePickerField(
                                  label: "",
                                  selectedDate: selectEndDate,
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
                    

                     const SizedBox(height: 10),
                     Container(
                              decoration: BoxDecoration(
                  border: Border.all(color: TheColors.orange, width: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                       child: Padding(
   padding: const EdgeInsets.only(left: 4,right: 4,top: 10,bottom: 12),
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             _buildSectionTitle("ចំនួនថ្ងៃឈប់សម្រាក"),
                                SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 6),
                      child: CustomTextField(
                        controller: leavedaycontroller, 
                        hintText: "ឧ 2", 
                        prefixIcon: Icons.lock_clock_outlined),
                    ),
                     const SizedBox(width: 10),
                     _buildSectionTitle("ពិពណ៍នា"),
                     SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: CustomTextField(
                        controller: descriptioncontroller, 
                        hintText: "ឧ មានការរល់", 
                        prefixIcon: Icons.description),
                    ),
                           ],
                         ),
                       ),
                     ),
                  

               
                  
                  ],
                ),
              ),
      ),
      bottomNavigationBar: CustomBottomNav(title: "បញ្ចួន",
      onTap: () async{
         final start = selectStartDate.value;
          final end = selectEndDate.value;
          final leave = int.tryParse(leavedaycontroller.text.trim());
          await leaveController.createleave(
            ispermission: leaveTypeController.isPermission.value,
            iswithoutpermission: leaveTypeController.isWithoutPermission.value,
            isweekend: leaveTypeController.isWeekend.value,
            employeeshiftid: employeeShiftController.selectedShiftId.value!, 
            startdate: start!.toIso8601String(), 
            enddate: end!.toIso8601String(), 
            leaveday: leave!, 
            approvebyid: selectApproveById.value!,
            description: descriptioncontroller.text
            );
            Navigator.pop(context);
        
      },
      
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Text(
        text,
        style: TextStyles.siemreap(
          Get.context!,
          fontSize: 14,
          fontweight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: TextStyles.siemreap(Get.context!, fontSize: 12),
      ),
    );
  }



}
