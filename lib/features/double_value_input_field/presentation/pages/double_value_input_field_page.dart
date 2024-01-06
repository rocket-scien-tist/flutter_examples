import 'package:flutter/material.dart';
import 'package:flutter_examples/features/common/presentation/widgets/app_page_frame.dart';
import 'package:flutter_examples/features/double_value_input_field/presentation/widgets/double_value_input_field.dart';
import 'package:flutter_examples/utils/delete_it/colored_print.dart';

class DoubleValueInputFieldPage extends StatefulWidget {
  const DoubleValueInputFieldPage({super.key});

  @override
  State<DoubleValueInputFieldPage> createState() =>
      _DoubleValueInputFieldPageState();
}

class _DoubleValueInputFieldPageState extends State<DoubleValueInputFieldPage> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: toString(),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 1),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: DoubleValueInputField(
                  controller: controller,
                  onChanged: (v) {
                    coloredPrint('on changed:', v);
                  },
                  suffixText: 'ta',
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
