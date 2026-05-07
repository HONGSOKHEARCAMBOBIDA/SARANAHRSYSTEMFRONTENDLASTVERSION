import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/helper/showcurrencyselector.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeemodel.dart';
import 'package:flutter_application_10/modules/currency/controller/currencycontroller.dart';
import 'package:flutter_application_10/modules/employee/employeecontroller/employeecontroller.dart';
import 'package:flutter_application_10/shared/widgets/customoutlinebutton.dart';
import 'package:flutter_application_10/shared/widgets/dropdown.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:flutter_application_10/shared/widgets/textfield.dart';
import 'package:get/get.dart';

class EditSalaryView extends StatefulWidget {
  final Data employeemodel;
  final int salaryID;

  const EditSalaryView({
    super.key,
    required this.salaryID,
    required this.employeemodel,
  });

  @override
  State<EditSalaryView> createState() => _EditSalaryViewState();
}

class _EditSalaryViewState extends State<EditSalaryView> {
  final Employeecontroller employeeController = Get.find<Employeecontroller>();
  final currencycontroller = Get.put(Currencycontroller());
  final TextEditingController baseSalaryController = TextEditingController();
  final TextEditingController workDayController = TextEditingController();
  final selectcurrencyID = Rxn<int>();
  var selectedcurrencyname = "សូមជ្រេីសរេីសរូបិយប័ណ្ណ".obs;
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    final employee = widget.employeemodel;
    selectcurrencyID.value = employee.currencyId!;
    baseSalaryController.text = employee.baseSalary.toString();
    workDayController.text = employee.workedDay.toString();
    selectedcurrencyname.value = employee.currencyName.toString();
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

    return SizedBox(
         height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.8,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: theme,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20,top: 10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.only(left: 14,right: 14,bottom: 14,top: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: TheColors.orange, width: 0.4),
      
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
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
                   
                      SizedBox(height: 10),
                      Text(
                        "រូបិយប័ណ្ណដែលប្រេី",
                        style: TextStyles.siemreap(context, fontSize: 12),
                      ),
                      const SizedBox(height: 5),
      
                      Obx(
                        () => CustomOutlinedButton(
                          text: selectedcurrencyname.value.isEmpty
                              ? "សូមជ្រេីសរេីសរុបិយប័ណ្ណ"
                              : selectedcurrencyname.value,
                          onPressed: () {
                            showcurrencyselector(
                              context: context,
                              currency: currencycontroller.currency,
                              onSelected: (id) {
                                selectcurrencyID.value = id;
                                selectedcurrencyname.value = currencycontroller
                                    .currency
                                    .firstWhere((p) => p.id == id)
                                    .name!;
                              },
                            );
                          },
                        ),
                      ),
      
                      SizedBox(height: 8),
                      Obx(
                        () => Text.rich(
                          TextSpan(
                            text: "ប្រាក់ខែគោល សូមបំពេញជា ", // normal text
                            style: TextStyles.siemreap(context, fontSize: 12),
                            children: [
                              TextSpan(
                                text: selectedcurrencyname.value, // reactive part
                                style: TextStyles.siemreap(context, fontSize: 12)
                                    .copyWith(
                                      color: const Color.fromARGB(
                                        255,
                                        238,
                                        16,
                                        0,
                                      ), // make it red
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
      
                      const SizedBox(height: 5),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: baseSalaryController,
                        hintText: "300",
                        prefixIcon: Icons.lock_open,
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
                  text: "កែប្រែ",
                  onPressed: () async {
                    // Convert text to int, provide a fallback value if parsing fails
                    final int? baseSalary = int.tryParse(
                      baseSalaryController.text.trim(),
                    );
                    final int? workDays = int.tryParse(
                      workDayController.text.trim(),
                    );
      
                    if (baseSalary == null || workDays == null) {
                      CustomSnackbar.error(
                        title: "មានបញ្ហា",
                        message: "សូមបញ្ចូលលេខត្រឹមត្រូវ",
                      );
                      return;
                    }
      
                    await employeeController.editsalary(
                      currencyID: selectcurrencyID.value!,
                      basesalary: baseSalary,
                      workday: workDays,
                      salaryID: widget.salaryID,
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
