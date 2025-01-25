import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/core/adaptive/adaptive_builder.dart';
import 'package:pet_adoption_assignment/core/adaptive/screen_type.dart';
import 'package:pet_adoption_assignment/core/app/app_router.dart';
import 'package:pet_adoption_assignment/core/config/theme/typography.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/presentation/history/history_page.dart';
import 'package:pet_adoption_assignment/features/home/presentation/home/home_cubit.dart';
import 'package:pet_adoption_assignment/features/settings/presentation/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    final homeCubit = context.read<HomeCubit>();
    _searchController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        homeCubit.searchPets(_searchController.text);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        context.select((HomeCubit cubit) => cubit.state.index);
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          CustomScrollView(
            slivers: [
              CollapsibleAppBar(controller: _searchController),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return switch (state) {
                    HomeInitial() => const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    HomeSuccess(:final pets) => SliverToBoxAdapter(
                        child: PetGridView(searchedPets: pets),
                      ),
                    HomeError(:final message) => SliverFillRemaining(
                        child: Center(child: Text(message)),
                      ),
                  };
                },
              ),
            ],
          ),
          const HistoryPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => context.read<HomeCubit>().changeIndex(value),
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

class CollapsibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollapsibleAppBar({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: false,
      title: 'Pet Adoption'.h2(),
      elevation: 8,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: SearchBar(controller: controller),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class PetGridView extends StatelessWidget {
  const PetGridView({required this.searchedPets, super.key});
  final List<PetHome> searchedPets;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return GridView.builder(
          padding: const EdgeInsets.only(top: 16),
          shrinkWrap: true,
          itemCount: searchedPets.length,
          physics: const PageScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: sizingInfo.type == ScreenType.desktop
                ? 4
                : sizingInfo.type == ScreenType.tablet
                    ? 3
                    : 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 16,
            childAspectRatio: sizingInfo.type == ScreenType.desktop ? 1.2 : 0.7,
          ),
          itemBuilder: (context, index) {
            final pet = searchedPets[index];
            return PetCard(pet: pet);
          },
        );
      },
    );
  }
}

class PetCard extends StatelessWidget {
  const PetCard({required this.pet, super.key});
  final PetHome pet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        detailRoute,
        arguments: pet,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PetImage(pet: pet),
            PetDetails(pet: pet),
          ],
        ),
      ),
    );
  }
}

class PetImage extends StatelessWidget {
  const PetImage({required this.pet, super.key});
  final PetHome pet;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Hero(
        tag: pet.id,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: AssetImage('assets/images/${pet.breed}.webp'),
              colorFilter: pet.adopted
                  ? const ColorFilter.mode(
                      Colors.grey,
                      BlendMode.color,
                    )
                  : null,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class PetDetails extends StatelessWidget {
  const PetDetails({required this.pet, super.key});
  final PetHome pet;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pet.name.text16Bold(),
            const SizedBox(height: 2),
            pet.breed.text12Regular(),
            const SizedBox(height: 4),
            PetTags(pet: pet),
          ],
        ),
      ),
    );
  }
}

class PetTags extends StatelessWidget {
  const PetTags({required this.pet, super.key});
  final PetHome pet;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        PetTag(text: pet.type, color: cs.primaryContainer),
        const SizedBox(width: 8),
        PetTag(text: pet.gender, color: cs.surfaceContainerHighest),
      ],
    );
  }
}

class PetTag extends StatelessWidget {
  const PetTag({required this.text, required this.color, super.key});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: text.text12Regular(color: cs.primary),
    );
  }
}
