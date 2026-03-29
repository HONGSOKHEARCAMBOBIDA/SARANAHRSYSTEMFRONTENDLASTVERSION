import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/show_branch_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_communce_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_district_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_province_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_role_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/show_village_buttonsheet.dart';
import 'package:flutter_application_10/core/helper/showcurrencyselector.dart';

import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/auth/controller/authcontroller.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/communce/communcecontroller/communcecontroller.dart';
import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:flutter_application_10/modules/district/districtcontroller/districtcontroller.dart';
import 'package:flutter_application_10/modules/part/controller/partcontroller.dart';

import 'package:flutter_application_10/modules/province/provincecontroller/provincecontroller.dart';
import 'package:flutter_application_10/modules/role/rolecontroller/rolecontroller.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/modules/village/villagecontroller/villagecontroller.dart';
import 'package:flutter_application_10/shared/partcard.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/customdatepicker.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  Rx<File?> newProfileImage = Rx<File?>(null);
  Rx<File?> newQrImage = Rx<File?>(null);
  final currencycontroller = Get.find<Currencycontroller>();
  final authcontroller = Get.find<Authcontroller>();
  final provincecontroller = Get.find<Provincecontroller>();
  final districtcontroller = Get.find<Districtcontroller>();
  final commmuncecontroller = Get.find<Communcecontroller>();
  final villagecontroller = Get.find<Villagecontroller>();
  final rolecontroller = Get.find<Rolecontroller>();
  final branchcontroller = Get.find<Branchcontroller>();
  final shiftcontroller = Get.find<Shiftcontroller>();
  final partcontroller = Get.find<Partcontroller>();

  final _formkey = GlobalKey<FormState>();
  final selectcorrencyID = Rxn<int>();
  final selecttype = Rxn<int>();
  final selectispromote = Rxn<bool>();
  final selecthiredate = Rxn<DateTime>();
  final selectbranchid = Rxn<int>();
  final namekhcontroller = TextEditingController();
  final nameencontroller = TextEditingController();
  final selectgender = Rxn<int>();
  final selectmaterialstatus = Rxn<int>();
  final selectpositionlevel = Rxn<int>();
  final selectdob = Rxn<DateTime>();
  final selectpromotedate = Rxn<DateTime>();
  final contactcontroller = TextEditingController();
  final familyphonecontroller = TextEditingController();
  final educationlevelcontroller = TextEditingController();
  final experienceyearcontroller = TextEditingController();
  final previouscompanycontroller = TextEditingController();
  final banknamecontroller = TextEditingController();
  final bankaccountcontroller = TextEditingController();
  final notecontroller = TextEditingController();
  final nationalidnumbercontroller = TextEditingController();
  final selectvillageidofbirth = Rxn<int>();
  final selectprovinceidofbirth = Rxn<int>();
  final selectdistrictidofbirth = Rxn<int>();
  final selectcommunceidofbirth = Rxn<int>();
  final selectvillageidofcurrenctadrress = Rxn<int>();
  final selectprovinceidofcurrenctadrress = Rxn<int>();
  final selectdistrictidofcurrenctadrress = Rxn<int>();
  final selectcommunceidofcurrenctadrress = Rxn<int>();
  final selectroleid = Rxn<int>();

  // NEW CONTROLLERS FOR REGISTRATION
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final baseSalaryController = TextEditingController();
  final workdayController = TextEditingController();

  // NEW RX VARIABLES
  final selectShiftId = Rxn<int>();
  final baseSalary = Rxn<double>();
  final workday = Rxn<int>();

  var selectedProvinceNameofbirth = "ជ្រើសរើសខេត្ត".obs;
  var selectedDistrictNameofbirth = "ជ្រើសរើសស្រុក".obs;
  var selectedCommunceNameofbirth = "ជ្រើសរើសឃុំ".obs;
  var selectedVillageNameofbirth = "ជ្រើសរើសភូមិ".obs;
  var selectedProvinceNameofcurrenctadrress = "ជ្រើសរើសខេត្ត".obs;
  var selectedDistrictNameofcurrenctadrress = "ជ្រើសរើសស្រុក".obs;
  var selectedCommunceNameofcurrenctadrress = "ជ្រើសរើសឃុំ".obs;
  var selectedVillageNameofcurrenctadrress = "ជ្រើសរើសភូមិ".obs;
  var selectedrolename = "រេីសតួនាទី".obs;
  var selectedbranchname = "រេីសសាខា".obs;
  var selectedcurrencyname = "សូមជ្រេីសរេីសរូបិយប័ណ្ណ".obs;
  final List<Map<String, dynamic>> genders = [
    {"id": 1, "name": "ប្រុស"},
    {"id": 2, "name": "ស្រី"},
    {"id": 3, "name": "ផ្សេងទៀត"},
  ];
  final List<Map<String, dynamic>> materialstatus = [
    {"id": 1, "name": "នៅលីវ"},
    {"id": 2, "name": "មានគ្រូសារ"},
    {"id": 3, "name": "ផ្សេងទៀត"},
  ];
  final List<Map<String, dynamic>> types = [
    {"id": 1, "name": "Part Time"},
    {"id": 2, "name": "Full Time"},
  ];
  final List<Map<String, dynamic>> positionLevel = [
    {"id": 1, "name": "បុគ្គលិកធម្មតា"},
    {"id": 2, "name": "បុគ្គលិកជំនាញ"},
  ];

  // ADD SHIFT DATA (You'll need to fetch this from your API)
  // final List<Map<String, dynamic>> shifts = [
  //   {"id": 1, "name": "វេនព្រឹក"},
  //   {"id": 2, "name": "វេនរសៀល"},
  //   {"id": 3, "name": "វេនយប់"},
  // ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    // Load initial data for dropdowns
    provincecontroller.fetchprovince();
    branchcontroller.fetchbranch();
    rolecontroller.fetchrole();
  }

  Future<void> registerUser() async {
    final selectpartids = authcontroller.selectedPartIds.toList();
    print(selectpartids);
    if (_formkey.currentState!.validate()) {
      // Validate required fields for registration
      if (selectbranchid.value == null ||
          selectgender.value == null ||
          selectdob.value == null ||
          selectvillageidofbirth.value == null ||
          selectroleid.value == null ||
          selecttype.value == null ||
          selecthiredate.value == null ||
          usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          selectShiftId.value == null ||
          baseSalaryController.text.isEmpty ||
          workdayController.text.isEmpty) {
        CustomSnackbar.error(
          title: "បញ្ចូលមិនពេញលេញ",
          message: "សូមបញ្ចូលព័ត៌មានឲ្យបានពេញលេញ!",
        );
        return;
      }

      // Validate password confirmation
      if (passwordController.text != confirmPasswordController.text) {
        CustomSnackbar.error(
          title: "លេខសំងាត់មិនត្រូវគ្នា",
          message: "លេខសំងាត់និងលេខសំងាត់បញ្ជាក់មិនត្រូវគ្នា!",
        );
        return;
      }

      try {
        final year = int.tryParse(experienceyearcontroller.text) ?? 0;
        final salary = double.tryParse(baseSalaryController.text) ?? 0.0;
        final workDays = int.tryParse(workdayController.text) ?? 0;

        await authcontroller.register(
          branchID: selectbranchid.value!.toString(),
          nameEn: nameencontroller.text.trim(),
          nameKh: namekhcontroller.text.trim(),
          username: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          gender: selectgender.value!,
          contact: contactcontroller.text.trim(),
          nationalIdNumber: nationalidnumbercontroller.text.trim(),
          roleId: selectroleid.value!,
          hireDate: selecthiredate.value!,
          promoteDate: selectpromotedate.value ?? selecthiredate.value!,
          type: selecttype.value!,
          shiftID: selectShiftId.value!,
          baseSalary: salary,
          workday: workDays,
          dateOfBirth: selectdob.value!,
          villageIdofbirth: selectvillageidofbirth.value!,
          materialstatus: selectmaterialstatus.value ?? 1,
          villageIdcurrentaddress:
              selectvillageidofcurrenctadrress.value ??
              selectvillageidofbirth.value!,
          familyPhone: familyphonecontroller.text,
          educationLevel: educationlevelcontroller.text,
          experienceYears: year,
          previousCompany: previouscompanycontroller.text,
          bankName: banknamecontroller.text,
          bankAccountNumber: bankaccountcontroller.text,
          notes: notecontroller.text,
          currencyID: selectcorrencyID.value!,
          partIDs: selectpartids,
          positionLevel: selectpositionlevel.value ?? 1,
          // profileImage: newProfileImage.value,
          // qrcodeimage: newQrImage.value,
        );
      } catch (e) {
        CustomSnackbar.error(title: "កំហុស", message: "មិនអាចចុះឈ្មោះបាន: $e");
      }
    }
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(label, style: TextStyles.siemreap(context, fontSize: 12)),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildHeader(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          Icon(icon, color: TheColors.orange, size: 18),
          SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.siemreap(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: TheColors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    namekhcontroller.dispose();
    nameencontroller.dispose();
    contactcontroller.dispose();
    nationalidnumbercontroller.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    baseSalaryController.dispose();
    workdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: TheColors.bgColor,
        appBar: CustomAppBar(title: "ចុះឈ្មោះអ្នកប្រើប្រាស់ថ្មី"),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image Section
                      Center(
                        child: Column(
                          children: [
                            Obx(() {
                              if (newProfileImage.value != null) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: TheColors
                                          .warningColor, // Border color
                                      width: 0.9,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(
                                        newProfileImage.value!,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                        decoration: BoxDecoration(
      border: Border.all(
        color: TheColors.orange,// Border color
        width: 0.9,
      ),
      borderRadius: BorderRadius.circular(60),
    ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      radius: 50,
                                      child: Icon(Icons.person, size: 40,color: TheColors.errorColor,),
                                    ),
                                  ),
                                );
                              }
                            }),
                            SizedBox(height: 10),
                            OutlinedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                    color: TheColors.orange,
                                    width: 1,
                                  ),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final image = await authcontroller
                                    .pickProfile();
                                if (image != null) {
                                  newProfileImage.value = image;
                                }
                              },
                              child: Text(
                                "ជ្រើសរើសរូបភាព",
                                style: TextStyles.siemreap(
                                  context,
                                  color: TheColors.orange,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Account Information Section
                      Container(
                                        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader("ព័ត៌មានគណនី", Icons.lock_outline),
                              SizedBox(height: 8),
                              _buildLabel("ឈ្មោះអ្នកប្រើប្រាស់"),
                              CustomTextField(
                                controller: usernameController,
                                hintText: "hong.sokhear",
                                prefixIcon: Icons.person_outlined,
                              ),
                              SizedBox(height: 8),
                              _buildLabel("អ៊ីមែល"),
                              CustomTextField(
                                controller: emailController,
                                hintText: "example@company.com",
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("លេខសំងាត់"),
                                        CustomTextField(
                                          controller: passwordController,
                                          hintText: "********",
                                          prefixIcon: Icons.lock_outlined,
                                          obscureText: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("បញ្ជាក់លេខសំងាត់"),
                                        CustomTextField(
                                          controller: confirmPasswordController,
                                          hintText: "********",
                                          prefixIcon: Icons.lock_outlined,
                                          obscureText: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Personal Information Section
                      Container(
                                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader("ព័ត៍មានផ្ទាល់ខ្លួន", Icons.person),
                              SizedBox(height: 8),
                              _buildLabel("ឈ្មោះភាសាខ្មែរ"),
                              CustomTextField(
                                controller: namekhcontroller,
                                hintText: "ឧ. ហុង សុខហ៊ា",
                                prefixIcon: Icons.person_outlined,
                              ),
                              SizedBox(height: 8),
                              _buildLabel("ឈ្មោះអង់គ្លេស"),
                              CustomTextField(
                                controller: nameencontroller,
                                hintText: "HONG SOKHEAR",
                                prefixIcon: Icons.person_outlined,
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("ភេទ"),
                                        Obx(
                                          () => DropdownButtonFormField<int>(
                                            value: selectgender.value,
                                            decoration: InputDecoration(
                                              labelText: "ភេទ",
                                              labelStyle: TextStyles.siemreap(
                                                context,
                                                fontSize: 12,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: TheColors.orange,
                                                  width: 0.5,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  color: TheColors.errorColor,
                                                  width: 0.5,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: TheColors.orange,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            items: genders.map((gender) {
                                              return DropdownMenuItem<int>(
                                                value: gender['id'] as int,
                                                child: Text(
                                                  gender['name'],
                                                  style: TextStyles.siemreap(
                                                    context,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            dropdownColor: TheColors.bgColor,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: TheColors.orange,
                                            ),
                                            iconSize: 17,
                                            elevation: 2,
                                            menuMaxHeight: 140,
                                            style: TextStyles.siemreap(
                                              context,
                                              fontSize: 12,
                                            ),
                                            onChanged: (Value) {
                                              selectgender.value = Value;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("ថ្ងៃ-ខែ-ឆ្នាំ កំណេីត"),
                                        CustomDatePickerField(
                                          label: "",
                                          selectedDate: selectdob,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("លេខអត្តសញ្ញាណប័ណ្ណ"),
                                        CustomTextField(
                                          controller:
                                              nationalidnumbercontroller,
                                          hintText: "A123456",
                                          prefixIcon: Icons.credit_card,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("លេខទូរសព្ទ"),
                                        CustomTextField(
                                          keyboardType: TextInputType.phone,
                                          controller: contactcontroller,
                                          hintText: "070366214",
                                          prefixIcon: Icons.phone_callback,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("ស្ថានភាពគ្រួសារ"),
                                  Obx(
                                    () => DropdownButtonFormField<int>(
                                      value: selectmaterialstatus.value,
                                      decoration: InputDecoration(
                                        labelText: "ស្ថានភាព",
                                        labelStyle: TextStyles.siemreap(
                                          context,
                                          fontSize: 12,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: TheColors.orange,
                                            width: 0.5,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: TheColors.errorColor,
                                            width: 0.5,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: TheColors.orange,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      items: materialstatus.map((material) {
                                        return DropdownMenuItem<int>(
                                          value: material['id'] as int,
                                          child: Text(
                                            material['name'],
                                            style: TextStyles.siemreap(
                                              context,
                                              fontSize: 12,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      dropdownColor: TheColors.bgColor,
                                      borderRadius: BorderRadius.circular(12),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: TheColors.orange,
                                      ),
                                      iconSize: 20,
                                      elevation: 2,
                                      menuMaxHeight: 200,
                                      style: TextStyles.siemreap(
                                        context,
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      onChanged: (Value) {
                                        selectmaterialstatus.value = Value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              _buildLabel("លេខទូរសព្ទគ្រូសារ"),
                              CustomTextField(
                                keyboardType: TextInputType.phone,
                                controller: familyphonecontroller,
                                hintText: "070366214",
                                prefixIcon: Icons.phone_callback,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Work Information Section
                      Container(
                                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader("ព័ត៌មានការងារ", Icons.work_outline),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("តួនាទី"),

                                  Obx(
                                    () => CustomOutlinedButton(
                                      text: selectedrolename.value.isEmpty
                                          ? "រេីសតួនាទី"
                                          : selectedrolename.value,
                                      onPressed: () {
                                        showRoleSelectorsheet(
                                          context: context,
                                          role: rolecontroller.role,
                                          selectedSelectId: selectroleid.value,
                                          onSelected: (id) {
                                            selectroleid.value = id;
                                            selectedrolename
                                                .value = rolecontroller.role
                                                .firstWhere((p) => p.id == id)
                                                .displayName!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                               SizedBox(
  height: 8,
),
Obx(() {
  if (partcontroller.isLoading.value) {
    return CustomLoading();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel("ផ្នែកដែលអាចមេីលបាន"),
  SingleChildScrollView(
    child: SizedBox(
    height: 160,
    child: GetBuilder<Authcontroller>(
      builder: (authController) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 3 / 1.2,
          ),
          itemCount: partcontroller.parts.length,
          itemBuilder: (context, index) {
            final part = partcontroller.parts[index];
            final isSelected = authController.selectedPartIds.contains(part.id);
            return Partcard(
              part: part,
              isSelected: isSelected,
              onTap: () => authController.selectPart(part.id!),
            );
          },
        );
      },
    ),
    ),
  ),
    ],
  );
}),
                     
                                  SizedBox(height: 8),
                                  _buildLabel("សាខា"),
                                  Obx(
                                    () => CustomOutlinedButton(
                                      text: selectedbranchname.value.isEmpty
                                          ? "រេីសសាខា"
                                          : selectedbranchname.value,
                                      onPressed: () {
                                        showBranchSelectorSheet(
                                          context: context,
                                          branch: branchcontroller.branch,
                                          selectedBranchId: selectbranchid.value,
                                          onSelected: (id) {
                                            selectbranchid.value = id;
                                            selectedbranchname
                                                .value = branchcontroller.branch
                                                .firstWhere((p) => p.id == id)
                                                .name!;
                                            shiftcontroller.shift.clear();
                                            shiftcontroller.fetchshift(
                                              selectbranchid.value,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildLabel("ថ្ងៃចូលបម្រេីការងារ"),
                                            CustomDatePickerField(
                                              label: "",
                                              selectedDate: selecthiredate,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Label (optional)
                                            _buildLabel("ប្រភេទការងារ"),

                                            Obx(
                                              () => DropdownButtonFormField<int>(
                                                // Value and items
                                                value: selecttype.value,
                                                items: types.map((typework) {
                                                  return DropdownMenuItem<int>(
                                                    value:
                                                        typework['id'] as int,
                                                    child: Text(
                                                      typework['name'],
                                                      style:
                                                          TextStyles.siemreap(
                                                            context,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (Value) {
                                                  selecttype.value = Value;
                                                },

                                                // Dropdown styling
                                                dropdownColor:
                                                    TheColors.bgColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: TheColors.orange,
                                                ),
                                                iconSize: 30,
                                                elevation: 2,
                                                menuMaxHeight: 250,

                                                // Button styling
                                                style: TextStyles.siemreap(
                                                  context,
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                  // Content padding
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 14,
                                                      ),

                                                  // Label (if you want it inside the field)
                                                  // labelText: "ប្រភេទការងារ",
                                                  // labelStyle: TextStyles.siemreap(
                                                  //   context,
                                                  //   fontSize: 12,
                                                  //   color: TheColors.gray,
                                                  // ),

                                                  // Hint when no value is selected
                                                  hintText: "ប្រភេទការងារ",
                                                  hintStyle:
                                                      TextStyles.siemreap(
                                                        context,
                                                        fontSize: 12,
                                                        color: TheColors.gray,
                                                      ),

                                                  // Border styling
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: TheColors.orange,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              TheColors.orange,
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color:
                                                              TheColors.orange,
                                                          width: 1,
                                                        ),
                                                      ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color:
                                                          TheColors.errorColor,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        borderSide: BorderSide(
                                                          color: TheColors
                                                              .errorColor,
                                                          width: 1,
                                                        ),
                                                      ),

                                                  // Fill color
                                                  filled: true,
                                                  fillColor: TheColors.bgColor,

                                                  // Optional: Add prefix icon
                                                  // prefixIcon: Icon(
                                                  //   Icons.work,
                                                  //   color: TheColors.orange,
                                                  //   size: 20,
                                                  // ),
                                                ),

                                                // Custom dropdown item height
                                                itemHeight: 50,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("រូបិយប័ណ្ណដែលប្រេី"),

                                      // CustomDropdown(
                                      //   selectedValue: selectcorrencyID,
                                      //   items: currencycontroller.currency,
                                      //   hintText: "ឧ ប្រាក់រៀល",
                                      //   onChanged: (id) {
                                      //     selectcorrencyID.value = id;
                                      //   },
                                      // ),
                                      Obx(
                                        () => CustomOutlinedButton(
                                          text:
                                              selectedcurrencyname.value.isEmpty
                                              ? "សូមជ្រេីសរេីសរុបិយប័ណ្ណ"
                                              : selectedcurrencyname.value,
       
                                          onPressed: () {
                                            showcurrencyselector(
                                              context: context,
                                              currency:
                                                  currencycontroller.currency,
                                              selectedCurrencyId: selectcorrencyID.value,
                                              onSelected: (id) {
                                                selectcorrencyID.value = id;
                                                selectedcurrencyname.value =
                                                    currencycontroller.currency
                                                        .firstWhere(
                                                          (p) => p.id == id,
                                                        )
                                                        .name!;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildLabel("ប្រាក់ខែគោល"),
                                            CustomTextField(
                                              controller: baseSalaryController,
                                              hintText: "500.00",
                                              prefixIcon: Icons.attach_money,
                                              keyboardType:
                                                  TextInputType.numberWithOptions(
                                                    decimal: true,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildLabel("ថ្ងៃធ្វើការ"),
                                            CustomTextField(
                                              controller: workdayController,
                                              hintText: "26",
                                              prefixIcon: Icons.calendar_today,
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel("វេនការងារ"),
                                      CustomDropdown(
                                        selectedValue: selectShiftId,
                                        items: shiftcontroller.shift,
                                        hintText: "វេនការងារ",
                                        onChanged: (value) {
                                          selectShiftId.value = value;
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Financial Information Section
                      Container(
                                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(
                                "ព័ត៌មានផ្នែកហិរញ្ញវត្ថុ",
                                Icons.attach_money,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("កុងធនាគារដែលប្រេី"),
                                  CustomTextField(
                                    controller: banknamecontroller,
                                    hintText: "ABA",
                                    prefixIcon: Icons.credit_card,
                                  ),
                                  SizedBox(height: 8),
                                  _buildLabel("លេខកុងធនាគារ"),
                                  CustomTextField(
                                    controller: bankaccountcontroller,
                                    hintText: "A123",
                                    prefixIcon: Icons.account_circle,
                                  ),
                                  SizedBox(height: 8),
                                  _buildLabel("QR Code"),
                                  Obx(() {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Container(
                                              width: 120,
                                              height: 120,
                                              color: TheColors.yellow.withOpacity(0.1),
                                             
                                              child: newQrImage.value == null
                                                  ? Icon(
                                                      Icons.qr_code,
                                                      size: 50,
                                                      color: Colors.white,
                                                    )
                                                  : Image(
                                                      image: FileImage(
                                                        newQrImage.value!,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.camera_alt_rounded,
                                              size: 30,
                                              color: TheColors.errorColor,
                                            ),
                                            onPressed: () async {
                                              File? pickedFile =
                                                  await authcontroller
                                                      .pickqrImage();
                                              if (pickedFile != null) {
                                                newQrImage.value = pickedFile;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Education and Experience Section
                      Container(
                                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(
                                "ព័ត៌មានអប់រំ និងបទពិសោធន៍",
                                Icons.school_outlined,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("កម្រិតសិក្សា"),
                                        CustomTextField(
                                          controller: educationlevelcontroller,
                                          hintText: "បរញ្ញាបត្រ",
                                          prefixIcon: Icons.menu_book,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel("បទពិសោធន៍គិតជាឆ្នាំ"),
                                        CustomTextField(
                                          controller: experienceyearcontroller,
                                          hintText: "2",
                                          prefixIcon: Icons.work_history,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              _buildLabel("ក្រុមហ៊ុនពីមុន"),
                              CustomTextField(
                                controller: previouscompanycontroller,
                                hintText: "ABA",
                                prefixIcon: Icons.apartment,
                              ),
                              SizedBox(height: 8),
                              _buildLabel("សម្គាល់"),
                              CustomTextField(
                                controller: notecontroller,
                                hintText: "..",
                                prefixIcon: Icons.sticky_note_2,
                              ),
                              SizedBox(height: 8),
                              _buildLabel("កម្រិតតួនាទី"),
                              Obx(
                                () => DropdownButtonFormField<int>(
                                  value: selectpositionlevel.value,
                                  decoration: InputDecoration(
                                    labelText: "កម្រិត",
                                    labelStyle: TextStyles.siemreap(
                                      context,
                                      fontSize: 12,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: TheColors.orange,
                                        width: 0.5,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: TheColors.errorColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: TheColors.orange,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  items: positionLevel.map((position) {
                                    return DropdownMenuItem<int>(
                                      value: position['id'] as int,
                                      child: Text(
                                        position['name'],
                                        style: TextStyles.siemreap(
                                          context,
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  dropdownColor: TheColors.bgColor,
                                  borderRadius: BorderRadius.circular(12),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: TheColors.orange,
                                  ),
                                  iconSize: 15,
                                  elevation: 2,
                                  menuMaxHeight: 140,
                                  style: TextStyles.siemreap(
                                    context,
                                    fontSize: 12,
                                  ),
                                  onChanged: (Value) {
                                    selectpositionlevel.value = Value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Birth Place Section
                      Container(
                                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(
                                "ទីកន្លែងកំណើត",
                                Icons.location_on_outlined,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedProvinceNameofbirth
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសខេត្ត"
                                            : selectedProvinceNameofbirth.value,
                                        onPressed: () {
                                          showProvinceSelectorSheet(
                                            context: context,
                                            provinces:provincecontroller.provinces,
                                            selectedProvince: selectprovinceidofbirth.value,
                                            onSelected: (id) {
                                              selectprovinceidofbirth.value =
                                                  id;
                                              selectedProvinceNameofbirth
                                                  .value = provincecontroller
                                                  .provinces
                                                  .firstWhere((p) => p.id == id)
                                                  .name!;
                                              selectdistrictidofbirth.value =
                                                  null;
                                              selectedDistrictNameofbirth
                                                      .value =
                                                  "ជ្រើសរើសស្រុក";
                                              selectcommunceidofbirth.value =
                                                  null;
                                              selectedCommunceNameofbirth
                                                      .value =
                                                  "ជ្រើសរើសឃុំ";
                                              selectvillageidofbirth.value =
                                                  null;
                                              selectedVillageNameofbirth.value =
                                                  "ជ្រើសរើសភូមិ";
                                              districtcontroller.district
                                                  .clear();
                                              commmuncecontroller.communce
                                                  .clear();
                                              villagecontroller.village.clear();
                                              districtcontroller.fetchdistrict(
                                                id,
                                              );
                                            },
                                            
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedDistrictNameofbirth
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសស្រុក"
                                            : selectedDistrictNameofbirth.value,
                                        onPressed:
                                            selectprovinceidofbirth.value ==
                                                null
                                            ? null
                                            : () {
                                                showDistrictSelectorSheet(
                                                  context: context,
                                                  district: districtcontroller
                                                      .district,
                                                  selecteddistrict: selectdistrictidofbirth.value,
                                                  onSelected: (id) {
                                                    selectdistrictidofbirth
                                                            .value =
                                                        id;
                                                    selectedDistrictNameofbirth
                                                            .value =
                                                        districtcontroller
                                                            .district
                                                            .firstWhere(
                                                              (p) => p.id == id,
                                                            )
                                                            .name!;
                                                    selectcommunceidofbirth
                                                            .value =
                                                        null;
                                                    selectedCommunceNameofbirth
                                                            .value =
                                                        "ជ្រើសរើសឃុំ";
                                                    selectvillageidofbirth
                                                            .value =
                                                        null;
                                                    selectedVillageNameofbirth
                                                            .value =
                                                        "ជ្រើសរើសភូមិ";
                                                    commmuncecontroller.communce
                                                        .clear();
                                                    commmuncecontroller
                                                        .fetchcommunce(id);
                                                  },
                                                );
                                              },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedCommunceNameofbirth
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសឃុំ"
                                            : selectedCommunceNameofbirth.value,
                                        onPressed:
                                            selectdistrictidofbirth.value ==
                                                null
                                            ? null
                                            : () {
                                                showCommunceSelectorSheet(
                                                  context: context,
                                                  communce: commmuncecontroller
                                                      .communce,
                                                  selectedCommunce: selectcommunceidofbirth.value,
                                                  onSelected: (id) {
                                                    selectcommunceidofbirth
                                                            .value =
                                                        id;
                                                    selectedCommunceNameofbirth
                                                            .value =
                                                        commmuncecontroller
                                                            .communce
                                                            .firstWhere(
                                                              (p) => p.id == id,
                                                            )
                                                            .name!;
                                                    selectvillageidofbirth
                                                            .value =
                                                        null;
                                                    selectedVillageNameofbirth
                                                            .value =
                                                        "ជ្រើសរើសភូមិ";
                                                    villagecontroller.village
                                                        .clear();
                                                    villagecontroller
                                                        .fetvillage(id);
                                                  },
                                                );
                                              },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedVillageNameofbirth
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសភូមិ"
                                            : selectedVillageNameofbirth.value,
                                        onPressed:
                                            selectcommunceidofbirth.value ==
                                                null
                                            ? null
                                            : () {
                                                showVillageSelectorsheet(
                                                  context: context,
                                                  village:
                                                      villagecontroller.village,
                                                  selectedVillageId: selectvillageidofbirth.value,
                                                  onSelected: (id) {
                                                    selectvillageidofbirth
                                                            .value =
                                                        id;
                                                    selectedVillageNameofbirth
                                                            .value =
                                                        villagecontroller
                                                            .village
                                                            .firstWhere(
                                                              (p) => p.id == id,
                                                            )
                                                            .name!;
                                                  },
                                                );
                                              },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Current Address Section
                      Container(
                                          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(
                                "ទីកន្លែងបច្ចុប្បន្ន",
                                Icons.home_outlined,
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedProvinceNameofcurrenctadrress
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសខេត្ត"
                                            : selectedProvinceNameofcurrenctadrress
                                                  .value,
                                        onPressed: () {
                                          showProvinceSelectorSheet(
                                            context: context,
                                            provinces:
                                                provincecontroller.provinces,
                                            selectedProvince: selectprovinceidofcurrenctadrress.value,
                                            onSelected: (id) {
                                              selectprovinceidofcurrenctadrress
                                                      .value =
                                                  id;
                                              selectedProvinceNameofcurrenctadrress
                                                  .value = provincecontroller
                                                  .provinces
                                                  .firstWhere((p) => p.id == id)
                                                  .name!;
                                              selectdistrictidofcurrenctadrress
                                                      .value =
                                                  null;
                                              selectedDistrictNameofcurrenctadrress
                                                      .value =
                                                  "ជ្រើសរើសស្រុក";
                                              selectcommunceidofcurrenctadrress
                                                      .value =
                                                  null;
                                              selectedCommunceNameofcurrenctadrress
                                                      .value =
                                                  "ជ្រើសរើសឃុំ";
                                              selectvillageidofcurrenctadrress
                                                      .value =
                                                  null;
                                              selectedVillageNameofcurrenctadrress
                                                      .value =
                                                  "ជ្រើសរើសភូមិ";
                                              districtcontroller.district
                                                  .clear();
                                              commmuncecontroller.communce
                                                  .clear();
                                              villagecontroller.village.clear();
                                              districtcontroller.fetchdistrict(
                                                id,
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedDistrictNameofcurrenctadrress
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសស្រុក"
                                            : selectedDistrictNameofcurrenctadrress
                                                  .value,
                                        onPressed:
                                            selectprovinceidofcurrenctadrress
                                                    .value ==
                                                null
                                            ? null
                                            : () {
                                                showDistrictSelectorSheet(
                                                  context: context,
                                                  district: districtcontroller
                                                      .district,
                                                  selecteddistrict: selectdistrictidofcurrenctadrress.value,
                                                  onSelected: (id) {
                                                    selectdistrictidofcurrenctadrress
                                                            .value =
                                                        id;
                                                    selectedDistrictNameofcurrenctadrress
                                                            .value =
                                                        districtcontroller
                                                            .district
                                                            .firstWhere(
                                                              (p) => p.id == id,
                                                            )
                                                            .name!;
                                                    selectcommunceidofcurrenctadrress
                                                            .value =
                                                        null;
                                                    selectedCommunceNameofcurrenctadrress
                                                            .value =
                                                        "ជ្រើសរើសឃុំ";
                                                    selectvillageidofcurrenctadrress
                                                            .value =
                                                        null;
                                                    selectedVillageNameofcurrenctadrress
                                                            .value =
                                                        "ជ្រើសរើសភូមិ";
                                                    commmuncecontroller.communce
                                                        .clear();
                                                    commmuncecontroller
                                                        .fetchcommunce(id);
                                                  },
                                                );
                                              },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedCommunceNameofcurrenctadrress
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសឃុំ"
                                            : selectedCommunceNameofcurrenctadrress
                                                  .value,
                                        onPressed:
                                            selectdistrictidofcurrenctadrress
                                                    .value ==
                                                null
                                            ? null
                                            : () {
                                                showCommunceSelectorSheet(
                                                  context: context,
                                                  communce: commmuncecontroller
                                                      .communce,
                                                  selectedCommunce: selectcommunceidofcurrenctadrress.value,
                                                  onSelected: (id) {
                                                    selectcommunceidofcurrenctadrress
                                                            .value =
                                                        id;
                                                    selectedCommunceNameofcurrenctadrress
                                                            .value =
                                                        commmuncecontroller
                                                            .communce
                                                            .firstWhere(
                                                              (p) => p.id == id,
                                                            )
                                                            .name!;
                                                    selectvillageidofcurrenctadrress
                                                            .value =
                                                        null;
                                                    selectedVillageNameofcurrenctadrress
                                                            .value =
                                                        "ជ្រើសរើសភូមិ";
                                                    villagecontroller.village
                                                        .clear();
                                                    villagecontroller
                                                        .fetvillage(id);
                                                  },
                                                );
                                              },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Obx(
                                      () => CustomOutlinedButton(
                                        alignment: MainAxisAlignment.center,
                                        text:
                                            selectedVillageNameofcurrenctadrress
                                                .value
                                                .isEmpty
                                            ? "ជ្រើសរើសភូមិ"
                                            : selectedVillageNameofcurrenctadrress
                                                  .value,
                                        onPressed:
                                            selectcommunceidofcurrenctadrress
                                                    .value ==
                                                null
                                            ? null
                                            : () {
                                                showVillageSelectorsheet(
                                                  context: context,
                                                  village:
                                                      villagecontroller.village,
                                                  selectedVillageId: selectvillageidofcurrenctadrress.value,
                                                  onSelected: (id) {
                                                    selectvillageidofcurrenctadrress
                                                            .value =
                                                        id;
                                                    selectedVillageNameofcurrenctadrress
                                                            .value =
                                                        villagecontroller
                                                            .village
                                                            .firstWhere(
                                                              (p) => p.id == id,
                                                            )
                                                            .name!;
                                                  },
                                                );
                                              },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNav(
          title: "ចុះឈ្មោះ",
          onTap: registerUser,
        ),
      ),
    );
  }
}
