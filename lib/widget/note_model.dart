//Model of AuthorData
import 'package:hive_flutter/adapters.dart';

part 'note_model.g.dart';

/// Annotated classes with [HiveType] to generate a `TypeAdapter`.
/// The typeId of the annotated class.
@HiveType(typeId: 0)
class NoteModel {
  /// The index of the Hivefield.
  /// declared variable
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String date;

// Constructor of the modeled data
  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}
