import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/partmodel.dart';


class Partcard extends StatelessWidget {
  final Data part;
  final bool isSelected;
  final VoidCallback onTap;

  const Partcard({
    Key? key,
    required this.part,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      child: Card(
      
        color: isSelected
            ? TheColors.secondaryColor.withOpacity(0.2)
            : Colors.white,
      
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: isSelected ? TheColors.warningColor : TheColors.bgColor,width: 0.5)),
        shadowColor: theme.colorScheme.shadow.withOpacity(0.1),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          splashColor: theme.colorScheme.primary.withOpacity(0.1),
          highlightColor: theme.colorScheme.primary.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? TheColors.warningColor
                          : theme.dividerColor,
                      width: 2,
                    ),
                    color: isSelected
                        ? TheColors.primaryColor
                        : Colors.transparent,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 18,
                    color: isSelected ? Colors.white : Colors.transparent,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          part.name ?? 'No Name',
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 12,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                    
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
