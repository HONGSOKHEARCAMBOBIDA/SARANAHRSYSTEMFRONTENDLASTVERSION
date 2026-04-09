import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_10/core/helper/gettoken.dart';
import 'package:flutter_application_10/data/models/loginmodel.dart';
import 'package:flutter_application_10/data/models/usermodel.dart';
import 'package:flutter_application_10/data/models/userregistermodel.dart';
import 'package:flutter_application_10/data/models/userupdatemodel.dart';
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';

class Authservice {
  final ApiProvider apiProvider = ApiProvider();
  Future<List<Data>> getuser({
    int? branchid,
    int? roleid,
    int? is_active,
    String? name,
  }) async {
    try {
      final params = <String, dynamic>{};
      if (branchid != null) params['branch_id'] = branchid;
      if (roleid != null) params['role_id'] = roleid;
      if (is_active != null) params['is_active'] = is_active;
      if (name != null && name.isNotEmpty) params['name'] = name;
      final response = await apiProvider.get(
        'viewuser1',
        queryParameters: params.isNotEmpty ? params : null,
      );
      if (response.statusCode == 200) {
        final json = response.data;
        final model = UserModel.fromJson(json);
        return model.data ?? [];
      } else {
        throw Exception("faild ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Fiald ${e.toString()}");
    }
  }

  Future<LoginModel> login({
    required String phone,
    required String password,
  }) async {
    try {
      final body = {'contact': phone, 'password': password};

      final response = await apiProvider.post("login", body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception('Login failed: ${response.data}');
      }
    } catch (e) {
      
      throw Exception(e.toString());
    }
  }

  // Future<bool> register(UserRegisterModel user) async {
  //   try {
  //     final token = getToken();
  //     if (token == null) {
  //       CustomSnackbar.error(
  //         title: "មិនអាចចូលបាន",
  //         message: "សូមធ្វើការ Login",
  //       );
  //       return false;
  //     }

  //     final response = await apiProvider.post('register', user.toJson());
  //     if (response.statusCode == 201) {
  //       return true;
  //     } else {
  //       CustomSnackbar.error(title: "បរាជ័យ", message: "រក្សាទុកមិនបានទេ");
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
  Future<bool> register({
  
    required String branchID,
    required String nameEn,
    required String nameKh,
    required String username,
    required String email,
    required String password,
    required int gender,
    required String contact,
    required String nationalIdNumber,
    required int roleId,
    required DateTime hireDate,
    required DateTime promoteDate,
    required int type,
    required int shiftID,
    required double baseSalary,
    required int workday,
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
    required int currencyID,
    required List<int> partIDs,
    File? profileImage,
    File? qrcodeimage,
  }) async {
    try {
      var formData = FormData.fromMap({
        'branch_id': branchID,
        'name_en': nameEn,
        'name_kh': nameKh,
        'gender': gender,
        'username': username,
        'email': email,
        'password': password,
        'shift_id': shiftID,
        'base_salary': baseSalary,
        'worked_day': workday,
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
        'note': notes,
        'currency_id':currencyID,
        'part_ids':partIDs,
        'position_level': positionLevel,
        if (profileImage != null)
          'profileimage': await MultipartFile.fromFile(
            profileImage.path,
            filename: profileImage.path.split('/').last,
          ),
        if (qrcodeimage != null)
          'qrcodeimage': await MultipartFile.fromFile(
            qrcodeimage.path,
            filename: qrcodeimage.path.split('/').last,
          ),
      });
      final response = await apiProvider.post('register', formData);
      if (response.statusCode == 201) {
        return true;
      } else {

       CustomSnackbar.error(
  title: "បញ្ហា",
  message: response.data.toString(),
);
        return false;
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
      return false;
    }
  }

  Future<bool> updateuser(int userId,Userupdatemodel user) async {
    try {
      final response = await apiProvider.put(
        'updateuser/$userId',
        user.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        CustomSnackbar.error(title: "បរាជ័យ", message: "កែប្រែមិនបានទេ");
        return false;
      }
    } catch (e) {
       throw Exception(e.toString());
    }
  }

  Future<bool> changestatus({required int id}) async {
    try {
      final response = await apiProvider.put('chnagestatususer/${id}', id);
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
}
