import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/data/models/employeeupdatemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Employeeservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getemployee({
    int? branchid,
    int? roleid,
    int? isActive,
    String? name,
    int? shiftid,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchid != null) params['branch_id'] = branchid;
      if (roleid != null) params['role_id'] = roleid;
      if (isActive != null) params['is_active'] = isActive;
      if (name != null && name.isNotEmpty) params['name'] = name;
      if (shiftid != null) params['shift_id'] = shiftid;
      final response = await apiProvider.get(
        'viewemployee',
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final model = EmployeeModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  // Future<bool> updateemployee(Employeeupdatemodel employee) async {
  //   try {
  //     final response = await apiProvider.put(
  //       'editemployee/${employee.ID}',
  //       employee.toJson(),
  //     );
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
  //       return false;
  //     }
  //   } catch (e) {
  //     CustomSnackbar.error(
  //       title: "កំហុស",
  //       message: "មានបញ្ហា: ${e.toString()}",
  //     );
  //     return false;
  //   }
  // }
  Future<bool> updateemployee({
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
    required int villageIdcurrentaddress,
    required String familyPhone,
    required String educationLevel,
    required int experienceYears,
    required String previousCompany,
    required String bankName,
    required String bankAccountNumber,
    required String notes,
    required int positionLevel,
    File? profileImage,
    File? qrcodeimage,
  }) async {
    try {
      var formData = FormData.fromMap({
        'branch_id': branchID,
        'name_en': nameEn,
        'name_kh': nameKh,
        'gender': gender,
        'contact': contact,
        'national_id_number': nationalIdNumber,
        'role_id': roleId,
        'hire_date': hireDate,
        'promote_date': promoteDate,
        'type': type,
        'date_of_birth': dateOfBirth,
        'village_id_of_birth': villageIdofbirth,
        'marital_status': materialstatus,
        'village_id_current_address': villageIdcurrentaddress,
        'family_phone': familyPhone,
        'education_level': educationLevel,
        'experience_years': experienceYears,
        'previous_company': previousCompany,
        'bank_name': bankName,
        'bank_account_number': bankAccountNumber,
        'notes': notes,
        'position_level': positionLevel,
        if (profileImage != null)
          'profile_image': await MultipartFile.fromFile(
            profileImage.path,
            filename: profileImage.path.split('/').last,
          ),
        if (qrcodeimage != null)
          'qr_code_bank_account': await MultipartFile.fromFile(
            qrcodeimage.path,
            filename: qrcodeimage.path.split('/').last,
          ),
      });
      final response = await apiProvider.put(
        'editemployee/$employeeID',
        formData,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        CustomSnackbar.error(
  title: "បញ្ហា",
  message: response.data.toString(),
);
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
  title: "Error",
  message: e.toString(),
);
      return false;
    }
  }

  Future<bool> changestatusemployee(int? id) async {
    try {
      final response = await apiProvider.put('changestatusemployee/${id}', id);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "កំហុស",
        message: "មានបញ្ហា: ${e.toString()}",
      );
      return false;
    }
  }
  Future<bool> promoteemployee(int? id) async {
    try {
      final response = await apiProvider.put('promoteemployee/${id}', id);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "កំហុស",
        message: "មានបញ្ហា: ${e.toString()}",
      );
      return false;
    }
  }
  Future<bool> changeshift({
    int? EmployeeID,
    int? ShiftID,
    int? AssignBranchID,
    int? employeeshiftid,
  }) async {
    try {
      final body = {
        'employee_id': EmployeeID,
        'shift_id': ShiftID,
        'assign_branch_id': AssignBranchID,
      };

      final response = await apiProvider.put(
        'editemployeeshift/$employeeshiftid',
        body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> editsalary({
    required int baseSalary,
    required int workday,
    required int salaryID,
    required int currencyID,
  }) async {
    try {
      final body = {'base_salary': baseSalary, 'worked_day': workday,'currency_id':currencyID};
      final response = await apiProvider.put("editsalary/${salaryID}", body);
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> creteEmployeeShift({
    required int employeeid,
    required int shiftid,
    required int baseSalary,
    required int workday,
    required int salaryid,
    required int employeeshiftid,
    required int currencyID
  }) async {
    try {
      final body = {
        'employee_id': employeeid,
        'shift_id': shiftid,
        'base_salary': baseSalary,
        'worked_day': workday,
        'currency_id':currencyID
      };
      final response = await apiProvider.post(
        "employee-shift/${employeeshiftid}/salary/${salaryid}",
        body,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
      return false;
    }
  }
}
