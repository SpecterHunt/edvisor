class Topics {
  final String title;
  final int? id;
  final String? info;
  final String difficulty;
  final String? curDate;
  final String? revDate1;
  final String? revDate2;
  final String? revDate3;
  final String? revDate4;
  final String? revDate5;
  final String? revDate6;
  final String? lastRevised;

  Topics({
    this.id,
    this.curDate,
    required this.difficulty,
    this.info,
    required this.title,
    this.revDate1,
    this.revDate2,
    this.revDate3,
    this.revDate4,
    this.revDate5,
    this.revDate6,
    this.lastRevised,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'info': info,
      'difficulty': difficulty,
      'curDate': curDate,
      'revDate1': revDate1,
      'revDate2': revDate2,
      'revDate3': revDate3,
      'revDate4': revDate4,
      'revDate5': revDate5,
      'revDate6': revDate6,
      'lastRevised': lastRevised,
    };
  }
}
