import 'cipher_interface.dart';

class Caesar implements CipherInterface {
  // final int shift;

  // Caesar(this.shift);

  static String _newChar(List<String> alphabet, String character,
      {int shift = 1, bool toUpper = false}) {
    int index = alphabet.indexOf(character.toLowerCase()) + shift;
    if (index >= alphabet.length) {
      index -= alphabet.length;
    }

    if (index < 0) {
      index += alphabet.length;
    }

    if (toUpper) {
      return alphabet[index].toUpperCase();
    }
    return alphabet[index];
  }

  @override
  String decode(String code, {int shift = 1}) {
    return encode(code, shift: shift * (-1));
  }

  // @override
  String encode(String code, {int shift = 1}) {
    var alphabet = [
      'a',
      'ą',
      'b',
      'c',
      'ć',
      'd',
      'e',
      'ę',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'ł',
      'm',
      'n',
      'ń',
      'o',
      'ó',
      'p',
      'q',
      'r',
      's',
      'ś',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
      'ź',
      'ż'
    ];
    // StringBuffer result = StringBuffer(code);
    var chars = code.split('');

    for (int i = 0; i < chars.length; i++) {
      chars[i] = alphabet.contains(chars[i])
          ? _newChar(alphabet, chars[i], shift: shift)
          : alphabet.contains(chars[i].toLowerCase())
              ? _newChar(alphabet, chars[i].toLowerCase(),
                  shift: shift, toUpper: true)
              : chars[i];
    }

    return chars.join();
  }

  // static String encode(String code, {int shift = 1}) {
  //   var alphabet = [
  //     'a',
  //     'ą',
  //     'b',
  //     'c',
  //     'ć',
  //     'd',
  //     'e',
  //     'ę',
  //     'f',
  //     'g',
  //     'h',
  //     'i',
  //     'j',
  //     'k',
  //     'l',
  //     'ł',
  //     'm',
  //     'n',
  //     'ń',
  //     'o',
  //     'ó',
  //     'p',
  //     'q',
  //     'r',
  //     's',
  //     'ś',
  //     't',
  //     'u',
  //     'v',
  //     'w',
  //     'x',
  //     'y',
  //     'z',
  //     'ź',
  //     'ż'
  //   ];
  //   // StringBuffer result = StringBuffer(code);
  //   var chars = code.split('');

  //   for (int i = 0; i < chars.length; i++) {
  //     chars[i] = alphabet.contains(chars[i])
  //         ? _newChar(alphabet, chars[i], shift: shift)
  //         : alphabet.contains(chars[i].toLowerCase())
  //             ? _newChar(alphabet, chars[i].toLowerCase(),
  //                 shift: shift, toUpper: true)
  //             : chars[i];
  //   }

  //   return chars.join();
  // }

  // static String decode(String code, {int shift = 1}) {
  //   return encode(code, shift: shift * (-1));
  // }
}
