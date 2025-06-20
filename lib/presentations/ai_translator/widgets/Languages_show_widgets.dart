import 'package:ai_checker_translator/translations/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_flags/country_flags.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslationController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _languageDropdown(
            context: context,
            selectedLang: controller.selectedLanguage1.value,
            onTap: () {
              controller.flutterTts.stop();
              _showLanguagePicker(
                context,
                controller.languageCodes.keys.toList(),
                controller.selectedLanguage1.value,
                (lang) {
                  controller.selectedLanguage1.value = lang;
                },
                controller.languageFlags,
              );
            },
            countryCode:
                controller.languageFlags[controller.selectedLanguage1.value] ??
                'US',
          ),
          IconButton(
            onPressed: () {
              controller.swapLanguages();
              controller.speakText();
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.swap_horiz, size: 28),
          ),
          _languageDropdown(
            context: context,
            selectedLang: controller.selectedLanguage2.value,
            onTap: () {
              controller.flutterTts.stop();
              _showLanguagePicker(
                context,
                controller.languageCodes.keys.toList(),
                controller.selectedLanguage2.value,
                (lang) {
                  controller.selectedLanguage2.value = lang;
                },
                controller.languageFlags,
              );
            },
            countryCode:
                controller.languageFlags[controller.selectedLanguage2.value] ??
                'ES',
          ),
        ],
      ),
    );
  }

  Widget _languageDropdown({
    required BuildContext context,
    required String selectedLang,
    required VoidCallback onTap,
    required String countryCode,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.34,
        decoration: BoxDecoration(
          color: kMediumGreen2,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: CountryFlag.fromCountryCode(
                countryCode.toUpperCase(),
                height: 24,
                width: 24,
              ),
            ),
            Flexible(
              child: Text(
                selectedLang,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    List<String> options,
    String selected,
    Function(String) onSelected,
    Map<String, String> languageFlags,
  ) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => ListView.builder(
            itemCount: options.length,
            itemBuilder: (_, index) {
              final lang = options[index];
              final code = languageFlags[lang] ?? 'US';
              return ListTile(
                leading: CountryFlag.fromCountryCode(
                  code.toUpperCase(),
                  height: 24,
                  width: 36,
                ),
                title: Text(lang),
                selected: lang == selected,
                onTap: () {
                  onSelected(lang);
                  Get.back();
                },
              );
            },
      ),
    );
  }
}
