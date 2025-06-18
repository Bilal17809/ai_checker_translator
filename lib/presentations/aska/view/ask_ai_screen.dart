import 'package:ai_checker_translator/core/common_widgets/assistent_input_box_widget.dart';
import 'package:ai_checker_translator/core/common_widgets/common_appbar_widget.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panara_dialogs/panara_dialogs.dart';


class AskaiScreen extends StatefulWidget {
  const AskaiScreen({super.key});

  @override
  State<AskaiScreen> createState() => _AskaiScreenState();
}

final texteditingcontroller = TextEditingController();

class _AskaiScreenState extends State<AskaiScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        PanaraConfirmDialog.show(
          context,
          title: "Exit App",
          message: "Do you really want to exit the app?",
          confirmButtonText: "Exit",
          cancelButtonText: "No",
          onTapCancel: () {
            Navigator.of(context).pop();
          },
          onTapConfirm: () {
            Navigator.of(context).pop();
            SystemNavigator.pop();
          },
          panaraDialogType: PanaraDialogType.custom,
          color: kMediumGreen2,

          barrierDismissible: false,
        );
      },
      child: Scaffold(
      appBar: CommonAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ask AI (Writing Assistant)",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            AssistantInputBox(
              hintText: "Type here or paste your content",
              controller: texteditingcontroller,
                iconButtons: [],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text.rich(
                TextSpan(
                  text: "Daily Limits Remaining = 10 ",
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text: "Go Premium",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
