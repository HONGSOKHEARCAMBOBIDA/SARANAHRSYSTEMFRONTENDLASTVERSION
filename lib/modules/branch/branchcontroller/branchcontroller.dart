import 'package:flutter_application_10/data/models/branchmodel.dart';
import 'package:flutter_application_10/modules/branch/branchservice/branchservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';


class Branchcontroller extends GetxController {
  final Branchservice branchservice = Branchservice();
  var branch = <Data>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchbranch(); // Fetch all roles by default
    super.onInit();
  }

  Future<void> fetchbranch() async {
    try {
      final result = await branchservice.getbranch();
      branch.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    }
  }

  Future<void> createbranch({
    required String name,
    required double latitude,
    required double longitude,
    required int radius,
  }) async {
    try {
      isLoading.value = true;
      bool created = await branchservice.createbranch(
        name: name,
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      if (created) {
        await fetchbranch();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatebranch({
    required String name,
    required double latitude,
    required double longitude,
    required double radius,
    required int branchid,
  }) async {
    try {
      isLoading.value = true;
      bool updated = await branchservice.updatebranch(
        name: name,
        latitude: latitude,
        longitude: longitude,
        radius: radius,
        branchID: branchid,
      );
      if (updated) {
        Get.back();
        await fetchbranch();
        
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatusbranch({required int branchid}) async {
    try {
      isLoading.value = true;
      bool updated = await branchservice.changestatusbranch(branchid: branchid);
      if (updated) {
        await fetchbranch();
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
