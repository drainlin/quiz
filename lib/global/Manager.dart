import 'package:shared_preferences/shared_preferences.dart';

enum Mode { normol, favorite }

class Manager {
  static Manager _instance = Manager._();
  List<int> _questionIds = []; // 错题序号
  bool _isRamdom = false; // 是否乱序
  int _currentIndex = 0; // 当前题目序号
  int _currentRandomIndex = 0;
  int _currentFavoriteIndex= 0;
  late Mode _mode;

  Manager._() {
    restoredProperties();
  }

  Mode get mode {
    return _mode;
  }

  set mode(Mode mode) {
    _mode = mode;
  }

  static Manager getInstance() {
    _instance ??= Manager._();
    return _instance;
  }

  int get currentIndex {
    if (mode == Mode.favorite){
      return _currentFavoriteIndex;
    }
    return _isRamdom ? _currentRandomIndex : _currentIndex;
  }

  set currentIndex(int currentIndex) {
    if (mode == Mode.favorite){
      _currentFavoriteIndex = currentIndex;
      return;
    }
    if (_isRamdom) {
      _currentRandomIndex = currentIndex;
      return;
    }
    _currentIndex = currentIndex;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('index', currentIndex);
    });
  }

  bool get isRamdom => _isRamdom;

  set isRamdom(bool isRamdom) {
    _isRamdom = isRamdom;
  }

  List<int> get questionIds => _questionIds;

  set questionIds(List<int> questionIds) {
    _questionIds = questionIds;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList(
          'questionIds', questionIds.map((e) => e.toString()).toList());
    });
  }

  void restoredProperties() {
    SharedPreferences.getInstance().then((prefs) {
      _questionIds = prefs
              .getStringList('questionIds')
              ?.map((e) => int.parse(e))
              .toList() ??
          [];
      _isRamdom = false;
      _currentIndex = prefs.getInt('index') ?? 0;
    });
  }
}
