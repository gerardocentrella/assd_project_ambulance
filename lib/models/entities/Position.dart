class Position {

 late double _latitude;
 late double _longitude;

  Position({required double latitude, required double longitude})
  : this._latitude = latitude,
    this._longitude = longitude;

 double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

 @override
  String toString() {
    return 'Position{_latitude: $_latitude, _longitude: $_longitude}';
  }

/*
 Position.fromJson(Map<String, dynamic> json) {
   latitude = json['latitude'] as double;
   longitude = json['longitude'] as double;
 }

 */

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

 Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = <String, dynamic>{};
   data['latitude'] = latitude;
   data['longitude'] = longitude;
   return data;
 }

}