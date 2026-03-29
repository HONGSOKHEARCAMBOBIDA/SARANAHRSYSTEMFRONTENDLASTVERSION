import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/attendance/controller/attendancecontroller.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/employeeshiftcard.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';

class c extends StatefulWidget {
  const c({super.key});

  @override
  State<c> createState() => _cState();
}

class _cState extends State<c> {
  final Attendancecontroller attendancecontroller = Get.put(
    Attendancecontroller(),
  );
  final maincontrolle = Get.put(MainController());

  Future<void> handleCheckIn() async {
    final selectedId = attendancecontroller.selectedShiftId.value;
    if (selectedId == null) {
      CustomSnackbar.error(title: "កំហុស", message: "សូមជ្រើសរើសវេនការងារមុន!");
      return;
    }

    // Get location first
    await attendancecontroller.getCurrentLocation();

    // Make sure location was fetched
    if (attendancecontroller.latitude.value == 0.0 &&
        attendancecontroller.longitude.value == 0.0) {
      CustomSnackbar.error(title: "កំហុស", message: "ចាប់ទីតាំងមិនបាន");
      return;
    }

    await attendancecontroller.checkin(employeeshiftid: selectedId);
  }

  Future<void> handleCheckOut() async {
    final selectedId = attendancecontroller.selectedShiftId.value;
    if (selectedId == null) {
      CustomSnackbar.error(title: "កំហុស", message: "សូមជ្រើសរើសវេនការងារមុន!");
      return;
    }

    // Get location first
    await attendancecontroller.getCurrentLocation();

    // Make sure location was fetched
    if (attendancecontroller.latitude.value == 0.0 &&
        attendancecontroller.longitude.value == 0.0) {
      CustomSnackbar.error(title: "កំហុស", message: "ចាប់ទីតាំងមិនបាន");
      return;
    }

    await attendancecontroller.checkout(employee_shiftid: selectedId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      drawer: Drawer(
        backgroundColor: TheColors.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 82,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: TheColors.errorColor, // same as your app theme
                ),
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: TheColors.yellow),
              title: Text(
                'របាយការណ៍វត្តមាន',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/viewattendance'); // Navigate to Register page
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: TheColors.yellow,
              ),
              title: Text(
                'បុគ្គលិកខ្ចីលុយ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/loan'); // Navigate to Register page
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.leave_bags_at_home,
                color: TheColors.yellow,
              ),
              title: Text(
                'សុំច្បាប់',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/leave'); // Navigate to Register page
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.monetization_on_sharp,
                color: TheColors.yellow,
              ),
              title: Text(
                'របាយការណ៍បេីកប្រាក់ខែ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/payrollview'); // Navigate to Register page
              },
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                color: TheColors.orange.withOpacity(0.3),
                thickness: 0.5,
                height: 1,
              ),
            ),

            ListTile(
              leading: const Icon(Icons.logout, color: TheColors.red),
              title: Text(
                'ចាកចេញ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                maincontrolle.logout();
              },
            ),
          ],
        ),
      ),
      appBar: CustomAppBar(title: "បង្កើតវត្តមាន"),
      body: Obx(() {
        if (attendancecontroller.isLoading.value) {
          return const Center(child: CustomLoading());
        }

        if (attendancecontroller.employeeshift.isEmpty) {
          return const Center(child: Text("មិនមានវេនការងារទេ"));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 14, bottom: 8),
                child: Text(
                  "សូមជ្រេីសរេីសម៉ោងធ្វេីការ",
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 14,
                    fontweight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: attendancecontroller.employeeshift.length,
                  itemBuilder: (context, index) {
                    final shift = attendancecontroller.employeeshift[index];
                    return Obx(() {
                      final isSelected =
                          attendancecontroller.selectedShiftId.value ==
                          shift.id;
                      return Employeeshiftcard(
                        employeeshiftmodel: shift,
                        isSelected: isSelected,
                        onTap: () =>
                            attendancecontroller.selectShift(shift.id!),
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomElevatedButton(
                      text: "ចូលធ្វេីការ",
                      onPressed: handleCheckIn,
                    ),
                    const SizedBox(height: 15),
                    CustomElevatedButton(
                      text: "ចេញធ្វេីការ",
                      onPressed: handleCheckOut,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
