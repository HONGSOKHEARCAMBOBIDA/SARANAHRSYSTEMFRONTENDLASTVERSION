import 'package:flutter_application_10/data/models/rolemodel.dart';
import 'package:flutter_application_10/data/models/rolepermission.dart'
    as mymodel;
import 'package:flutter_application_10/data/providers/api_provider.dart';
import 'package:flutter_application_10/modules/role/roleservice/roleservice.dart';
import 'package:flutter_application_10/modules/role/roleview/rolepermissionfordelete.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Rolecontroller extends GetxController {
  final Roleservice roleservice = Roleservice();
  var role = <Data>[].obs;
  final ApiProvider apiProvider = ApiProvider();
  var roleassingpermission = <mymodel.Data>[].obs;
  var isLoading = false.obs;
  final RxSet<int> changedPermissionIds = <int>{}.obs;
  final RxSet<int> deletepermissionIDs = <int>{}.obs;
  var searchQuery = ''.obs;
  @override
  void onInit() {
    fetchrole(); // Fetch all roles by default
    super.onInit();
  }
List<mymodel.Data> get filteredPermissions {
  if (searchQuery.value.isEmpty) {
    return roleassingpermission;
  }
  return roleassingpermission.where((p) {
    return p.displayName!.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
           p.name!.toLowerCase().contains(searchQuery.value.toLowerCase());
  }).toList();
}

  void saveRolePermissions(int roleId) async {
    try {
      // ✅ Only permissions the user toggled
      List<int> selectedPermissionIds = changedPermissionIds.toList();

      if (selectedPermissionIds.isEmpty) {
        Get.snackbar('Info', 'No changes to save.');
        return;
      }

      final data = {'role_id': roleId, 'permission_ids': selectedPermissionIds};

      final response = await apiProvider.post('/addpermissiontorole', data);

      if (response.statusCode == 200) {
        CustomSnackbar.success(
          title: "ជោគជ័យ",
          message: "បន្ថែមសិទ្ធបានជោគជ័យ",
        );
        changedPermissionIds.clear(); // ✅ Clear after successful save
        await fetchroleassignpermission(roleId); // Reload from server
      } else {
        CustomSnackbar.error(title: "មានបញ្ហា", message: response.data);
      }
    } catch (e) {
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    }
  }

  void saveRolePermissionsForDelete(int roleid) async {
    try {
      List<int> selettePermissionfordelete = deletepermissionIDs.toList();
      if (selettePermissionfordelete.isEmpty) {
        CustomSnackbar.error(
          title: "ខុសប្រក្រតី",
          message: "សូមជ្រេីសរេីសយ៉ាងតិចមួយ",
        );
        return;
      }
      final data = {
        'role_id': roleid,
        'permission_ids': selettePermissionfordelete,
      };
      final response = await apiProvider.postbutdelete(
        '/deletepermissionrole',
        data,
      );
      if (response.statusCode == 200) {
        CustomSnackbar.success(title: "ជោគជ័យ", message: "លុបបានជោគជ័យ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: "លុបមិនបាន");
    }
  }

  Future<void> fetchrole() async {
    try {
      final result = await roleservice.getrole();
      role.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createrole(Data rolemodel) async {
    try {
      isLoading.value = true;
      bool isCreated = await roleservice.createrole(rolemodel);
      if (isCreated) {
        await fetchrole();
        Get.back(result: true);
        CustomSnackbar.success(title: "ជោគជ័យ", message: "បង្កើតបានជោគជ័យ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false; // ❗ Fix: must be false, not true
    }
  }

  Future<void> updaterole(Data rolemodel) async {
    try {
      isLoading.value = true;
      bool isupdated = await roleservice.updaterole(rolemodel);
      if (isupdated) {
    
        await fetchrole();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> Changestatusrole(int? id) async {
    try {
      isLoading.value = true;
      bool update = await roleservice.changestatusrole(id);
      if (update) {
        await fetchrole();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchroleassignpermission(int roleid) async {
    try {
      isLoading.value = true;
      final result = await roleservice.getroleassignpermission(roleid);
      roleassingpermission.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រតី", message: "${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
