import 'package:ai_checker_translator/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:ai_checker_translator/core/theme/app_colors.dart';
import 'package:ai_checker_translator/core/theme/app_styles.dart';
import 'package:ai_checker_translator/core/theme/app_theme.dart';
import 'package:ai_checker_translator/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool isSwitch = false;

 @override
Widget build(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return SafeArea(
    child: Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: height * 0.30,
                        decoration: BoxDecoration(
                          color: kMintGreen.withOpacity(0.6),
                        ),
                      ),
                      Container(
                        height: height * 0.20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, -120),
                              blurRadius: 100,
                              spreadRadius: 70,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _screenbaners(
                              hieht: null,
                              widget: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Learna pro",
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(color: kBlue),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Unlimited interactive practice, personalized study plane, Real-time AI Feedback, Control & Track Your progress.",
                                      style: context.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Free for 3 Days, then 1400.00/week.",
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                              // _screenbaners(
                              //   hieht: null,
                              //   widget: Padding(
                              //     padding:
                              //         const EdgeInsets.symmetric(horizontal: 10),
                              //     child: Row(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         Flexible(
                              //           child: Text(
                              //             "Free Trial Enabled",
                              //             style: context.textTheme.bodyLarge!
                              //                 .copyWith(
                              //               color: kMintGreen,
                              //               fontWeight: FontWeight.bold,
                              //             ),
                              //           ),
                              //         ),
                              //         Switch(
                              //           value: isSwitch,
                              //           onChanged: (value) {
                              //             setState(() {
                              //               isSwitch = value;
                              //             });
                              //           },
                              //           thumbColor:
                              //               MaterialStateProperty.resolveWith<
                              //                   Color>((states) {
                              //             return kMintGreen;
                              //           }),
                              //           trackColor:
                              //               MaterialStateProperty.resolveWith<
                              //                   Color>((states) {
                              //             return states.contains(
                              //                     MaterialState.selected)
                              //                 ? kMintGreen.withOpacity(0.5)
                              //                 : kMintGreen.withOpacity(0.3);
                              //           }),
                              //           focusColor: kMintGreen.withOpacity(0.3),
                              //           splashRadius: 20,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            const SizedBox(height: 14),
                            const _DatesWidget(),
                            const SizedBox(height: 14),
                            ElevatedButton(
                              onPressed: () {},
                              style: AppTheme.elevatedButtonStyle.copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all(kMintGreen),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                elevation: MaterialStateProperty.all(6),
                                shadowColor: MaterialStateProperty.all(
                                    Colors.green.withOpacity(0.4)),
                              ),
                              child: const Text("Free Trial"),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RoutesName.termofusescreen);
                                    },
                                    child: Text(
                                      "Privacy | Terms",
                                      style: TextStyle(color: kBlue),
                                    ),
                                  ),
                                Text("Cancel Anytime"),
                              ],
                            ),
                            const SizedBox(height: 28),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Top buttons
                  Positioned(
                    top: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _glassButton(icon: Icons.clear),
                        _glassButton(text: "Restore", width: 70),
                      ],
                    ),
                  ),

                  // Headings
                  Positioned(
                    top: height * 0.31,
                    left: width * 0.35,
                    child: Text(
                      "Learna pro",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * 0.08,
                    right: width * 0.08,
                    top: height * 0.35,
                    child: Text(
                      "Get Unlimited Access",
                      style: TextStyle(
                        color: kMintGreen,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    left: width * 0.08,
                    right: width * 0.08,
                    top: height * 0.41,
                    child: Text(
                      "Accessible anytime, anywhere for flexible learning.",
                      style: TextStyle(color: kMintGreen, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Image
                  Positioned(
                    top: height * 0.02,
                    left: width * 0.20,
                    right: width * 0.20,
                    child: Image.asset(
                      Assets.premiumscreenpic.path,
                      height: height * 0.34,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}


  Widget _glassButton({IconData? icon, String? text, double width = 30}) {
    return Container(
      height: 34,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.6),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: 18)
            : Text(text ?? "", style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}


class _screenbaners extends StatelessWidget {
  final double? hieht;
  final double width;
  final Widget widget;
  const _screenbaners({
    super.key,
    this.hieht,
    this.width = double.infinity,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: hieht != null
          ? BoxConstraints(minHeight: hieht!)
          : const BoxConstraints(),
      decoration: premiumscreenroundecoration,
      child: widget,
    );
  }
}




class _DatesWidget extends StatelessWidget {
  const _DatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 6),
            CircleAvatar(radius: width * 0.01, backgroundColor: kMintGreen),
            Container(
              width: 2,
              height: height * 0.03,
              color: kMintGreen,
            ),
            CircleAvatar(radius: width * 0.01, backgroundColor: kMintGreen),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Due Today", style: context.textTheme.bodyMedium),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "3 days free  ",
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: kMintGreen),
                        ),
                        TextSpan(
                          text: "0.00",
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Due July 20, 2025",
                      style: context.textTheme.bodyMedium),
                  Text("1400.00",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: kBlue,
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
