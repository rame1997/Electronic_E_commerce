class Question {
  late int id;
  late String questionEn;
  late String questionAr;
  late String answerEn;
  late String answerAr;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionEn = json['question_en'];
    questionAr = json['question_ar'];
    answerEn = json['answer_en'];
    answerAr = json['answer_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_en'] = this.questionEn;
    data['question_ar'] = this.questionAr;
    data['answer_en'] = this.answerEn;
    data['answer_ar'] = this.answerAr;
    return data;
  }
}