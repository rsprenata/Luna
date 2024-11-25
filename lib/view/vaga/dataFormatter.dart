import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    // Remove caracteres não numéricos
    text = text.replaceAll(RegExp(r'\D'), '');

    // Formatar o texto no padrão dd/mm/aaaa
    String formattedText = '';
    int selectionIndex = newValue.selection.baseOffset;

    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        formattedText += '/'; // Adiciona a barra
        if (i <= selectionIndex) {
          selectionIndex++; // Ajusta a posição do cursor
        }
      }
      formattedText += text[i];
    }

    // Limitar o tamanho do texto formatado para "dd/mm/aaaa"
    if (formattedText.length > 10) {
      formattedText = formattedText.substring(0, 10);
    }

    // Ajustar a posição do cursor para o comprimento do texto formatado
    selectionIndex = selectionIndex > formattedText.length
        ? formattedText.length
        : selectionIndex;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
