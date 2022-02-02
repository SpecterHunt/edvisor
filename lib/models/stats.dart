class Stats {
  final int? id;
  final String curDate;
  final int? newTopics;
  final int? completed;
  final int? pending;

  Stats(
      {this.id,
      required this.curDate,
      this.newTopics,
      this.completed,
      this.pending});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'curDate': curDate,
      'newTopics': newTopics,
      'completed': completed,
      'pending': pending
    };
  }
}
