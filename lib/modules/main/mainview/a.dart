import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/role/roleview/roleview.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:get/get.dart';

class a extends GetView<MainController> {
  const a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "អ្នកកាន់ប្រព័ន្ធ"),
      drawer: Drawer(
        width: 250,
        backgroundColor: TheColors.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 82,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: TheColors.yellow, // same as your app theme
                ),
                child: Center(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: TheColors.yellow),
              title: Text(
                'បញ្ជីអ្នកប្រេីប្រាស់',
                style: TextStyles.siemreap(context, fontSize: 12,),
              ),
              onTap: () {
                Get.toNamed('/listuser'); // Navigate to Register page
              },
            ),
          

            ListTile(
              leading: const Icon(
                Icons.person_add,
                color: TheColors.yellow,
              ),
              title: Text(
                'បង្កេីតអ្នកប្រេីប្រាស់',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/register'); // Navigate to Register page
              },
            ),
        
            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: TheColors.yellow,
              ),
              title: Text(
                'តួនាទី',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.to(
                  () => Roleview(),
                  binding: Rolebinding(),
                  transition: Transition.rightToLeft,
                );
              },
            ),
        
            ListTile(
              leading: const Icon(
                Icons.person_2_sharp,
                color: TheColors.yellow,
              ),
              title: Text(
                'បុគ្គលិក',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/listemployee');
              },
            ),
       
            ListTile(
              leading: const Icon(Icons.home_work, color: TheColors.yellow),
              title: Text(
                'សាខា',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/branch');
              },
            ),
         
            ListTile(
              leading: const Icon(
                Icons.lock_clock,
                color: TheColors.yellow,
              ),
              title: Text(
                'វេនធ្វេីការ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/shift');
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: TheColors.yellow,
              ),
              title: Text(
                'រូបិយប័ណ្ណ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/currency');
              },
            ),
          
            ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: TheColors.yellow,
              ),
              title: Text(
                'ប្ដូរូបិយប័ណ្ណ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/currencypair');
              },
            ),
          
            ListTile(
              leading: const Icon(
                Icons.monetization_on,
                color: TheColors.yellow,
              ),
              title: Text(
                'ការប្ដូរប្រាក់',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                Get.toNamed('/exchangrate');
              },
            ),
             Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Divider(
                color: TheColors.orange.withOpacity(0.3),
                thickness: 0.5,
                height: 1,
              ),
            ),
        
            ListTile(
              leading: const Icon(Icons.logout, color: TheColors.red),
              title: Text(
                'ចាកចេញ',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              onTap: () {
                controller.logout();
              },
            ),
           
          ],
        ),
      ),
    );
  }
}