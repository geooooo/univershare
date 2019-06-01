import 'package:aqueduct/aqueduct.dart';
import 'package:server/src/internal/app_config.dart';

import 'src/managed_context.dart';
import 'src/event_table.dart';
import 'src/presentation_table.dart';
import 'src/user_table.dart';
import 'src/message_table.dart';

class Db {

  final ManagedContext managedContext;

  Db(AppConfig appConfig): managedContext = createManagedContext(appConfig);

  Future<void> createEvent(
      String eventId,
      String eventName,
      String creatorName,
      String presentationUrl,
  ) async {
    final queryCreateUser = Query<UserTable>(managedContext)
      ..values.name = creatorName;
    final newUser = await queryCreateUser.insert();

    final queryCreatePresentation = Query<PresentationTable>(managedContext)
      ..values.url = presentationUrl;
    final newPresentation = await queryCreatePresentation.insert();

    final queryCreateEvent = Query<EventTable>(managedContext)
      ..values.name = eventName
      ..values.id_code = eventId
      ..values.presentation = newPresentation
      ..values.presenter = newUser;
    await queryCreateEvent.insert();
  }

  Future<bool> existsEvent(String eventId) async {
    final querySelectEvent = Query<EventTable>(managedContext)
        ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();
    return event != null;
  }

  Future<Map<String, Object>> getEventInfo(String eventId) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();
    final presentationId = event.presentation.id;

    final querySelectPresentation = Query<PresentationTable>(managedContext)
      ..where((PresentationTable presentation) => presentation.id).equalTo(presentationId);
    final presentation = await querySelectPresentation.fetchOne();

    return <String, Object>{
      'event_name': event.name,
      'presentation_url': presentation.url,
    };
  }

  Future<Map<String, Object>> joinEvent(String eventId, String userName) async {
    final querySelectEvent = Query<EventTable>(managedContext)
      ..where((EventTable event) => event.id_code).equalTo(eventId);
    final event = await querySelectEvent.fetchOne();

    final queryCreateUser = Query<UserTable>(managedContext)
      ..values.name = userName
      ..values.event = event;
    final newUser = await queryCreateUser.insert();

    return <String, Object>{
      'user_id': newUser.id,
    };
  }

