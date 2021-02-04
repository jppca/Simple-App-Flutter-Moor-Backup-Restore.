import 'package:app_flutter_moor_backup_restore/provider/database_provider.dart';
import 'package:app_flutter_moor_backup_restore/widgets/new_task_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../database/moor_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Text(
                'Tareas',
              ),
            ),
            Spacer(),
            Container(
              width: 210,
              child: MaterialButton(
                color: Theme.of(context).backgroundColor,
                onPressed: () {
                  Navigator.pushNamed(context, '/backupRestore');
                },
                child: Row(
                  children: [
                    Text(
                      'Backup and Restore ',
                    ),
                    Icon(Icons.restore_page)
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildTaskList(context)),
          NewTaskInput(),
        ],
      ),
    );
  }

  StreamBuilder<List<Task>> _buildTaskList(BuildContext context) {
    final dbNotifier = Provider.of<AppDatabaseNotifier>(context);
    final database = dbNotifier.database;
    return StreamBuilder(
      stream: database.watchAllTasks(),
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        final tasks = snapshot.data ?? List();

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (_, index) {
            final itemTask = tasks[index];
            return _buildListItem(itemTask, database);
          },
        );
      },
    );
  }

  Widget _buildListItem(Task itemTask, AppDatabase database) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Eliminar',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            database.deleteTask(itemTask);
          },
        )
      ],
      child: CheckboxListTile(
        title: Text(itemTask.name),
        subtitle: Text(itemTask.dueDate?.toString() ?? 'Sin fecha de registro'),
        value: itemTask.completed,
        onChanged: (newValue) {
          database.updateTask(itemTask.copyWith(completed: newValue));
        },
      ),
    );
  }
}
