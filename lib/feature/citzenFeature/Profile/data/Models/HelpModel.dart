import 'package:flutter/material.dart';
import 'package:citifix/generated/l10n.dart'; 

class HelpModel {
  final String question;
  final String answer;
  final String category;

  HelpModel({
    required this.question,
    required this.answer,
    required this.category,
  });

  static List<HelpModel> getHelpContent(BuildContext context) {
    final s = S.of(context);
    return [
      HelpModel(
        category: s.faqCategory,
        question: s.howToReportQuestion,
        answer: s.howToReportAnswer,
      ),
      HelpModel(
        category: s.faqCategory,
        question: s.fixTimeQuestion,
        answer: s.fixTimeAnswer,
      ),

      HelpModel(
        category: s.termsCitizenCategory,
        question: s.citizenResponsibilityTitle,
        answer: s.citizenResponsibilityDesc,
      ),

      HelpModel(
        category: s.termsWorkerCategory,
        question: s.workerConductTitle,
        answer: s.workerConductDesc,
      ),

      HelpModel(
        category: s.legalCategory,
        question: s.privacyPolicyTitle,
        answer: s.privacyPolicyDesc,
      ),
    ];
  }
}
