import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/shftmodel.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/floating_buttom.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/shiftcard.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Shiftview extends StatefulWidget {
  const Shiftview({super.key});

  @override
  State<Shiftview> createState() => _ShiftviewState();
}

class _ShiftviewState extends State<Shiftview> {
  final shiftcontroller = Get.find<Shiftcontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  var selectedbranchname = "រេីសសាខា".obs;
  // Rxn<int> allows null and reactive change tracking
  final selectbranchid = Rxn<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "វេនធ្វើការ"),
      body: RefreshIndicator(
        onRefresh: () async {
          await shiftcontroller.fetchshift(selectbranchid.value);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // ✅ Branch selector dropdown
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Obx(
                  () => CustomOutlinedButton(
                    text: selectedbranchname.value.isEmpty
                        ? "រេីសសាខា"
                        : selectedbranchname.value,
                    onPressed: () {
                      showBranchSelectorSheet(
                        context: context,
                        branch: branchcontroller.branch,
                        selectedBranchId: selectbranchid.value,
                        onSelected: (id) {
                          selectbranchid.value = id;
                          selectedbranchname.value = branchcontroller.branch
                              .firstWhere((p) => p.id == id)
                              .name!;
                          shiftcontroller.shift.clear();
                          shiftcontroller.fetchshift(selectbranchid.value);
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ✅ Shifts list or loading state
              Expanded(
                child: Obx(() {
                  if (shiftcontroller.isLoading.value) {
                    return const Center(child: CustomLoading());
                  }

                  if (shiftcontroller.shift.isEmpty) {
                    return Center(
                      child: Text(
                        selectbranchid.value == null
                            ? "សូមជ្រើសសាខា"
                            : "សាខានេះមិនទាន់មានវេនទេ",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                    );
                  }

                  // ✅ Display list of shifts
                  return ListView.builder(
                    itemCount: shiftcontroller.shift.length,
                    itemBuilder: (context, index) {
                      final shift = shiftcontroller.shift[index];
                      return Center(
                        child: Column(
                          children: [
                            Shiftcard(
                              isActive: shift.isActive,
                              startTime: shift.startTime ?? "",
                              endTime: shift.endTime ?? "",
                              name: shift.name ?? "មិនទាន់មានឈ្មោះ",
                              onEdit: () {
                                showEditShiftBottomSheet(shift);
                              },
                              onToggleStatus: () {
                                shiftcontroller.changestatusshift(
                                  shiftID: shift.id ?? 0,
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 75),
                              child: Divider(
                                color: TheColors.gray,
                                thickness: 0.3,
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
        onPressed: () {
          showCreateShiftBottomSheet();
        },
      ),
    );
  }

  void showCreateShiftBottomSheet() {
    final nameController = TextEditingController();
    final selectedStartTime = Rxn<TimeOfDay>();
    final selectedEndTime = Rxn<TimeOfDay>();

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          height: Get.height * 0.6,
         
          decoration: const BoxDecoration(
            color: TheColors.bgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 14),
            child: Column(
              children: [
                Container(
                   margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.only(left: 14,right: 14,top: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: TheColors.orange, width: 0.4),
                
                              borderRadius: BorderRadius.circular(12),
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
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "បង្កើតវេនថ្មី",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 18,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ឈ្មោះវេន",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                  
                      CustomTextField(
                        controller: nameController,
                        hintText: "ឧទាហរណ៍: វេនព្រឹក",
                        prefixIcon: Icons.access_time,
                      ),
                      const SizedBox(height: 15),
                  
                      // Start time picker
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              final start = selectedStartTime.value;
                              return Text(
                                start != null
                                    ? "ម៉ោងចូល: ${start.format(context)}"
                                    : "ជ្រើសម៉ោងចូល",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 12,
                                  color: TheColors.gray,
                                ),
                              );
                            }),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.schedule,
                              color: TheColors.secondaryColor,
                            ),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                selectedStartTime.value = picked;
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                  
                      // End time picker
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              final end = selectedEndTime.value;
                              return Text(
                                end != null
                                    ? "ម៉ោងចេញ: ${end.format(context)}"
                                    : "ជ្រើសម៉ោងចេញ",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 12,
                                  color: TheColors.gray,
                                ),
                              );
                            }),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.schedule_outlined,
                              color: TheColors.secondaryColor,
                            ),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null) {
                                selectedEndTime.value = picked;
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                  
                      // Save button
            
                    ],
                  ),
                ),
                                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TheColors.errorColor,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (selectbranchid.value == null) {
                            Get.snackbar("កំហុស", "សូមជ្រើសសាខាមុន");
                            return;
                          }
                  
                          if (nameController.text.isEmpty) {
                            Get.snackbar("កំហុស", "សូមបញ្ចូលឈ្មោះវេន");
                            return;
                          }
                  
                          if (selectedStartTime.value == null ||
                              selectedEndTime.value == null) {
                            Get.snackbar("កំហុស", "សូមជ្រើសម៉ោងចូលនិងចេញ");
                            return;
                          }
                  
                          // Convert time to 24-hour format string (e.g. "13:00")
                          String formatTime(TimeOfDay time) {
                            final hour = time.hour.toString().padLeft(2, '0');
                            final minute = time.minute.toString().padLeft(2, '0');
                            return "$hour:$minute";
                          }
                  
                          await shiftcontroller.createshift(
                            name: nameController.text.trim(),
                            start_time: formatTime(selectedStartTime.value!),
                            end_time: formatTime(selectedEndTime.value!),
                            branchid: selectbranchid.value!,
                          );
                            Navigator.pop(context);
                        },
                        child: Obx(() {
                          return shiftcontroller.isLoading.value
                              ? const SizedBox(
  width: 20,
  height: 20,
  child: CircularProgressIndicator(
    color: Colors.white,
    strokeWidth: 2,
  ),
)
                              : Text(
                                  "រក្សាទុក",
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                );
                        }),
                      ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showEditShiftBottomSheet(Data shift) {
    final nameController = TextEditingController(text: shift.name);
    final selectedStartTime = Rxn<TimeOfDay>();
    final selectedEndTime = Rxn<TimeOfDay>();

    // Parse existing times if available
if (shift.startTime != null && shift.startTime!.isNotEmpty) {
  final parts = shift.startTime!.trim().split(':');
  if (parts.length >= 2) {  // ✅ >= 2 handles both "HH:mm" and "HH:mm:ss"
    selectedStartTime.value = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }
}

if (shift.endTime != null && shift.endTime!.isNotEmpty) {
  final parts = shift.endTime!.trim().split(':');
  if (parts.length >= 2) {  // ✅ >= 2 handles both "HH:mm" and "HH:mm:ss"
    selectedEndTime.value = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 0,
      minute: int.tryParse(parts[1]) ?? 0,
    );
  }
}

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          height: Get.height * 0.6,
          
          decoration: const BoxDecoration(
            color: TheColors.bgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 14),
            child: Column(
              children: [
                Container(
                       margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.only(left: 14,right: 14,top: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: TheColors.orange, width: 0.4),
                
                              borderRadius: BorderRadius.circular(12),
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
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          "កែប្រែវេន",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 18,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "ឈ្មោះវេន",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                  
                      CustomTextField(
                        controller: nameController,
                        hintText: "ឧទាហរណ៍: វេនព្រឹក",
                        prefixIcon: Icons.access_time,
                      ),
                      const SizedBox(height: 15),
                  
                      // Start time picker
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              final start = selectedStartTime.value;
                              return Text(
                                start != null
                                    ? "ម៉ោងចូល: ${start.format(context)}"
                                    : "ជ្រើសម៉ោងចូល",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 12,
                                  color: TheColors.gray,
                                ),
                              );
                            }),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.schedule,
                              color: TheColors.secondaryColor,
                            ),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: selectedStartTime.value ?? TimeOfDay.now(),
                              );
                              if (picked != null) {
                                selectedStartTime.value = picked;
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                  
                      // End time picker
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              final end = selectedEndTime.value;
                              return Text(
                                end != null
                                    ? "ម៉ោងចេញ: ${end.format(context)}"
                                    : "ជ្រើសម៉ោងចេញ",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 12,
                                  color: TheColors.gray,
                                ),
                              );
                            }),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.schedule_outlined,
                              color: TheColors.secondaryColor,
                            ),
                            onPressed: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime: selectedEndTime.value ?? TimeOfDay.now(),
                              );
                              if (picked != null) {
                                selectedEndTime.value = picked;
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                  
                      // Update button
            
                    ],
                  ),
                ),
                                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TheColors.errorColor,
                          minimumSize: const Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          if (selectbranchid.value == null) {
                            Get.snackbar("កំហុស", "សូមជ្រើសសាខាមុន");
                            return;
                          }
                  
                          if (nameController.text.isEmpty) {
                            Get.snackbar("កំហុស", "សូមបញ្ចូលឈ្មោះវេន");
                            return;
                          }
                  
                          if (selectedStartTime.value == null ||
                              selectedEndTime.value == null) {
                            Get.snackbar("កំហុស", "សូមជ្រើសម៉ោងចូលនិងចេញ");
                            return;
                          }
                  
                          // Convert time to 24-hour format string (e.g. "13:00")
                          String formatTime(TimeOfDay time) {
                            final hour = time.hour.toString().padLeft(2, '0');
                            final minute = time.minute.toString().padLeft(2, '0');
                            return "$hour:$minute";
                          }
                  
                          await shiftcontroller.updateshift(
                            shiftID: shift.id ?? 0,
                            name: nameController.text.trim(),
                            start_time: formatTime(selectedStartTime.value!),
                            end_time: formatTime(selectedEndTime.value!),
                            branchid: selectbranchid.value!,
                          );
                          Navigator.pop(context);
                        },
                        child: Obx(() {
                          return shiftcontroller.isLoading.value
                              ? const SizedBox(
  width: 20,
  height: 20,
  child: CircularProgressIndicator(
    color: Colors.white,
    strokeWidth: 2,
  ),
)
                              : Text(
                                  "ធ្វើបច្ចុប្បន្នភាព",
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                );
                        }),
                      ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
