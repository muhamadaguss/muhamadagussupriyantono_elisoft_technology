import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/dashboard/dashboard_cubit.dart';
import 'cubit/login/login_cubit.dart';

import 'injector_container.dart';

List<BlocProvider> get providers => [
      BlocProvider<LoginCubit>(
        create: (context) => sl<LoginCubit>(),
      ),
      BlocProvider<DashboardCubit>(
        create: (context) => sl<DashboardCubit>(),
      ),
    ];
