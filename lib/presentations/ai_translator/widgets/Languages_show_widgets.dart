
import 'package:ai_checker_translator/presentations/ai_translator/controller/translation_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_flags/country_flags.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';

import '../../../data/models/language_model.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslationController>();

    return Obx(
  () {
      final selectedLang1 = controller.languages.firstWhere(
        (lang) => lang.name == controller.selectedLanguage1.value,
        orElse:
            () => LanguageModel(name: 'English', code: 'en', countryCode: 'US'),
      );
      final selectedLang2 = controller.languages.firstWhere(
        (lang) => lang.name == controller.selectedLanguage2.value,
        orElse:
            () => LanguageModel(name: 'Spanish', code: 'es', countryCode: 'ES'),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _languageDropdown(
            context: context,
            selectedLang: selectedLang1.name,
            onTap: () {
              controller.audioPlayer.stop();
              _showLanguagePicker(
                context,
                controller.languages.map((lang) => lang.name).toList(),
                selectedLang1.name,
                (langName) {
                  controller.selectedLanguage1.value = langName;
                },
                {
                  for (var lang in controller.languages)
                    lang.name: lang.countryCode,
                },
              );
            },
            countryCode: selectedLang1.countryCode,
          ),
          IconButton(
            onPressed: () {
              controller.swapLanguages();
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(Icons.swap_horiz, size: 28),
          ),
          _languageDropdown(
            context: context,
            selectedLang: selectedLang2.name,
            onTap: () {
              controller.audioPlayer.stop();
              _showLanguagePicker(
                context,
                controller.languages.map((lang) => lang.name).toList(),
                selectedLang2.name,
                (langName) {
                  controller.selectedLanguage2.value = langName;
                },
                {
                  for (var lang in controller.languages)
                    lang.name: lang.countryCode,
                },
              );
            },
            countryCode: selectedLang2.countryCode,
          ),
        ],
    );
    });

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
          color: kMintGreen,
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
            SizedBox(width: 04),
            Flexible(
              child: Text(
                selectedLang,
                maxLines: 1,
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

