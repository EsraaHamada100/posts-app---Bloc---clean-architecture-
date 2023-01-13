import 'package:equatable/equatable.dart';

class Post extends Equatable{
  int? id;
  String title;
  String body;
  Post({this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];

}