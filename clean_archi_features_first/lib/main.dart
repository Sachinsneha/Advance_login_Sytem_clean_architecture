import 'package:clean_archi_features_first/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_archi_features_first/core/theme/theme.dart';

import 'package:clean_archi_features_first/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_archi_features_first/features/auth/presentation/pages/singin_page.dart';
import 'package:clean_archi_features_first/features/auth/presentation/pages/singup_page.dart';
import 'package:clean_archi_features_first/init_dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CurrentUserLogedIn());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.darkThememode,
        home: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingUpPage()));
                          },
                          child: Text('Logout')),
                      Text('LoggedIn'),
                    ],
                  ),
                ),
              );
            }
            return const SinginPage();
          },
        ));
  }
}
