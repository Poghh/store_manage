import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manage/core/DI/di.dart';
import 'package:store_manage/feature/home/presentation/cubit/home_cubit.dart';
import 'package:store_manage/feature/home/presentation/widgets/home_content.dart';
import 'package:store_manage/feature/home/presentation/widgets/home_header.dart';
import 'package:store_manage/feature/home/presentation/widgets/quick_actions_section.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => di<HomeCubit>(),
      child: Scaffold(
        body: SafeArea(child: Column(children: [HomeHeader(), HomeContent(), QuickActionsSection()])),
      ),
    );
  }
}
