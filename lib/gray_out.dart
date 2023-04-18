import 'package:riverpod/riverpod.dart';

class CheckboxNotifier extends StateNotifier<bool> {
  // コンストラクターに初期値を入れる.
  CheckboxNotifier() : super(false);
  // 状態を持ったメソッドを定義する。等しくなければチェックボックスがONになる.
  // 等しければ、チェックボックスがOFFになる。最初は、OFFの状態.
  void toggle() {
    state = !state;
  }
}
