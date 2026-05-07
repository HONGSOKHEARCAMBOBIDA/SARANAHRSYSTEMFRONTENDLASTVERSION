import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/modules/branch/branchcontroller/branchcontroller.dart';
import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/modules/shift/shiftcontroller/shiftcontroller.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class Increasesalaryview extends StatefulWidget {
  final Data employeemodel;
  final int employeeId;
  final int? employeeShiftId;
  final int? salaryID;
  final int? currencyID;

  const Increasesalaryview({
    
    Key? key,
    required this.employeemodel,
    this.currencyID,
    required this.employeeId,
    this.employeeShiftId,
    this.salaryID,
  }) : super(key: key);

  @override
  State<Increasesalaryview> createState() => _IncreasesalaryviewState();
}

class _IncreasesalaryviewState extends State<Increasesalaryview> {
  final currencycontroller = Get.put(Currencycontroller());
  final branchcontroller = Get.find<Branchcontroller>();
  final shiftcontroller = Get.find<Shiftcontroller>();
  final employeecontroller = Get.find<Employeecontroller>();
  final TextEditingController baseSalaryController = TextEditingController();
  final TextEditingController workDayController = TextEditingController();
  final selectbranchid = Rxn<int>();
  final selectshiftid = Rxn<int>();
  final selectcurrencyid = Rxn<int>();
  @override
  void initState() {
    super.initState();
    _initializeData();

  }
  void _initializeData(){
 final employee = widget.employeemodel;
 selectbranchid.value = employee.branchshiftId!;
 selectshiftid.value = employee.shiftId!;
 selectcurrencyid.value = employee.currencyId!;
 baseSalaryController.text = employee.baseSalary!;
 workDayController.text = employee.workedDay!.toString();
 shiftcontroller.shift.clear();
shiftcontroller.fetchshift(selectbranchid.value);
  }
  @override
  void dispose() {
    baseSalaryController.dispose();
    workDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TheColors.bgColor;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          color: theme,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 6),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.only(left: 14,right: 14,top: 8,bottom: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: TheColors.orange, width: 0.4),
                    
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Center(
                      child: Container(
                        width: 50,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "សាខា",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CustomDropdown(
                      selectedValue: selectbranchid,
                      items: branchcontroller.branch,
                      hintText: "រេីសសាខា",
                      onChanged: (value) {
                        selectbranchid.value = value;
                        shiftcontroller.shift.clear();
                        shiftcontroller.fetchshift(selectbranchid.value);
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "វេនការងារ",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CustomDropdown(
                      selectedValue: selectshiftid,
                      items: shiftcontroller.shift,
                      hintText: "វេនការងារ",
                      onChanged: (value) {
                        selectshiftid.value = value;
                      },
                    ),
                    SizedBox(height: 10),
                                        Text(
                      "រូបិយប័ណ្ណដែលប្រេី",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    SizedBox(height: 5,),
                    CustomDropdown(
                      selectedValue: selectcurrencyid, 
                      items: currencycontroller.currency, 
                      hintText: "ឧ ប្រាក់រៀល", 
                      onChanged: (id){
                        selectcurrencyid.value =id;
                      }),
                      SizedBox(height: 5),
                    Text(
                      "ប្រាក់ខែគោល",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: baseSalaryController,
                      hintText: "300",
                      prefixIcon: Icons.attach_money,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "ចំនួនថ្ងៃធ្វើការ",
                      style: TextStyles.siemreap(context, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      controller: workDayController,
                      hintText: "30",
                      prefixIcon: Icons.lock_clock_rounded,
                    ),
                  
                  ],
                ),
              ),
                                    CustomElevatedButton(
                            text: "បញ្ចូន",
                            onPressed: () async {
                              final int? baseSalary = int.tryParse(
                                baseSalaryController.text.trim(),
                              );
                              final int? workDays = int.tryParse(
                                workDayController.text.trim(),
                              );
                
                              if (baseSalary == null || workDays == null) {
                                Get.snackbar("មានបញ្ហា", "សូមបញ្ចូលលេខត្រឹមត្រូវ");
                                return;
                              }
                              if (selectbranchid.value == null ||
                                  selectshiftid.value == null) {
                                Get.snackbar("សូមជ្រើសរើស", "សាខា និង វេនការងារ");
                                return;
                              }
                              if (widget.salaryID == null ||
                                  widget.employeeShiftId == null) {
                                Get.snackbar("មានបញ្ហា", "ទិន្នន័យមិនពេញលេញ");
                                return;
                              }
                
                              await employeecontroller.createemployeeshift(
                                currencyID: selectcurrencyid.value!,
                                employeeid: widget.employeeId,
                                shiftid: selectshiftid.value!,
                                baseSalary: baseSalary,
                                workday: workDays,
                                salaryid: widget.salaryID!,
                                employeeshiftid: widget.employeeShiftId!,
                              );
                              Navigator.pop(context);
                            },
                          ),
            ],
          ),
        ),
      ),
    );
  }
}
