class Position {

 double _latitude;
 double _longitude;

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
}