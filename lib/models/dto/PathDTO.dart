import 'package:assd_project_ambulance/models/entities/Position.dart';

class PathDTO{

    List<Position> _path;

    PathDTO();

    PathDTO(this._path);

    List<Position> get path => _path;

    set path(List<Position> value) {
      _path = value;
    }

    @override
    String toString() {
      return 'PathDTO{_path: $_path}';
    }
}