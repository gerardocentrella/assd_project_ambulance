import 'package:assd_project_ambulance/models/entities/Position.dart';

class PathDTO{

    late List<Position> _path;

    PathDTO(this._path);

    List<Position> get path => _path;

    set path(List<Position> value) {
      _path = value;
    }

    @override
    String toString() {
      return 'PathDTO{_path: $_path}';
    }

    // Metodo fromJson per PathDTO
     PathDTO.fromJson(Map<String, dynamic> json) {
      var pathJson = json['path'] as List;
      List<Position> pathList = pathJson.map((i) => Position.fromJson(i)).toList();
      path = pathList;
    }

    // Metodo toJson per PathDTO
    Map<String, dynamic> toJson() {
      return {
        'path': _path.map((position) => position.toJson()).toList(),
      };
    }
}