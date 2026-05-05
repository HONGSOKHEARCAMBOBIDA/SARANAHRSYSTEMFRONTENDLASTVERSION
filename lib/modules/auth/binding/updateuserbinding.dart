import 'package:flutter_application_10/modules/auth/binding/authbinding.dart';
import 'package:flutter_application_10/modules/branch/brandbinding/branchbinding.dart';
import 'package:flutter_application_10/modules/communce/communcebinding/communcebinding.dart';
import 'package:flutter_application_10/modules/district/districtbinding/districtbinding.dart';
import 'package:flutter_application_10/modules/part/binding/partbinding.dart';
import 'package:flutter_application_10/modules/province/provincebinding/provincebinding.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/village/villagebinding/villagebinding.dart';
import 'package:get/get.dart';
class UpdateUserBindings extends Bindings {
  @override
  void dependencies() {
    Provincebinding().dependencies();
    Districtbinding().dependencies();
    Communcebinding().dependencies();
    Villagebinding().dependencies();
    Rolebinding().dependencies();
    Branchbinding().dependencies();
    Partbinding().dependencies();
  }
}
