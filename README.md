# ボタンをグレーアウトにする
Riverpod2.0で状態管理をして、グレーアウトのロジックを実装する
## StateNotifierを使用した状態管理

```dart
import 'package:riverpod/riverpod.dart';

class CheckboxNotifier extends StateNotifier<bool> {
  CheckboxNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}
```

main.dart
```dart
import 'package:button_gray_out/checkbox_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Checkbox Example')),
        body: Center(child: MyCheckboxWidget()),
      ),
    );
  }
}

// プロバイダーで読み込む
final checkboxProvider = StateNotifierProvider<CheckboxNotifier, bool>((ref) {
  return CheckboxNotifier();
});

class MyCheckboxWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkboxProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          // if文で切り替わっているかチェックする.
            // onChangedのところでメソッドを実行する.
          value: isChecked,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              ref.read(checkboxProvider.notifier).toggle();
            }
          },
        ),
        ElevatedButton(
          // 三項演算子で、ボタンのグレーアウトの切り替えをする
          onPressed: isChecked
              ? () {
                  // Perform action when the button is pressed
                  print('ElevatedButton pressed');
                }
              : null,
          child: Text('Press me'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isChecked ? Colors.redAccent : Colors.grey,
          ),
        ),
      ],
    );
  }
}
```

## Notifierを使用した状態管理
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckBoxController extends Notifier<bool> {
  @override
  build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
```

main.dartのコードはわずかしか、変更点がない
```dart
import 'package:button_gray_out/checkbox_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Checkbox Controller')),
        body: Center(child: MyCheckboxWidget()),
      ),
    );
  }
}
// プロバイダーで読み込む
final checkBoxProvider = NotifierProvider<CheckBoxController, bool>(CheckBoxController.new);

class MyCheckboxWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(checkBoxProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? newValue) {
            // if文で切り替わっているかチェックする.
            // onChangedのところでメソッドを実行する.
            if (newValue != null) {
              ref.read(checkBoxProvider.notifier).toggle();
            }
          },
        ),
        ElevatedButton(
          // 三項演算子で、ボタンのグレーアウトの切り替えをする
          onPressed: isChecked
              ? () {
                  // Perform action when the button is pressed
                  print('Notifier toggle!');
                }
              : null,
          child: Text('Tap'),
          style: ElevatedButton.styleFrom(
            backgroundColor: isChecked ? Colors.redAccent : Colors.grey,
          ),
        ),
      ],
    );
  }
}
```

<image src='image/Simulator Screenshot - iPhone 14 - 2023-04-18 at 17.30.55.png' alt='checkbox' width=100px height=200px>
<image src='image/Simulator Screenshot - iPhone 14 - 2023-04-18 at 17.30.59.png' alt='checkbox' width=100px height=200px>