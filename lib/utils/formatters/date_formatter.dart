import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Foydalanuvchi kiritayotgan yangi qiymat
    String text = newValue.text;

    // Faqat raqamlar va "." belgisi qabul qilinadi
    final regExp = RegExp(r'^[0-9.]*$');
    if (!regExp.hasMatch(text)) {
      return oldValue; // Agar noto‘g‘ri belgi bo‘lsa, eski qiymatni qaytaramiz
    }

    // Faoliyatni formatlash
    String formatted = text
        .replaceAll(RegExp(r'\D'), '') // Faqat raqamlarni saqlash
        .replaceAllMapped(
          RegExp(r'(\d{2})(\d{2})?(\d{4})?'),
          (Match m) =>
              '${m[1]}.${m[2] ?? ''}${m[2] != null && m[3] != null ? '.' : ''}${m[3] ?? ''}',
        );

    // Maksimal uzunlik 10 belgidan oshmaydi (dd.mm.yyyy)
    if (formatted.length > 10) {
      formatted = formatted.substring(0, 10);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
