import 'package:flutter/material.dart';
import 'package:test_flutter/screens/groups_screen.dart';
import 'package:test_flutter/screens/headquarters_screen.dart';
import 'package:test_flutter/screens/info_groups_creen.dart';
import 'package:test_flutter/screens/institutions_screen.dart';
import '../screens/login_screen.dart';
import '../screens/municipalities_screen.dart';

class AppRoutes {
  static const login = '/';
  static const municipalities = '/municipalities';
  static const institutions = '/institutions';
  static const headquarters = '/headquarters';
  static const groups = '/groups';
  static const infoGroups = '/infoGroups';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginPage(title: 'Inicia sesión'),
      municipalities: (context) => const MunicipalitiesPage(title: 'Municipios'),
      institutions: (context) => const InstitutionsPage(title: 'Instituciones'),
      headquarters: (context) => const HeadquartersPage(title: 'Sedes'),
      groups: (context) => const GroupsPage(title: 'Grupos'),
      infoGroups: (context) => const InfoGroupsPage(title: 'Información'),
    };
  }
}
