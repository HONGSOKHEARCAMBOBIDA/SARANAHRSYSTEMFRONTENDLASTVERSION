class EmployeeModel {
  List<Data>? data;

  EmployeeModel({this.data});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? branchId;
  int? branchshiftId;
  String? branchName;
  String? nameEn;
  String? name;
  int? gender;
  String? dateOfBirth;
  int? villageIdOfBirth;
  String? villageNameOfBirth;
  int? communceIdOfBirth;
  String? communceNameOfBirth;
  int? districtIdOfBirth;
  String? districtNameOfBirth;
  int? provinceIdOfBirth;
  String? provinceNameOfBirth;
  int? maritalStatus;
  String? profileImage;
  int? villageIdCurrentAddress;
  String? villageNameCurrentAddress;
  int? communceIdCurrentAddress;
  String? communceNameCurrentAddress;
  int? districtIdCurrentAddress;
  String? districtNameCurrentAddress;
  int? provinceIdCurrentAddress;
  String? provinceNameCurrentAddress;
  String? familyPhone;
  String? educationLevel;
  String? experienceYears;
  String? previousCompany;
  String? bankName;
  String? bankAccountNumber;
  String? qrCodeBankAccount;
  String? notes;
  String? contact;
  String? nationalIdNumber;
  int? roleId;
  String? roleName;
  int? positionLevel;
  String? hireDate;
  String? promoteDate;
  bool? isPromote;
  int? type;
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  int? employeeShitfId;
  int? salaryId;
  String? baseSalary;
  int? workedDay;
  String? dailyRate;
  bool? isActive;
  int? assignBranchId;
  int? currencyId;
  String? currencyCode;
  String? currencySymbol;
  String? currencyName;

  Data(
      {this.id,
      this.branchId,
      this.branchshiftId,
      this.branchName,
      this.nameEn,
      this.name,
      this.gender,
      this.dateOfBirth,
      this.villageIdOfBirth,
      this.villageNameOfBirth,
      this.communceIdOfBirth,
      this.communceNameOfBirth,
      this.districtIdOfBirth,
      this.districtNameOfBirth,
      this.provinceIdOfBirth,
      this.provinceNameOfBirth,
      this.maritalStatus,
      this.profileImage,
      this.villageIdCurrentAddress,
      this.villageNameCurrentAddress,
      this.communceIdCurrentAddress,
      this.communceNameCurrentAddress,
      this.districtIdCurrentAddress,
      this.districtNameCurrentAddress,
      this.provinceIdCurrentAddress,
      this.provinceNameCurrentAddress,
      this.familyPhone,
      this.educationLevel,
      this.experienceYears,
      this.previousCompany,
      this.bankName,
      this.bankAccountNumber,
      this.qrCodeBankAccount,
      this.notes,
      this.contact,
      this.nationalIdNumber,
      this.roleId,
      this.roleName,
      this.positionLevel,
      this.hireDate,
      this.promoteDate,
      this.isPromote,
      this.type,
      this.shiftId,
      this.shiftName,
      this.startTime,
      this.endTime,
      this.employeeShitfId,
      this.salaryId,
      this.baseSalary,
      this.workedDay,
      this.dailyRate,
      this.isActive,
      this.assignBranchId,
      this.currencyId,
      this.currencyCode,
      this.currencySymbol,
      this.currencyName});


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branch_id'];
    branchshiftId = json['branch_shift_id'];
    branchName = json['branch_name'];
    nameEn = json['name_en'];
    name = json['name_kh'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    villageIdOfBirth = json['village_id_of_birth'];
    villageNameOfBirth = json['village_name_of_birth'];
    communceIdOfBirth = json['communce_id_of_birth'];
    communceNameOfBirth = json['communce_name_of_birth'];
    districtIdOfBirth = json['district_id_of_birth'];
    districtNameOfBirth = json['district_name_of_birth'];
    provinceIdOfBirth = json['province_id_of_birth'];
    provinceNameOfBirth = json['province_name_of_birth'];
    maritalStatus = json['marital_status'];
    profileImage = json['profile_image'];
    villageIdCurrentAddress = json['village_id_current_address'];
    villageNameCurrentAddress = json['village_name_current_address'];
    communceIdCurrentAddress = json['communce_id_current_address'];
    communceNameCurrentAddress = json['communce_name_current_address'];
    districtIdCurrentAddress = json['district_id_current_address'];
    districtNameCurrentAddress = json['district_name_current_address'];
    provinceIdCurrentAddress = json['province_id_current_address'];
    provinceNameCurrentAddress = json['province_name_current_address'];
    familyPhone = json['family_phone'];
    educationLevel = json['education_level'];
    experienceYears = json['experience_years'];
    previousCompany = json['previous_company'];
    bankName = json['bank_name'];
    bankAccountNumber = json['bank_account_number'];
    qrCodeBankAccount = json['qr_code_bank_account'];
    notes = json['notes'];
    contact = json['contact'];
    nationalIdNumber = json['national_id_number'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    positionLevel = json['position_level'];
    hireDate = json['hire_date'];
    promoteDate = json['promote_date'];
    isPromote = json['is_promote'];
    type = json['type'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    employeeShitfId = json['employee_shitf_id'];
    salaryId = json['salary_id'];
    baseSalary = json['base_salary'];
    workedDay = json['worked_day'];
    dailyRate = json['daily_rate'];
    isActive = json['is_active'];
    assignBranchId = json['assign_branch_id'];
    currencyId = json['currency_id'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyName = json['currency_name'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_id'] = this.branchId;
    data['branch_shift_id']= this.branchshiftId;
    data['branch_name'] = this.branchName;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.name;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['village_id_of_birth'] = this.villageIdOfBirth;
    data['village_name_of_birth'] = this.villageNameOfBirth;
    data['communce_id_of_birth'] = this.communceIdOfBirth;
    data['communce_name_of_birth'] = this.communceNameOfBirth;
    data['district_id_of_birth'] = this.districtIdOfBirth;
    data['district_name_of_birth'] = this.districtNameOfBirth;
    data['province_id_of_birth'] = this.provinceIdOfBirth;
    data['province_name_of_birth'] = this.provinceNameOfBirth;
    data['marital_status'] = this.maritalStatus;
    data['profile_image'] = this.profileImage;
    data['village_id_current_address'] = this.villageIdCurrentAddress;
    data['village_name_current_address'] = this.villageNameCurrentAddress;
    data['communce_id_current_address'] = this.communceIdCurrentAddress;
    data['communce_name_current_address'] = this.communceNameCurrentAddress;
    data['district_id_current_address'] = this.districtIdCurrentAddress;
    data['district_name_current_address'] = this.districtNameCurrentAddress;
    data['province_id_current_address'] = this.provinceIdCurrentAddress;
    data['province_name_current_address'] = this.provinceNameCurrentAddress;
    data['family_phone'] = this.familyPhone;
    data['education_level'] = this.educationLevel;
    data['experience_years'] = this.experienceYears;
    data['previous_company'] = this.previousCompany;
    data['bank_name'] = this.bankName;
    data['bank_account_number'] = this.bankAccountNumber;
    data['qr_code_bank_account'] = this.qrCodeBankAccount;
    data['notes'] = this.notes;
    data['contact'] = this.contact;
    data['national_id_number'] = this.nationalIdNumber;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['position_level'] = this.positionLevel;
    data['hire_date'] = this.hireDate;
    data['promote_date'] = this.promoteDate;
    data['is_promote'] = this.isPromote;
    data['type'] = this.type;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['employee_shitf_id'] = this.employeeShitfId;
    data['salary_id'] = this.salaryId;
    data['base_salary'] = this.baseSalary;
    data['worked_day'] = this.workedDay;
    data['daily_rate'] = this.dailyRate;
    data['is_active'] = this.isActive;
    data['assign_branch_id'] = this.assignBranchId;
    data['currency_id'] = this.currencyId;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_name'] = this.currencyName;
    return data;
  }
}
