import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo( 
        id Integer primary key autoincrement,
        date_hour datetime,
        description varchar(500) not null,
        finished integer
      )
    ''');
  }

  @override
  void update(Batch batch) {}
}
