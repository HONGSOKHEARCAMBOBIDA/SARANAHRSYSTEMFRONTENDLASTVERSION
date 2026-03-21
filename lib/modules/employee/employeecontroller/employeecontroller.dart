import 'dart:io';

import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/data/models/employeeupdatemodel.dart';
import 'package:flutter_application_10/modules/employee/employeeservice/employeeservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Employeecontroller extends GetxController {
  final Employeeservice employeeservice = Employeeservice();
  var employees = <Data>[].obs;
  final imagepicker = ImagePicker();
  File? profileImage;
  File? qrcodeimage;
  final RxString searchQuery = ''.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // Fetch all users first
    fetchemployee();

    // Debounce search
    debounce(
      searchQuery, // Rx value to watch
      (_) => fetchemployee(name: searchQuery.value), // Action to run
      time: const Duration(milliseconds: 200), // Wait 500ms after last input
    );

    super.onInit();
  }

  Future<File?> pickProfile() async {
    final XFile? pickedFile = await imagepicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
      return profileImage; // Return the selected image
    } else {
      CustomSnackbar.error(
        title: "error".tr,
        message: "something_went_wrong".tr,
      );
      return null; // Return null if no image was picked
    }
  }

  Future<File?> pickqrImage() async {
    final XFile? pickedFile = await imagepicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      qrcodeimage = File(pickedFile.path);
      update();
      return qrcodeimage; // Return the selected image
    } else {
      CustomSnackbar.error(
        title: "error".tr,
        message: "something_went_wrong".tr,
      );
      return null; // Return null if no image was picked
    }
  }

  Future<void> fetchemployee({
    int? branchid,
    int? roleid,
    int? isActive,
    String? name,
    int? shiftid,
  }) async {
    try {
      isLoading.value = true;
      final result = await employeeservice.getemployee(
        branchid: branchid,
        roleid: roleid,
        isActive: isActive,
        name: name,
        shiftid: shiftid,
      );
      employees.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> updateemployee(Employeeupdatemodel employee) async {
  //   try {
  //     isLoading.value = true;
  //     bool isupdated = await employeeservice.updateemployee(employee);
  //     if (isupdated == true) {
  //       await fetchemployee();
  //     }
  //   } catch (e) {
  //     CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> updateemployee({
    required int employeeID,
    required String branchID,
    required String nameEn,
    required String nameKh,
    required int gender,
    required String contact,
    required String nationalIdNumber,
    required int roleId,
    required DateTime hireDate,
    required DateTime promoteDate,
    required int type,
    required DateTime dateOfBirth,
    required int villageIdofbirth,
    required int materialstatus,
    required int villageIdcurrentaddress,//
    required String familyPhone,//
    required String educationLevel,//
    required int experienceYears,//
    required String previousCompany,
    required String bankName,
    required String bankAccountNumber,
    required String notes,
    required int positionLevel,
  }) async {
    try {
      isLoading.value = true;
      final isupdated = await employeeservice.updateemployee(
        employeeID: employeeID,
        branchID: branchID,
        nameEn: nameEn,
        nameKh: nameKh,
        gender: gender,
        contact: contact,
        nationalIdNumber: nationalIdNumber,
        roleId: roleId,
        hireDate: hireDate,
        promoteDate: promoteDate,
        type: type,
        dateOfBirth: dateOfBirth,
        villageIdofbirth: villageIdofbirth,
        materialstatus: materialstatus,
        villageIdcurrentaddress: villageIdcurrentaddress,
        familyPhone: familyPhone,
        educationLevel: educationLevel,
        experienceYears: experienceYears,
        previousCompany: previousCompany,
        bankName: bankName,
        bankAccountNumber: bankAccountNumber,
        notes: notes,
        positionLevel: positionLevel,
        profileImage: profileImage,
        qrcodeimage: qrcodeimage,
      );
      if (isupdated) {
       
        await fetchemployee();
       
      }
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រី".tr, message: "កែប្រែបរាជ័យ".tr);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusemployee(int? id) async {
    try {
      isLoading.value = true;
      bool update = await employeeservice.changestatusemployee(id);
      if (update == true) {
        await fetchemployee();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
    Future<void> promoteemployee(int? id) async {
    try {
      isLoading.value = true;
      bool update = await employeeservice.promoteemployee(id);
      if (update == true) {
        await fetchemployee();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeshift({
    required int employeeID,
    required int shiftID,
    int? assignBranchID,
    int? employeeshiftid,
  }) async {
    try {
      isLoading.value = true;

      bool update = await employeeservice.changeshift(
        EmployeeID: employeeID,
        ShiftID: shiftID,
        AssignBranchID: assignBranchID,
        employeeshiftid: employeeshiftid,
      );

      if (update) {
        // ✅ Refresh employee list
        await fetchemployee();
        Get.back();

        // ✅ Close bottom sheet after a short delay

        // 👈 Close the bottom sheet
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editsalary({
    required int basesalary,
    required int workday,
    required int salaryID,
    required int currencyID,
  }) async {
    try {
      isLoading.value = true;
      bool update = await employeeservice.editsalary(
        currencyID: currencyID,
        baseSalary: basesalary,
        workday: workday,
        salaryID: salaryID,
      );
      if (update) {
        await fetchemployee();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createemployeeshift({
    required int employeeid,
    required int shiftid,
    required int baseSalary,
    required int workday,
    required int salaryid,
    required int employeeshiftid,
    required int currencyID
  }) async {
    try {
      isLoading.value = true;
      bool created = await employeeservice.creteEmployeeShift(
        currencyID: currencyID,
        employeeid: employeeid,
        shiftid: shiftid,
        baseSalary: baseSalary,
        workday: workday,
        salaryid: salaryid,
        employeeshiftid: employeeshiftid,
      );
      if (created) {
        await fetchemployee();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
