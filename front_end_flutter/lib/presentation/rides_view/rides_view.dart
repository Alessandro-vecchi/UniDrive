import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uni_drive/models/search_model.dart';
import 'package:uni_drive/presentation/rides_view/state/search_rides_cubit.dart';
import 'package:uni_drive/presentation/rides_view/widgets/recap.dart';
import 'package:uni_drive/presentation/rides_view/widgets/ride_card.dart';

class RidesView extends StatelessWidget {
  final SearchModel searchModel;

  const RidesView(this.searchModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: BlocProvider<SearchRidesCubit>(
        create: (context) => SearchRidesCubit()
          ..initForm(searchModel)
          ..searchRides(),
        child: SafeArea(
          child: BlocSelector<SearchRidesCubit, SearchRidesState, FormGroup>(
            selector: (state) => state.form,
            builder: (context, form) {
              form.valueChanges.listen((value) {
                context.read<SearchRidesCubit>().searchRides();
              });
              return ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    const Recap(),
                    BlocBuilder<SearchRidesCubit, SearchRidesState>(
                      builder: (context, state) {
                        return switch (state) {
                          SearchRidesLoading() => const Center(child: CircularProgressIndicator()),
                          SearchRidesLoaded() => Expanded(
                            child: ListView.builder(
                              itemCount: state.rides.length,
                              itemBuilder: (context, index) => RideCard(ride: state.rides[index]),
                            ),
                          ),
                          SearchRidesError() => const Center(child: Text('Error')),
                        };
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
