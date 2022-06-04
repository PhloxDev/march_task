import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_task/features/home/blocs/admin/admin_bloc.dart';
import 'package:march_task/models/badge.dart';

import 'base_widget.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(child: BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        if (state is AdminInitial) {
          context.read<AdminBloc>().add(const DataFetched());
          return const Center(child: CircularProgressIndicator());
        } else if (state is AdminSuccess) {
          if (state.listOfUserData.isEmpty) {
            return const Center(
              child: Text('No User'),
            );
          } else {
            return Center(
              child: ListView.builder(
                itemCount: state.listOfUserData.length,
                itemBuilder: (BuildContext context, int index) {
                  List<int> badgeIds =
                      state.listOfUserBadge[state.listOfUserData[index].uid] ??
                          [];

                  Map<String, int> badges = <String, int>{};

                  if (badgeIds.isNotEmpty) {
                    for (int badgeId in badgeIds) {
                      Badge? badge = state.listOfBadge
                          .firstWhere((element) => element.id == badgeId);

                      badges[badge.title] = (badges[badge.title] ?? 0) + 1;
                    }
                  }

                  return Card(
                    child: ListTile(
                      title: Text(state.listOfUserData[index].displayName!),
                      subtitle: Wrap(
                        children: badges.keys
                            .map((badge) => Text('$badge-${badges[badge]}   '))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
