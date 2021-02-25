class halgeri_main {
  final int id;
  final String gubun;
  final String content;
  final String createTime;
  final String editTime;

  halgeri_main({this.id, this.gubun, this.content, this.createTime, this.editTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gubun': gubun,
      'content': content,
      'createTime': createTime,
      'editTime': editTime,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, title: $gubun, text: $content, createTime: $createTime, editTime: $editTime}';
  }
}


class halgeri_sub {
  final int id;
  final int main_id;
  final String content;
  final String createTime;
  final String editTime;

  halgeri_sub({this.id, this.main_id, this.content, this.createTime, this.editTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'main_id': main_id,
      'content': content,
      'createTime': createTime,
      'editTime': editTime,
    };
  }

  // 각 memo 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'Memo{id: $id, title: $main_id, text: $content, createTime: $createTime, editTime: $editTime}';
  }
}
