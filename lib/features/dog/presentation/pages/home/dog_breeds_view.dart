import 'package:auto_route/annotations.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DogBreedView extends StatelessWidget {
  const DogBreedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RemoteDogBloc, RemoteDogState>(
        builder: (context, state) {
          if (state is RemoteDogInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RemoteDogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RemoteDogLoaded) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.data[index].breedName ?? ""),
                );
              },
            );
          } else if (state is RemoteDogError) {
            return Center(
              child: Text(state.message.message ?? "Something went wrong"),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
