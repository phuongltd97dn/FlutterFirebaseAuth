import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/profile/profile_cubit.dart';
import '../utils/error_dialog.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    _getProfile();
  }

  void _getProfile() {
    final String uid = context.read<AuthBloc>().state.user?.uid ?? '';
    context.read<ProfileCubit>().getProfile(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ProfileStatus.error) {
            errorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state.profileStatus == ProfileStatus.initial) {
            return const SizedBox.shrink();
          }

          if (state.profileStatus == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.profileStatus == ProfileStatus.error) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/error.png',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Ooops!\nTry again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
                  )
                ],
              ),
            );
          }

          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: state.user.profileImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '-id: ${state.user.id}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '-name ${state.user.name}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '-email ${state.user.email}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '-point ${state.user.point}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        '-rank ${state.user.rank}',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
