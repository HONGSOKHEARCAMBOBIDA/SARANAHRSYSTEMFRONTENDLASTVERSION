class AttendanceModel {
  List<Data>? data;

  AttendanceModel({this.data});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeShiftId;
  String? profile;
  String? checkDate;
  String? checkIn;
  String? checkOut;
  int? isLate;
  int? isLeftEarly;
  int? branchId;
  String? branchName;
  int? status;
  String? nameEn;
  String? nameKh;
  int? roleId;
  String? roleName;
  int? type;
  int? shiftId;
  String? shiftName;
  String? startTime;
  String? endTime;
  bool? isZoonCheckIn;
  bool? isZoonCheckOut;
  String? latitudeCheckIn;
  String? longitudeCheckIn;
  String? latitudeCheckOut;
  String? longitudeCheckOut;
  String? notes;

  Data(
      {this.id,
      this.employeeShiftId,
      this.profile,
      this.checkDate,
      this.checkIn,
      this.checkOut,
      this.isLate,
      this.isLeftEarly,
      this.branchId,
      this.branchName,
      this.status,
      this.nameEn,
      this.nameKh,
      this.roleId,
      this.roleName,
      this.type,
      this.shiftId,
      this.shiftName,
      this.startTime,
      this.endTime,
      this.isZoonCheckIn,
      this.isZoonCheckOut,
      this.latitudeCheckIn,
      this.longitudeCheckIn,
      this.latitudeCheckOut,
      this.longitudeCheckOut,
      this.notes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeShiftId = json['employee_shift_id '];
    profile = json['employee_profile'];
    checkDate = json['check_date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    isLate = json['is_late'];
    isLeftEarly = json['is_left_early'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    status = json['status'];
    nameEn = json['name_en'];
    nameKh = json['name_kh'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    type = json['type'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isZoonCheckIn = json['is_zoon_check_in'];
    isZoonCheckOut = json['is_zoon_check_out'];
    latitudeCheckIn = json['latitude_check_in'];
    longitudeCheckIn = json['longitude_check_in'];
    latitudeCheckOut = json['latitude_check_out'];
    longitudeCheckOut = json['longitude_check_out'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_shift_id '] = this.employeeShiftId;
    data['check_date'] = this.checkDate;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['is_late'] = this.isLate;
    data['is_left_early'] = this.isLeftEarly;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['status'] = this.status;
    data['name_en'] = this.nameEn;
    data['name_kh'] = this.nameKh;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['type'] = this.type;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_zoon_check_in'] = this.isZoonCheckIn;
    data['is_zoon_check_out'] = this.isZoonCheckOut;
    data['latitude_check_in'] = this.latitudeCheckIn;
    data['longitude_check_in'] = this.longitudeCheckIn;
    data['latitude_check_out'] = this.latitudeCheckOut;
    data['longitude_check_out'] = this.longitudeCheckOut;
    data['notes'] = this.notes;
    return data;
  }
}
