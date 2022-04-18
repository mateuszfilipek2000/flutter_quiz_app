import 'package:flutter_bloc_quiz_app/core/utils/caesar.dart';
import 'package:flutter_bloc_quiz_app/core/utils/cipher_interface.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Caesar Shift', () {
    test('Decryption test shift 0', () {
      Caesar caesar = Caesar();
      String original =
          "Oittqi maąćż{}b wuvqa lqdqai qv xizbma bzma, ycizcu cviu qvkwtcvb Jmtoim, itqiu Iycqbivq, bmzbqiu, ycq qxawzcu tqvoci Kmtbim, vwabzi Oittq ixxmttivbcz.";

      String encoded = caesar.encode(original, shift: 0);

      expect(original, encoded);
    });

    test('Decryption test shift 1', () {
      Caesar caesar = Caesar();
      String original =
          "Oittqi maąćż{}b wuvqa lqdqai qv xizbma bzma, ycizcu cviu qvkwtcvb Jmtoim, itqiu Iycqbivq, bmzbqiu, ycq qxawzcu tqvoci Kmtbim, vwabzi Oittq ixxmttivbcz.";

      String expected =
          "Ójuurj nąbda{}c xvwrą łrerąj rw yjźcną cźną, zćjźćv ćwjv rwlxućwc Knuójn, jurjv Jzćrcjwr, cnźcrjv, zćr ryąxźćv urwóćj Lnucjn, wxącźj Ójuur jyynuujwcćź.";

      String encoded = caesar.encode(original, shift: 1);

      expect(expected, encoded);
    });

    test('Decryption test shift 10', () {
      Caesar caesar = Caesar();
      String original =
          "Oittqi maąćż{}b wuvqa lqdqai qv xizbma bzma, ycizcu cviu qvkwtcvb Jmtoim, itqiu Iycqbivq, bmzbqiu, ycq qxawzcu tqvoci Kmtbim, vwabzi Oittq ixxmttivbcz.";

      String expected =
          "Wpąązp thilg{}j ćbczh szłzhp zc dpęjth jęth, ekpękb kcpb zcrćąkcj Qtąwpt, pązpb Pekzjpcz, jtęjzpb, ekz zdhćękb ązcwkp Rtąjpt, cćhjęp Wpąąz pddtąąpcjkę.";

      String encoded = caesar.encode(original, shift: 10);

      expect(expected, encoded);
    });

    test('Decryption test shift 1', () {
      Caesar caesar = Caesar();
      String original =
          "Ójuurj nąbda{}c xvwrą łrerąj rw yjźcną cźną, zćjźćv ćwjv rwlxućwc Knuójn, jurjv Jzćrcjwr, cnźcrjv, zćr ryąxźćv urwóćj Lnucjn, wxącźj Ójuur jyynuujwcćź.";

      String expected =
          "Oittqi maąćż{}b wuvqa lqdqai qv xizbma bzma, ycizcu cviu qvkwtcvb Jmtoim, itqiu Iycqbivq, bmzbqiu, ycq qxawzcu tqvoci Kmtbim, vwabzi Oittq ixxmttivbcz.";

      String decoded = caesar.decode(original, shift: 1);

      expect(expected, decoded);
    });

    test('Decryption test shift 10', () {
      Caesar caesar = Caesar();

      String original =
          "Wpąązp thilg{}j ćbczh szłzhp zc dpęjth jęth, ekpękb kcpb zcrćąkcj Qtąwpt, pązpb Pekzjpcz, jtęjzpb, ekz zdhćękb ązcwkp Rtąjpt, cćhjęp Wpąąz pddtąąpcjkę.";

      String expected =
          "Oittqi maąćż{}b wuvqa lqdqai qv xizbma bzma, ycizcu cviu qvkwtcvb Jmtoim, itqiu Iycqbivq, bmzbqiu, ycq qxawzcu tqvoci Kmtbim, vwabzi Oittq ixxmttivbcz.";

      String decoded = caesar.decode(original, shift: 10);

      expect(expected, decoded);
    });
  });

  // test('Decryption test shift 1', () {

  // });
}
