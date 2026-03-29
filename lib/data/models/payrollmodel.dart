class PayrollModel {
  List<Data>? data;

  PayrollModel({this.data});

  PayrollModel.fromJson(Map<String, dynamic> json) {
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
  int? salaryId;
  int? employeeShiftId;
  String? employee_profile;
  String? qrcode;
  String? baseSalary;
  int? workedDay;
  String? dailyRate;
  int? employeeId;
  String? nameEn;
  String? nameKh;
  int? gender;
  int? roleId;
  String? roleName;
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  int? payrollYear;
  int? payrollmonth;
  String? grosssalary;
  int? totalLate;
  int? latepenalty;
  int? totalEarlyexit;
  int? totalexitpenalty;
  int? leaveWithPermission;
  int? penaltyLeaveWithPermission;
  int? leaveWithoutPermission;
  String? penaltyLeaveWithoutPermission;
  int? leaveWeekend;
  int? penaltyLeaveWeekend;
  String? loanDeduction;
  int? isAttendanceBonus;
  String? bonusType;
  int? bonusAmount;
  String? totalDeductions;
  String? netsalary;
  int? status;
  int? branchId;
  String? branchName;
  int? currencyId;
  String? currencyCode;
  String? currencySymbol;
  String? currencyName;
  int? baseCurrencyId;
  String? baseCurrencyCode;
  String? baseCurrencySymbol;
  String? exchangeRate;

  Data(
      {this.id,
      this.salaryId,
      this.employeeShiftId,
      this.employee_profile,
      this.qrcode,
      this.baseSalary,
      this.workedDay,
      this.dailyRate,
      this.employeeId,
      this.nameEn,
      this.nameKh,
      this.gender,
      this.roleId,
      this.roleName,
      this.shiftId,
      this.shiftName,
      this.startTime,
      this.endTime,
      this.payrollYear,
      this.payrollmonth,
      this.grosssalary,
      this.totalLate,
      this.latepenalty,
      this.totalEarlyexit,
      this.totalexitpenalty,
      this.leaveWithPermission,
      this.penaltyLeaveWithPermission,
      this.leaveWithoutPermission,
      this.penaltyLeaveWithoutPermission,
      this.leaveWeekend,
      this.penaltyLeaveWeekend,
      this.loanDeduction,
      this.isAttendanceBonus,
      this.bonusType,
      this.bonusAmount,
      this.totalDeductions,
      this.netsalary,
      this.status,
      this.branchId,
      this.branchName,
      this.currencyId,
      this.currencyCode,
      this.currencySymbol,
      this.currencyName,
      this.baseCurrencyId,
      this.baseCurrencyCode,
      this.baseCurrencySymbol,
      this.exchangeRate});


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salaryId = json['salary_id'];
    employeeShiftId = json['employee_shift_id'];
    employee_profile = json['profile_image'];
    qrcode = json['qr_code_bank_account'];
    baseSalary = json['base_salary'];
    workedDay = json['worked_day'];
    dailyRate = json['daily_rate'];
    employeeId = json['employee_id'];
    nameEn = json['name_en'];
    nameKh = json['name_kh'];
    gender = json['gender'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    payrollYear = json['payroll_year'];
    payrollmonth = json['payrollmonth'];
    grosssalary = json['grosssalary'];
    totalLate = json['total_late'];
    latepenalty = json['latepenalty'];
    totalEarlyexit = json['total_earlyexit'];
    totalexitpenalty = json['totalexitpenalty'];
    leaveWithPermission = json['leave_with_permission'];
    penaltyLeaveWithPermission = json['penalty_leave_with_permission'];
    leaveWithoutPermission = json['leave_without_permission'];
    penaltyLeaveWithoutPermission = json['penalty_leave_without_permission'];
    leaveWeekend = json['leave_weekend'];
    penaltyLeaveWeekend = json['penalty_leave_weekend'];
    loanDeduction = json['loanDeduction'];
    isAttendanceBonus = json['is_attendance_bonus'];
    bonusType = json['bonus_type'];
    bonusAmount = json['bonus_amount'];
    totalDeductions = json['totalDeductions'];
    netsalary = json['netsalary'];
    status = json['status'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    currencyId = json['currency_id'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyName = json['currency_name'];
    baseCurrencyId = json['base_currency_id'];
    baseCurrencyCode = json['base_currency_code'];
    baseCurrencySymbol = json['base_currency_symbol'];
    exchangeRate = json['exchange_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salary_id'] = this.salaryId;
    data['employee_shift_id'] = this.employeeShiftId;
    data['base_salary'] = this.baseSalary;
    data['worked_day'] = this.workedDay;
    data['daily_rate'] = this.dailyRate;
    data['employee_id'] = this.employeeId;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.nameKh;
    data['gender'] = this.gender;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['payroll_year'] = this.payrollYear;
    data['payrollmonth'] = this.payrollmonth;
    data['grosssalary'] = this.grosssalary;
    data['total_late'] = this.totalLate;
    data['latepenalty'] = this.latepenalty;
    data['total_earlyexit'] = this.totalEarlyexit;
    data['totalexitpenalty'] = this.totalexitpenalty;
    data['leave_with_permission'] = this.leaveWithPermission;
    data['penalty_leave_with_permission'] = this.penaltyLeaveWithPermission;
    data['leave_without_permission'] = this.leaveWithoutPermission;
    data['penalty_leave_without_permission'] =
        this.penaltyLeaveWithoutPermission;
    data['leave_weekend'] = this.leaveWeekend;
    data['penalty_leave_weekend'] = this.penaltyLeaveWeekend;
    data['loanDeduction'] = this.loanDeduction;
    data['is_attendance_bonus'] = this.isAttendanceBonus;
    data['bonus_type'] = this.bonusType;
    data['bonus_amount'] = this.bonusAmount;
    data['totalDeductions'] = this.totalDeductions;
    data['netsalary'] = this.netsalary;
    data['status'] = this.status;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['currency_id'] = this.currencyId;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_name'] = this.currencyName;
    data['base_currency_id'] = this.baseCurrencyId;

    data['base_currency_code'] = this.baseCurrencyCode;
    data['base_currency_symbol'] = this.baseCurrencySymbol;
    data['exchange_rate'] = this.exchangeRate;
    return data;
  }
}
