import 'package:flutter/services.dart';
import 'dart:math';

class RealInputFormatter extends TextInputFormatter {
  static const maxDigits = 10; // Máximo de dígitos antes do ponto decimal.

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove caracteres não numéricos
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limita a quantidade de dígitos
    if (newText.length > maxDigits) {
      newText = newText.substring(0, maxDigits);
    }

    // Converte o número para o formato monetário
    double value = double.parse(newText) / 100;
    final formatter = RegExp(r'(\d)(?=(\d{3})+(?!\d))'); // Formatação de milhar
    String formattedText = 'R\$ ${value.toStringAsFixed(2).replaceAllMapped(',', (m) => '.').replaceAllMapped('.', (m) => ',').replaceFirstMapped(RegExp(r'(\d+)(\.\d{2})'), (m) {
            return m[1]! + m[2]!;
          })}';

    // Retorna o texto formatado e ajusta a posição do cursor
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
