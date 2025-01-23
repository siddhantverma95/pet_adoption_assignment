import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/core/app/app_router.dart';
import 'package:pet_adoption_assignment/core/components/app_snackbar.dart';
import 'package:pet_adoption_assignment/core/config/theme/typography.dart';
import 'package:pet_adoption_assignment/core/logger/app_logger.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/image_interaction.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';
import 'package:pet_adoption_assignment/features/home/presentation/components/confetti_widget.dart';
import 'package:pet_adoption_assignment/features/home/presentation/detail/detail_cubit.dart';
import 'package:pet_adoption_assignment/features/home/presentation/history/history_cubit.dart';
import 'package:pet_adoption_assignment/features/home/presentation/home/home_cubit.dart';

class DetailProvider extends StatelessWidget {
  const DetailProvider({
    required this.pet,
    required this.homeCubit,
    super.key,
  });

  final PetHome pet;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailCubit(
        getHomePetsUsecase: context.read<GetHomePetsUsecase>(),
        storeHomePetsUsecase: context.read<StoreHomePetsUsecase>(),
        pet: pet,
      ),
      child: DetailPage(
        pet: pet,
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({
    required this.pet,
    super.key,
  });

  final PetHome pet;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  bool _confettiVisible = false;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(_animationListener);

    context.read<DetailCubit>().stream.listen(_onAdopted);
    super.initState();
  }

  void _animationListener() {
    if (_animationController.status == AnimationStatus.completed) {
      setState(() {
        _confettiVisible = false;
      });
    }
  }

  void _onAdopted(DetailState state) {
    if (state is DetailSuccess) {
      setState(() {
        _confettiVisible = true;
      });
      _animationController.forward();
      context.read<HistoryCubit>().getAdoptedPets();
      context.read<HomeCubit>().getHomePets();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PetImage(),
                  PetDetails(),
                  AdoptButton(),
                ],
              ),
              Visibility(
                visible: _confettiVisible,
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: ConfettiWidget(
                    controller: _animationController,
                    onLoaded: (composition) {
                      _animationController.duration = composition.duration;
                    },
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: const BackButton(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class PetImage extends StatelessWidget {
  const PetImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pet = context.select(
      (DetailCubit cubit) => cubit.state.pet,
    );
    return Expanded(
      flex: 4,
      child: Hero(
        tag: pet.id,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            imageInteractionRoute,
            arguments: ImageInteraction(
              image: 'assets/images/${pet.breed}.webp',
              name: pet.name,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                colorFilter: pet.adopted
                    ? const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.color,
                      )
                    : null,
                image: AssetImage(
                  'assets/images/${pet.breed}.webp',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PetDetails extends StatelessWidget {
  const PetDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pet = context.select(
      (DetailCubit cubit) => cubit.state.pet,
    );
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: pet.name.h3(),
              subtitle: pet.breed.text14Regular(),
              trailing: '\$${pet.price}'.text16Bold(),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                MetaWidget(
                  label: 'Colour',
                  value: pet.color,
                ),
                MetaWidget(
                  label: 'Type',
                  value: pet.type,
                ),
                MetaWidget(
                  label: 'Age',
                  value: pet.age,
                ),
                MetaWidget(
                  label: 'Vaccinated',
                  value: pet.vaccinated ? 'Yes' : 'No',
                ),
                MetaWidget(
                  label: 'Gender',
                  value: pet.gender,
                ),
                MetaWidget(
                  label: 'Weight',
                  value: pet.weight,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AdoptButton extends StatelessWidget {
  const AdoptButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final pet = context.select(
      (DetailCubit cubit) => cubit.state.pet,
    );
    final isLoading = context.select(
      (DetailCubit cubit) => cubit.state is DetailLoading,
    );
    AppLog.debug('Adopted: ${pet.adopted}');
    final isAdopted = pet.adopted ||
        context.select(
          (DetailCubit cubit) => cubit.state is DetailSuccess,
        );
    return Expanded(
      child: BlocListener<DetailCubit, DetailState>(
        listener: (context, state) {
          if (state is DetailError) {
            AppSnack.error(context, state.message);
          } else if (state is DetailSuccess) {
            AppSnack.success(
              context,
              'Congratulations! You have adopted ${pet.name}',
            );
          }
        },
        child: ElevatedButton(
          onPressed: !isAdopted
              ? () => context.read<DetailCubit>().storeHomePets(pet)
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(
              double.infinity,
              48,
            ),
            backgroundColor: colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: SafeArea(
            top: false,
            child: isLoading
                ? const CircularProgressIndicator()
                : 'Adopt Me'.text16Bold(),
          ),
        ),
      ),
    );
  }
}

class MetaWidget extends StatelessWidget {
  const MetaWidget({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final Object value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, cnst) {
        return Container(
          width: cnst.maxWidth / 3.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: colorScheme.primaryContainer,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              label.text12Regular(
                color: colorScheme.primary,
              ),
              const SizedBox(height: 4),
              value.text14Regular(),
            ],
          ),
        );
      },
    );
  }
}
