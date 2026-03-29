import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomDatePickerField extends StatelessWidget {
  final String label;
  final Rxn<DateTime> selectedDate;

  const CustomDatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate.value ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2030)
              );
              if (pickedDate != null) {
                selectedDate.value = pickedDate;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: TheColors.orange,width: 0.5,),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate.value != null
                        ? "${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}"
                        : "ថ្ងៃខែឆ្នាំ",
                    style: TextStyles.siemreap(context, fontSize: 12),
                  ),
                  const Icon(
                    Icons.calendar_today,
                    color: TheColors.errorColor,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
