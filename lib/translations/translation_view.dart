import 'package:ai_checker_translator/translations/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_flags/country_flags.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TranslationController translationController = Get.put(TranslationController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Language selection row
              Container(
                height: screenHeight * 0.1,
                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() {
                      return _buildLanguageDropdown(
                        translationController.selectedLanguage1.value,
                            (String? newValue) {
                          translationController.selectedLanguage1.value = newValue!;
                        },
                      );
                    }),
                    SizedBox(width: screenWidth * 0.02),
                    GestureDetector(
                      onTap: () {
                        final temp = translationController.selectedLanguage1.value;
                        translationController.selectedLanguage1.value =
                            translationController.selectedLanguage2.value;
                        translationController.selectedLanguage2.value = temp;
                      },
                      child: Icon(Icons.swap_horiz, color: Colors.blue, size: 30),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Obx(() {
                      return _buildLanguageDropdown(
                        translationController.selectedLanguage2.value,
                            (String? newValue) {
                          translationController.selectedLanguage2.value = newValue!;
                        },
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.02),
                child: Stack(
                  children: [
                    Container(
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Scrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                  ),
                                  child: Obx(() {
                                    final isSourceRTL = translationController
                                        .isRTLLanguage(translationController.selectedLanguage1.value);
                                    return TextField(
                                      controller: translationController.controller,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Type your text here...',
                                        border: OutlineInputBorder(borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: Colors.blue[50],
                                      ),
                                      textAlign: isSourceRTL ? TextAlign.right : TextAlign.left,
                                      textDirection: isSourceRTL ? TextDirection.rtl : TextDirection.ltr,
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    translationController.translate(
                                        translationController.controller.text);
                                    translationController.onTranslateButtonPressed();
                                  },
                                  child: Text("Translate"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    final selectedLanguageCode =
                                        '${translationController.languageCodes[translationController.selectedLanguage1.value]}-US';
                                    translationController.startSpeechToText(selectedLanguageCode);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.mic, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                          right: screenWidth * 0.02,
                        ),
                        child: GestureDetector(
                          onTap: translationController.clearData,
                          child: CircleAvatar(
                            child: Icon(Icons.close, color: Colors.white, size: 20),
                            radius: 11,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (translationController.translatedText.value.isNotEmpty) {
                  final isRTL = translationController.isRTLLanguage(
                      translationController.selectedLanguage2.value);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
                    child: Container(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Align(
                                alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
                                child: Text(
                                  translationController.translatedText.value,
                                  textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.volume_up, color: Colors.white),
                                onPressed: translationController.speakText,
                                tooltip: "Speak text",
                              ),
                              IconButton(
                                icon: Icon(Icons.copy, color: Colors.white),
                                onPressed: translationController.copyText,
                                tooltip: "Copy text",
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outline_outlined, color: Colors.white),
                                onPressed: translationController.clearData,
                                tooltip: "Clear text",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(
      String currentValue, Function(String?) onChanged) {
    return Flexible(
      child: DropdownButton<String>(
        value: currentValue,
        isExpanded: true,
        underline: Container(decoration: BoxDecoration(color: Colors.green)),
        items: translationController.languageCodes.keys.map((String value) {
          final countryCode = translationController.languageFlags[value] ?? 'US';
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                SizedBox(width: 8),
                CountryFlag.fromCountryCode(countryCode, height: 14, width: 14),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
