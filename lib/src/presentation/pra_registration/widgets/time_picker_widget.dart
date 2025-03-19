import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';

class TimePickerWidget {
  static Future<void> show(
    BuildContext context,
    TextEditingController waktuController,
    ValueNotifier<String?> waktuError,
    VoidCallback validateForm,
  ) async {
    DateTime now = DateTime.now();
      DateTime selectedTime =
          DateTime(now.year, now.month, now.day, 9, 0); // Default 09:00

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Time Picker dengan format 24 jam
                  Expanded(
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm,
                      initialTimerDuration: Duration(
                        hours: selectedTime.hour,
                        minutes: selectedTime.minute,
                      ),
                      onTimerDurationChanged: (Duration newTime) {
                        setState(() {
                          selectedTime = DateTime(now.year, now.month, now.day,
                              newTime.inHours, newTime.inMinutes % 60);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Tombol Batal dan Pilih
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text("Batal"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Rentang waktu valid (09:00 - 17:00)
                            const TimeOfDay minTime =
                                TimeOfDay(hour: 9, minute: 0);
                            const TimeOfDay maxTime =
                                TimeOfDay(hour: 17, minute: 0);

                            // Cek apakah waktu berada dalam rentang
                            if (selectedTime.hour < minTime.hour ||
                                (selectedTime.hour == minTime.hour &&
                                    selectedTime.minute < minTime.minute)) {
                              waktuError.value = "Waktu sudah terlewat";
                            } else if (selectedTime.hour > maxTime.hour ||
                                (selectedTime.hour == maxTime.hour &&
                                    selectedTime.minute > maxTime.minute)) {
                              waktuError.value =
                                  "Waktu kunjungan berada di luar rentang waktu yang ditentukan";
                            } else {
                              waktuError.value = null;
                            }

                            // Masukkan waktu ke TextField dan tutup modal
                            waktuController.text =
                                DateFormat("HH:mm").format(selectedTime);
                            validateForm();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text("Pilih"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        },
      );
  }
}
