import 'package:flutter/services.dart';

class CNPJInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove não numéricos
    String formatted = '';

    // Monta o formato do CNPJ dinamicamente
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5) {
        formatted += '.';
      } else if (i == 8) {
        formatted += '/';
      } else if (i == 12) {
        formatted += '-';
      }
      formatted += text[i];
    }

    // Limita o comprimento para o máximo permitido (18 caracteres no formato final)
    if (formatted.length > 18) {
      formatted = formatted.substring(0, 18);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
