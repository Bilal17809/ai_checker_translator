import 'package:ai_checker_translator/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/common_widgets/icon_buttons.dart';
import '../../../core/common_widgets/textform_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController messageController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  final List<String> issueTypes = [
    'App Crashing',
    'Ad not working',
    'Content Issue',
    'Slow performance',
    'App Freezing',
    'UI Glitch',
    'Wrong Answer / Misinformation',
    'Audio not working',
    'Payment/Subscription Issue',
    'Other',
  ];

  String? selectedIssue;

  Future<void> _sendReport() async {
    if (!_formKey.currentState!.validate()) return;

    final subject = Uri.encodeComponent('User Report - ${selectedIssue ?? 'Unknown'}');
    final body = Uri.encodeComponent('''
Message: ${messageController.text}

Issue Type: ${selectedIssue ?? 'N/A'}

Details: ${detailController.text}
''');

    final uri = Uri.parse('mailto:unisoftaps@gmail.com?subject=$subject&body=$body');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Report submission initiated. Please complete the email."),
          duration: Duration(seconds: 4),
        ),
      );

      // Optional: Reset form fields
      _formKey.currentState?.reset();
      messageController.clear();
      detailController.clear();
      setState(() => selectedIssue = null);

    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("No Email App Found"),
          content: const Text(
            "No email application is installed on your device. Please install an email app to send the report.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteF7,
      appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BackIconButton(onTap: () {
              Navigator.of(context).pop();
            },),
          ),
          backgroundColor:kMintGreen,
          title:  Text("Report an issue",
            style: context.textTheme.titleLarge?.copyWith(
                color: kWhiteFA
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Let us know what’s wrong. We’ll look into it as soon as possible.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: roundedDecoration,
                padding: EdgeInsets.all(12),
                child: CustomTextFormField(
                  controller: messageController,
                  hintText: 'Enter Name',
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Required' : null,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: roundedDecoration,
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                child: FormField<String>(
                  validator: (value) => value == null ? 'Please select an issue type' : null,
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Select Issue Type'),
                            value: selectedIssue,
                            items: issueTypes.map((issue) {
                              return DropdownMenuItem<String>(
                                value: issue,
                                child: Text(issue),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedIssue = value;
                                state.didChange(value);
                              });
                            },
                          ),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              state.errorText!,
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: roundedDecoration,
                padding: EdgeInsets.all(12),
                child: CustomTextFormField(
                  controller: detailController,
                  hintText: 'Describe the issue',
                  maxLines: 5,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Please provide details' : null,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.09),

              GestureDetector(
                onTap: _sendReport,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color:kMintGreen,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon(Icons.send, color: Colors.white),
                      // SizedBox(width: 8),
                      Text(
                        'Send Report',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
