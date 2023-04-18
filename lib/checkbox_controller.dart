import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckBoxController extends Notifier<bool> {
  // Notifierはbuildのreturnの中に、初期値を書く.
  // OFFにするので初期値は、false.
  @override
  build() {
    return false;
  }

  // 状態を持ったメソッドを定義する。等しくなければチェックボックスがONになる.
  // 等しければ、チェックボックスがOFFになる。最初は、OFFの状態.
  void toggle() {
    state = !state;
  }
}
