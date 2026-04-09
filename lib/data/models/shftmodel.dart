class ShiftModel {
  List<Data>? data;

  ShiftModel({this.data});

  ShiftModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? startTime;
  String? endTime;
  int? branchId;
  int? isActive;

  Data({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.branchId,
    this.isActive,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ;
    //+ ": " + json['start_time'] + " - " + json['end_time']
    startTime = json['start_time'];
    endTime = json['end_time'];
    branchId = json['branch_id'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['branch_id'] = this.branchId;
    data['is_active'] = this.isActive;
    return data;
  }
}
