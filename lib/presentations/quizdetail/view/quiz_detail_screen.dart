
import 'package:ai_checker_translator/presentations/quizdetail/controller/quiz_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../ads_manager/banner_ads.dart';
import '../../../ads_manager/interstitial_ads.dart';

class QuizDetailScreen extends StatefulWidget {
  final int quizID;
  const QuizDetailScreen({super.key,required this.quizID});

  @override
  State<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {

  final quizdetailcontroller = Get.find<QuizDetailController>();
    late final int quizID;

  @override
  void initState() {
    super.initState();
    quizID = Get.arguments as int;
    quizdetailcontroller.fetchDetails(quizID); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx((){
        if(quizdetailcontroller.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }
        if(quizdetailcontroller.details.isEmpty){
          return Center(child: Text("Model not Found"),);
        }
        return ListView.builder(
          itemCount: quizdetailcontroller.details.length,
          itemBuilder: (context,index){
            final data = quizdetailcontroller.details[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                         Text("QuizDetailID: ${data.quizDeatailID}"),
                         Text("QuizID: ${data.quizID}"),
                         Text("Content: ${data.content}"),
                         Text("Code: ${data.code}")
                  ],
                ),
              ),
            );
          }
          );
      }),
      bottomNavigationBar:
      Get.find<InterstitialAdController>().interstitialAdShown.value
          ? SizedBox()
          : Obx(() {
        return Get.find<BannerAdController>().getBannerAdWidget('ad6');
      }),
    );
  }
}