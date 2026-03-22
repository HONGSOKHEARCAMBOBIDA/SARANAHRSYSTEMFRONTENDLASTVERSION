import 'dart:io';
import 'package:flutter_application_10/data/models/usermodel.dart' as myModel;
import 'package:flutter_application_10/data/models/userupdatemodel.dart';
import 'package:flutter_application_10/modules/auth/authservice/authservice.dart';
import 'package:flutter_application_10/modules/main/binding/mainbinding.dart';
import 'package:flutter_application_10/modules/main/mainview/mainview.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class Authcontroller extends GetxController {
  final Authservice authservice = Authservice();
  var users = <myModel.Data>[].obs;
  final imagepicker = ImagePicker();
  File? profileImage;
  File? qrcodeimage;
  var isLoading = false.obs;
  final GetStorage box = GetStorage();
  final RxString searchQuery = ''.obs;
 var selectedPartIds = <int>[].obs;
  @override
  void onInit() {
    // Fetch all users first
    fetchUser();

    // Debounce search
    debounce(
      searchQuery, // Rx value to watch
      (_) => fetchUser(name: searchQuery.value), // Action to run
      time: const Duration(milliseconds: 200), // Wait 500ms after last input
    );

    super.onInit();
  }


  void selectPart(int partId) {
  if (selectedPartIds.contains(partId)) {
    selectedPartIds.remove(partId);
  } else {
    selectedPartIds.add(partId);
  }
    update();
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

  Future<void> fetchUser({
    int? branchID,
    int? roleId,
    int? is_active,
    String? name,
  }) async {
    try {
      isLoading.value = true;
      final result = await authservice.getuser(
        branchid: branchID,
        roleid: roleId,
        is_active: is_active,
        name: name,
      );
      users.clear();
      users.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login({required String phone, required String password}) async {
    isLoading.value = true;
    try {
      final response = await authservice.login(
        phone: phone,
        password: password,
      );

      if (response.token != null && response.token!.isNotEmpty) {
              final List<String> partNames =
          response.user?.parts
              ?.where((p) => p.partName != null)
              .map((p) => p.partName!)
              .toList() ?? <String>[];
        await box.write('token', response.token); // <-- await is important
        await box.write('part', partNames);
        CustomSnackbar.success(title: "ជោគជ័យ", message: "ចូលបានសម្រេច");
        Get.offAll(() => MainView(), binding: MainBinding());
      } else {
        CustomSnackbar.error(
          title: "បរាជ័យ",
          message: "លេខទូរសព្ទ ឬលេខសម្ងាត់ មិនត្រឹមត្រូវ",
        );
      }
    } catch (e) {
       CustomSnackbar.error(
    title: "បរាជ័យ",
    message:e.toString(),
  );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> register(UserRegisterModel user) async {
  //   try {
  //     isLoading.value = true;

  //     bool isCreated = await authservice.register(user);

  //     if (isCreated) {
  //        await fetchUser();
  //       Get.back(result: true);
  //       CustomSnackbar.success(title: "ជោគជ័យ", message: "បង្កើតបានជោគជ័យ");
  //     }
  //   } catch (e) {
  //     CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
  //   } finally {
  //     isLoading.value = false; // ❗ Fix: must be false, not true
  //   }
  // }
  Future<void> register({
   
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
    required int currencyID,
    required List<int> partIDs,
    required int positionLevel,
    // File? profileImage,
    // File? qrcodeimage,
  }) async {
    try {
      isLoading.value = true;
      final iscreated = await authservice.register(
        branchID: branchID,
        nameEn: nameEn,
        nameKh: nameKh,
        username: username,
        email: email,
        password: password,
        gender: gender,
        contact: contact,
        nationalIdNumber: nationalIdNumber,
        roleId: roleId,
        hireDate: hireDate,
        promoteDate: promoteDate,
        type: type,
        shiftID: shiftID,
        baseSalary: baseSalary,
        workday: workday,
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
        currencyID: currencyID,
        partIDs: partIDs,
        positionLevel: positionLevel,
        profileImage: profileImage,
        qrcodeimage: qrcodeimage
      );
      if (iscreated) {
        Get.back();
      }
    } catch (e) {
      CustomSnackbar.error(title: "ខុសប្រក្រី".tr, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateuser(int userId,Userupdatemodel user) async {
    try {
      isLoading.value = true;
      bool isupdated = await authservice.updateuser(userId,user);
      if (isupdated) {
        await fetchUser();
        Get.back(result: true);
        CustomSnackbar.success(title: "ជោគជ័យ", message: "កែប្រែបានជោគជ័យ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changestatususer(int id) async {
    try {
      isLoading.value = true;
      bool update = await authservice.changestatus(id: id);
      if (update) {
         fetchUser();
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
