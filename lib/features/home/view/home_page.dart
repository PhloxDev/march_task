import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_task/features/home/blocs/home/home_bloc.dart';
import 'package:march_task/features/home/view/base_widget.dart';
import 'package:march_task/models/badge.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        child: BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeSuccess && !state.isBadgeValid) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('badge assigned to a user')));
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          context.read<HomeBloc>().add(const DataFetched());
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccess) {
          state.listOfUserData
              .removeWhere((element) => element.email == state.userModel.email);

          if (state.listOfUserData.isEmpty) {
            return const Center(
              child: Text('No User'),
            );
          } else {
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: state.listOfUserData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.listOfUserData[index].displayName!),
                        subtitle: Text(state.listOfUserData[index].email!),
                        trailing: DropdownButton<Badge>(
                          items: state.listOfBadge.map((Badge value) {
                            return DropdownMenuItem<Badge>(
                              value: value,
                              child: Text(value.title),
                            );
                          }).toList(),
                          onChanged: (Badge? badge) {
                            context.read<HomeBloc>().add(UserBadgeSelected(
                                userModel: state.listOfUserData[index],
                                selectedBadge: badge));
                          },
                          hint: const Text('select badge'),
                        ),
                      ),
                    );
                  },
                )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    child: const Text('submit'),
                    onPressed: () {
                      context.read<HomeBloc>().add(const BadgeSubmitted());
                    },
                  ),
                )
              ],
            );
          }
        } else if (state is BadgeSubmitSuccess) {
          return const Center(
            child: Text('task completed and not available'),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
