import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_caliana/src/core/utils/constant/app_colors.dart';

class DatePickerWidget {
  static Future<void> show(
    BuildContext context,
    TextEditingController tanggalController,
    VoidCallback validateForm,
  ) async {
    DateTime selectedDate = DateTime.now();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColor.primaryColor,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                ),
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onDateChanged: (date) {
                    selectedDate = date;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text("Batal"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      tanggalController.text =
                          DateFormat("dd MMMM yyyy", "id_ID")
                              .format(selectedDate);
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
      ),
    );
  }
}