//
//  Future<void> createGroup(api_models.Group group, String teamTitle) async {
//    final querySelectTeam = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.title).equalTo(teamTitle);
//    final team = await querySelectTeam.fetchOne();
//    final dashboard = team.dashboard;
//
//    final queryCreateGroup = Query<GroupTable>(managedContext)
//      ..values.title = group.title
//      ..values.dashboard = dashboard;
//    await queryCreateGroup.insert();
//  }
//
//  Future<void> createTask(api_models.Task task, String teamTitle, String groupTitle) async {
//    final querySelectTeam = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.title).equalTo(teamTitle);
//    final team = await querySelectTeam.fetchOne();
//    final dashboardId = team.dashboard.id;
//
//    final querySelectGroup = Query<GroupTable>(managedContext)
//      ..where((GroupTable group) => group.dashboard.id).equalTo(dashboardId)
//      ..where((GroupTable group) => group.title).equalTo(groupTitle);
//    final group = await querySelectGroup.fetchOne();
//
//    final querySelectAccount = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(task.responsibleLogin);
//    final account = await querySelectAccount.fetchOne();
//
//    final queryCreateTask= Query<TaskTable>(managedContext)
//      ..values.title = task.title
//      ..values.description = task.description
//      ..values.priority = task.priority
//      ..values.timePoint = task.timePoint
//      ..values.account = account
//      ..values.group = group;
//    await queryCreateTask.insert();
//  }
//
//  void createTeam(String title, String login) async {
//    final queryCreateDashboard = Query<DashboardTable>(managedContext);
//    final dashboard = await queryCreateDashboard.insert();
//
//    final queryCreateTeam = Query<TeamTable>(managedContext)
//      ..values.title = title
//      ..values.dashboard = dashboard;
//    final team = await queryCreateTeam.insert();
//
//    final querySelectAccount = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(login);
//    final account = await querySelectAccount.fetchOne();
//
//    final queryUpdateAccount = Query<AccountTable>(managedContext)
//      ..where((AccountTable account0) => account0.login).equalTo(account.login)
//      ..values.team = team;
//    await queryUpdateAccount.updateOne();
//  }
//
//  Future<void> deleteAccountFromTeam(String login, String teamTitle) async {
//    final querySelectTeam = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.title).equalTo(teamTitle);
//    final team = await querySelectTeam.fetchOne();
//    final teamId = team.id;
//
//    final queryDeleteFromTeam = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.team.id).equalTo(teamId)
//      ..where((AccountTable account) => account.login).equalTo(login)
//      ..values.team = null;
//    await queryDeleteFromTeam.updateOne();
//  }
//
//  Future<void> deleteGroup(String groupTitle, String teamTitle) async {
//    final querySelectTeam = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.title).equalTo(teamTitle);
//    final team = await querySelectTeam.fetchOne();
//    final dashboardId = team.dashboard.id;
//
//    final queryDeleteGroup = Query<GroupTable>(managedContext)
//      ..where((GroupTable group) => group.dashboard.id).equalTo(dashboardId)
//      ..where((GroupTable group) => group.title).equalTo(groupTitle);
//    await queryDeleteGroup.delete();
//  }
//
//  Future<void> deleteTask(String taskTitle, String groupTitle, String teamTitle) async {
//    final querySelectTeam = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.title).equalTo(teamTitle);
//    final team = await querySelectTeam.fetchOne();
//    final dashboardId = team.dashboard.id;
//
//    final querySelectGroup = Query<GroupTable>(managedContext)
//      ..where((GroupTable group) => group.title).equalTo(groupTitle)
//      ..where((GroupTable group) => group.dashboard.id).equalTo(dashboardId);
//    final group = await querySelectGroup.fetchOne();
//    final groupId = group.id;
//
//    final queryDeleteTask = Query<TaskTable>(managedContext)
//        ..where((TaskTable task) => task.group.id).equalTo(groupId);
//    await queryDeleteTask.delete();
//  }
//
//  Future<bool> existsLogin(String login) async {
//    final query = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(login);
//    final accounts = await query.fetch();
//    return accounts.isNotEmpty;
//  }
//
//  Future<bool> existsTeam(String title) async {
//    final query = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.title).equalTo(title);
//    final teams = await query.fetch();
//    return teams.isNotEmpty;
//  }
//
//  Future<Map<String, Object>> selectDashboard(String login) async {
//    final querySelectAccount = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(login);
//    final account = await querySelectAccount.fetchOne();
//    final teamId = account.team.id;
//
//    final querySelectTeam = Query<TeamTable>(managedContext)
//      ..where((TeamTable team) => team.id).equalTo(teamId);
//    final team = await querySelectTeam.fetchOne();
//    final teamTitle = team.title;
//    final dashboardId = team.dashboard.id;
//
//    final querySelectGroupsFromTeamDashboard = Query<GroupTable>(managedContext)
//      ..where((GroupTable group) => group.dashboard.id).equalTo(dashboardId);
//    final groups = await querySelectGroupsFromTeamDashboard.fetch();
//
//    final groupsResult = <api_models.Group>[];
//    for (var group in groups) {
//      groupsResult.add(api_models.Group()
//        ..title = group.title
//        ..tasks = await _getTasksFromGroup(group.id)
//      );
//    }
//
//    return <String, Object>{
//      'title': teamTitle,
//      'groups': groupsResult,
//    };
//  }
//
//  Future<Map<String, Object>> selectSettings(String login) async {
//    final querySelectAccount = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(login);
//    final account = await querySelectAccount.fetchOne();
//    final teamId = account.team.id;
//
//    final queryAccountsFromOneTeam = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.team.id).equalTo(teamId)
//      ..where((AccountTable account) => account.login).notEqualTo(login);
//    final accounts = await queryAccountsFromOneTeam.fetch();
//
//    return <String, Object>{
//      'logins': accounts.map((AccountTable account) => account.login).toList(),
//    };
//  }
//
//  Future<bool> hasTeam(String login) async {
//    final query = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(login);
//    final account = await query.fetchOne();
//    return account.team != null;
//  }
//
//  Future<bool> checkAccount(String login, String password) async {
//    final query = Query<AccountTable>(managedContext)
//      ..where((AccountTable account) => account.login).equalTo(login)
//      ..where((AccountTable account) => account.password).equalTo(password);
//    final accounts = await query.fetch();
//    return accounts.isNotEmpty;
//  }
//
//  Future<void> createAccount(String login, String password) async {
//    final query = Query<AccountTable>(managedContext)
//      ..values.login = login
//      ..values.password = password;
//    await query.insert();
//  }
//
//  Future<List<api_models.Task>> _getTasksFromGroup(int groupId) async {
//    final querySelectTasksFromGroup = Query<TaskTable>(managedContext)
//      ..where((TaskTable task) => task.group.id).equalTo(groupId);
//    final tasks = await querySelectTasksFromGroup.fetch();
//
//    final tasksResult = <api_models.Task>[];
//    for (var task in tasks) {
//      final querySelectAccount= Query<AccountTable>(managedContext)
//        ..where((AccountTable account) => account.id).equalTo(task.account.id);
//      final account = await querySelectAccount.fetchOne();
//      final responsibleLogin = account.login;
//
//      tasksResult.add(api_models.Task()
//        ..title = task.title
//        ..description = task.description
//        ..priority = task.priority
//        ..timePoint = task.timePoint
//        ..responsibleLogin = responsibleLogin
//      );
//    }
//
//    return tasksResult;
//  }

}
