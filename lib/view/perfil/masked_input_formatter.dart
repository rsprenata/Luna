import 'package:flutter/services.dart';

class MaskedInputFormatter extends TextInputFormatter {
  final String mask;
  MaskedInputFormatter(this.mask);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Limpar qualquer caractere não numérico
    text = text.replaceAll(RegExp(r'\D'), '');

    // Aplicar a máscara
    int cursorPos = newValue.selection.baseOffset;

    // O formato que estamos utilizando é (XX) XXXXX-XXXX
    String maskedText = '';
    int i = 0;
    for (int j = 0; j < mask.length; j++) {
      if (mask[j] == '#') {
        if (i < text.length) {
          maskedText += text[i];
          i++;
        }
      } else {
        maskedText += mask[j];
      }
    }

    // Corrigir a posição do cursor
    int newCursorPos = cursorPos;
    if (cursorPos < maskedText.length) {
      newCursorPos = cursorPos + 1;
    }

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
}
