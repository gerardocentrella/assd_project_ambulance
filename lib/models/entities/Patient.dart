class Patient {

  late String _name;
  late String _surname;
  late String _city;
  late String _address;
  late int _age;

  Patient({required String name, required String surname,
    required String city, required String address, required int age})
  : this._name = name,
    this._surname = surname,
    this._city = city,
    this._address = address,
    this._age = age;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get surname => _surname;

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  set surname(String value) {
    _surname = value;
  }

  @override
  String toString() {
    return 'Patient{_name: $_name, _surname: $_surname, _city: $_city, _address: $_address, _age: $_age}';
  }

  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    city = json['city'];
    address = json['address'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surname;
    data['city'] = city;
    data['address'] = address;
    data['age'] = age;
    return data;
  }

}
