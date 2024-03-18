class AcaQuestion {
  String? _analysis;
  String? _answer;
  double? _difficulty;
  bool? _done;
  int? _hasAuth;
  int? _index;
  int? _markTag;
  String? _option;
  String? _questionId;
  String? _remark;
  String? _reply;
  String? _replyRemark;
  String? _replyTime;
  int? _score;
  String? _subject;
  String? _type;
  String? _updateTime;

  AcaQuestion(
      {String? analysis,
        String? answer,
        double? difficulty,
        bool? done,
        int? hasAuth,
        int? index,
        int? markTag,
        String? option,
        String? questionId,
        String? remark,
        String? reply,
        String? replyRemark,
        String? replyTime,
        int? score,
        String? subject,
        String? type,
        String? updateTime}) {
    if (analysis != null) {
      this._analysis = analysis;
    }
    if (answer != null) {
      this._answer = answer;
    }
    if (difficulty != null) {
      this._difficulty = difficulty;
    }
    if (done != null) {
      this._done = done;
    }
    if (hasAuth != null) {
      this._hasAuth = hasAuth;
    }
    if (index != null) {
      this._index = index;
    }
    if (markTag != null) {
      this._markTag = markTag;
    }
    if (option != null) {
      this._option = option;
    }
    if (questionId != null) {
      this._questionId = questionId;
    }
    if (remark != null) {
      this._remark = remark;
    }
    if (reply != null) {
      this._reply = reply;
    }
    if (replyRemark != null) {
      this._replyRemark = replyRemark;
    }
    if (replyTime != null) {
      this._replyTime = replyTime;
    }
    if (score != null) {
      this._score = score;
    }
    if (subject != null) {
      this._subject = subject;
    }
    if (type != null) {
      this._type = type;
    }
    if (updateTime != null) {
      this._updateTime = updateTime;
    }
  }

  String? get analysis => _analysis;
  set analysis(String? analysis) => _analysis = analysis;
  String? get answer => _answer;
  set answer(String? answer) => _answer = answer;
  double? get difficulty => _difficulty;
  set difficulty(double? difficulty) => _difficulty = difficulty;
  bool? get done => _done;
  set done(bool? done) => _done = done;
  int? get hasAuth => _hasAuth;
  set hasAuth(int? hasAuth) => _hasAuth = hasAuth;
  int? get index => _index;
  set index(int? index) => _index = index;
  int? get markTag => _markTag;
  set markTag(int? markTag) => _markTag = markTag;
  String? get option => _option;
  set option(String? option) => _option = option;
  String? get questionId => _questionId;
  set questionId(String? questionId) => _questionId = questionId;
  String? get remark => _remark;
  set remark(String? remark) => _remark = remark;
  String? get reply => _reply;
  set reply(String? reply) => _reply = reply;
  String? get replyRemark => _replyRemark;
  set replyRemark(String? replyRemark) => _replyRemark = replyRemark;
  String? get replyTime => _replyTime;
  set replyTime(String? replyTime) => _replyTime = replyTime;
  int? get score => _score;
  set score(int? score) => _score = score;
  String? get subject => _subject;
  set subject(String? subject) => _subject = subject;
  String? get type => _type;
  set type(String? type) => _type = type;
  String? get updateTime => _updateTime;
  set updateTime(String? updateTime) => _updateTime = updateTime;

  AcaQuestion.fromJson(Map<String, dynamic> json) {
    _analysis = json['analysis'];
    _answer = json['answer'];
    _difficulty = json['difficulty'];
    _done = json['done'];
    _hasAuth = json['has_auth'];
    _index = json['index'];
    _markTag = json['mark_tag'];
    _option = json['option'];
    _questionId = json['question_id'];
    _remark = json['remark'];
    _reply = json['reply'];
    _replyRemark = json['reply_remark'];
    _replyTime = json['reply_time'];
    _score = json['score'];
    _subject = json['subject'];
    _type = json['type'];
    _updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['analysis'] = this._analysis;
    data['answer'] = this._answer;
    data['difficulty'] = this._difficulty;
    data['done'] = this._done;
    data['has_auth'] = this._hasAuth;
    data['index'] = this._index;
    data['mark_tag'] = this._markTag;
    data['option'] = this._option;
    data['question_id'] = this._questionId;
    data['remark'] = this._remark;
    data['reply'] = this._reply;
    data['reply_remark'] = this._replyRemark;
    data['reply_time'] = this._replyTime;
    data['score'] = this._score;
    data['subject'] = this._subject;
    data['type'] = this._type;
    data['update_time'] = this._updateTime;
    return data;
  }
}
