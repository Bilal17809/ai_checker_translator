
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/presentations/ai_translator/controller/ai_translator_controller.dart';
import 'package:ai_checker_translator/presentations/ai_translator/model/language_model.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    final controller = Get.find<LanguageController>();

    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _languageDropdown(
            context: context,
            lang: controller.selectedSource.value,
            onTap:
                () => _showLanguagePicker(
                  context,
                  controller.languages,
                  controller.selectedSource.value,
                  controller.updateSource,
                ),
          ),
          IconButton(
            onPressed: controller.switchLanguages,
            icon: const Icon(Icons.swap_horiz, size: 28),
          ),
          _languageDropdown(
            context: context,
            lang: controller.selectedTarget.value,
            onTap:
                () => _showLanguagePicker(
                  context,
                  controller.languages,
                  controller.selectedTarget.value,
                  controller.updateTarget,
                ),
          ),
        ],
      ),
    );
  }

  Widget _languageDropdown({
    required BuildContext context,
    required LanguageModel lang,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.32,
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
              lang.countryCode.toUpperCase(),
              height: 24,
              width: 24,
            ),
          ),
          Text(
            lang.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: const Icon(Icons.arrow_drop_down, color: Colors.white)),
        ],
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    List<LanguageModel> options,
    LanguageModel selected,
    Function(LanguageModel) onSelected,
  ) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => ListView.builder(
            itemCount: options.length,
            itemBuilder: (_, index) {
              final lang = options[index];
              return ListTile(
                leading: CountryFlag.fromCountryCode(
                  lang.countryCode.toUpperCase(),
                  height: 24,
                  width: 36,
                ),
                title: Text(lang.name),
                selected: selected.countryCode == lang.countryCode,
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