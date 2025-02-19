// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_manager/view_models/auth/cubit/auth_cubit.dart';
// import 'package:task_manager/view_models/auth/repositories/auth_repository.dart';
// import 'package:task_manager/views/auth/login_screen.dart';
// import 'package:task_manager/view_models/tasks/bloc/task_bloc.dart';
// import 'package:task_manager/view_models/tasks/repositories/task_repository.dart';
// import 'package:task_manager/views/tasks/task_screen.dart';

// class AppRoutes {
//   static const String login = '/login';
//   static const String task = '/task';

//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case login:
//         return MaterialPageRoute(
//           builder:
//               (context) => 
//               ),
//         );

//       case task:
//         return MaterialPageRoute(
//           builder:
//               (context) => MultiBlocProvider(
//                 providers: [
//                   BlocProvider(
//                     create: (context) => AuthCubit(AuthRepository()),
//                   ),
                 
//                 ],
//                 child: TaskScreen(),
//               ),
//         );

//       default:
//         return MaterialPageRoute(
//           builder:
//               (context) =>
//                   Scaffold(body: Center(child: Text('Page not found!'))),
//         );
//     }
//   }
// }
