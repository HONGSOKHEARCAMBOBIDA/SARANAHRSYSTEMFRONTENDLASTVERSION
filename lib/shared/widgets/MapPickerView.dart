import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:flutter_application_10/shared/widgets/custombuttonnav.dart';
import 'package:flutter_application_10/shared/widgets/elevated_button.dart';
import 'package:flutter_application_10/shared/widgets/loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapPickerController extends GetxController {
  var latitude = RxnDouble();
  var longitude = RxnDouble();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation(); // ✅ Call once here, not in build()
  }
  Future<void> getCurrentLocation() async {
    isLoading.value = true;

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLoading.value = false;
        Get.snackbar("ការព្រមាន", "សូមអនុញ្ញាតឱ្យកម្មវិធីប្រើទីតាំង។");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      isLoading.value = false;
      Get.snackbar("បដិសេធ", "សូមបើកការអនុញ្ញាតទីតាំងក្នុងការកំណត់។");
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
    isLoading.value = false;
  }
}

class MapPickerView extends StatelessWidget {
  MapPickerView({Key? key}) : super(key: key);

  // Use tag + delete on close to force fresh instance each time
  final controller = Get.put(MapPickerController(), tag: 'mapPicker');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "ជ្រើសទីតាំងសាខា"),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CustomLoading();
          }

          if (controller.latitude.value == null || controller.longitude.value == null) {
            return Text(
              "មិនអាចយកទីតាំងបានទេ",
              style: TextStyles.siemreap(context, fontSize: 12),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Latitude: ${controller.latitude.value}",
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
              Text(
                "Longitude: ${controller.longitude.value}",
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: CustomBottomNav(
        title: "ជ្រើសទីតាំងនេះ",
        onTap: () async{
          final lat = controller.latitude.value;
          final lng = controller.longitude.value;

          // Clean up before going back
          Get.delete<MapPickerController>(tag: 'mapPicker');

          Get.back(result: {'lat': lat, 'lng': lng});
        },
      ),
    );
  }
}
