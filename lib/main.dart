import 'package:button_gray_out/gray_notifier.dart';
import 'package:button_gray_out/gray_out.dart';
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
