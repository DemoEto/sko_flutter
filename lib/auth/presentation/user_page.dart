import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_bloc.dart';
import '../data/repositoryies/user_repository.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc(UserRepository())..add(LoadUser("123")),
      child: Scaffold(
        appBar: AppBar(title: const Text("User Info")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) return const Center(child: CircularProgressIndicator());
            if (state is UserLoaded) return Text(state.data.toString());
            if (state is UserError) return Text(state.message);

            return const Text("Press button to load user");
          },
        ),
      ),
    );
  }
}
