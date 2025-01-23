import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/core/config/theme/typography.dart';
import 'package:pet_adoption_assignment/features/home/presentation/history/history_cubit.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CollapsibleAppBar(),
          BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              return switch (state) {
                HistoryInitial() => const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                HistorySuccess(:final pets) => pets.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final pet = pets[index];
                            return ListTile(
                              title: pet.name.text16Bold(),
                              subtitle: pet.breed.text14Regular(),
                              leading: Image.asset(
                                'assets/images/${pet.breed}.webp',
                              ),
                            );
                          },
                          childCount: pets.length,
                        ),
                      )
                    : SliverFillRemaining(
                        child: Center(
                          child: 'No pets adopted'.h4(),
                        ),
                      ),
                HistoryError(:final message) => SliverFillRemaining(
                    child: Center(
                      child: Text(message),
                    ),
                  ),
              };
            },
          ),
        ],
      ),
    );
  }
}

class CollapsibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollapsibleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: false,
      title: 'History'.h2(),
      elevation: 8,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}
