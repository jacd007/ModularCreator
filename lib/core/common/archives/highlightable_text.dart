import 'package:flutter/material.dart';

class HighlightableText extends StatelessWidget {
  final String text;
  final List<String> wordsToHighlight;
  final List<String> secondaryWordsToHighlight;
  final List<String> tertiaryWordsToHighlight;
  final List<String> quaternaryWordsToHighlight;
  final TextStyle highlightStyle;
  final TextStyle secondaryHighlightStyle;
  final TextStyle tertiaryHighlightStyle;
  final TextStyle quaternaryHighlightStyle;

  const HighlightableText({
    super.key,
    required this.text,
    required this.wordsToHighlight,
    required this.secondaryWordsToHighlight,
    required this.tertiaryWordsToHighlight, // Asegúrate de incluir este parámetro
    this.quaternaryWordsToHighlight = const ["//", "///", "/*", "*/"],
    this.highlightStyle = const TextStyle(
      color: Color.fromARGB(255, 136, 14, 79),
      fontWeight: FontWeight.bold,
    ),
    this.secondaryHighlightStyle = const TextStyle(
      color: Color.fromARGB(255, 168, 34, 25),
      fontStyle: FontStyle.normal,
    ),
    this.tertiaryHighlightStyle = const TextStyle(
      color: Color.fromARGB(255, 151, 161, 6),
      // decoration: TextDecoration.underline, // Ejemplo de subrayado
    ),
    this.quaternaryHighlightStyle = const TextStyle(
      color: Colors.green, // Color normal para el cuarto estilo
      fontWeight: FontWeight.normal,
    ),
  });

  static List<String> get privateTypes => const [
        'class',
        'final',
        'int',
        'bool',
        'double',
        'String',
        'List',
        'Map',
        'Map<String,dynamic>',
        'Map<String, String>',
        "dynamic",
        'null',
        'required',
        'this',
        'factory',
        'return',
      ];

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        children: _buildHighlightedText(
          text,
          wordsToHighlight,
          secondaryWordsToHighlight,
          tertiaryWordsToHighlight,
          quaternaryWordsToHighlight, // Pasar el nuevo array
          highlightStyle,
          secondaryHighlightStyle,
          tertiaryHighlightStyle,
          quaternaryHighlightStyle, // Pasar el nuevo estilo
        ),
      ),
    );
  }

  static List<InlineSpan> _buildHighlightedText(
    String text,
    List<String> wordsToHighlight,
    List<String> secondaryWordsToHighlight,
    List<String> tertiaryWordsToHighlight,
    List<String> quaternaryWordsToHighlight, // Nuevo parámetro
    TextStyle highlightStyle,
    TextStyle secondaryHighlightStyle,
    TextStyle tertiaryHighlightStyle,
    TextStyle quaternaryHighlightStyle, // Nuevo parámetro
  ) {
    List<InlineSpan> spans = [];

    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      String currentChar = text[i];
      buffer.write(currentChar);

      if (i == text.length - 1 ||
          text[i + 1] == ' ' ||
          text[i + 1] == ',' ||
          text[i + 1] == '.' ||
          text[i + 1] == '(') {
        String word = buffer.toString();

        if (wordsToHighlight.any((highlightWord) {
          bool check = word.contains(highlightWord);
          return check;
        })) {
          spans.add(TextSpan(text: '$word ', style: highlightStyle));
        } else if (secondaryWordsToHighlight.any((highlightWord) {
          bool check = word.contains(highlightWord);
          return check;
        })) {
          spans.add(TextSpan(text: '$word ', style: secondaryHighlightStyle));
        } else if (tertiaryWordsToHighlight.any((highlightWord) {
          bool check = word.contains(highlightWord);
          return check;
        })) {
          spans.add(TextSpan(text: '$word ', style: tertiaryHighlightStyle));
        } else if (quaternaryWordsToHighlight.any((highlightWord) {
          bool check = word.contains(highlightWord);
          return check;
        })) {
          spans.add(TextSpan(text: '$word ', style: quaternaryHighlightStyle));
        } else {
          spans.add(TextSpan(text: '$word '));
        }

        buffer.clear(); // Limpiar el buffer para la siguiente palabra
      }
    }

    return spans;
  }
}
