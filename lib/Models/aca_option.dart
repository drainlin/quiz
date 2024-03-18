class AcaOption {
  String? _item;
  String? _name;

  AcaOption({String? item, String? name}) {
    if (item != null) {
      this._item = item;
    }
    if (name != null) {
      this._name = name;
    }
  }

  String? get item => _item;
  set item(String? item) => _item = item;
  String? get name => _name;
  set name(String? name) => _name = name;

  AcaOption.fromJson(Map<String, dynamic> json) {
    _item = json['item'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item'] = this._item;
    data['name'] = this._name;
    return data;
  }

}
