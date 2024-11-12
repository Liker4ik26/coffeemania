import 'dart:async';

import 'package:coffee_mania/generated/assets.dart';
import 'package:coffee_mania/src/common/widgets/custom_button.dart';
import 'package:coffee_mania/src/common/widgets/custom_icon_button.dart';
import 'package:coffee_mania/src/config/navigation/router/routes.dart';
import 'package:coffee_mania/src/extensions/context_extensions.dart';
import 'package:coffee_mania/src/extensions/widget_extensions.dart';
import 'package:coffee_mania/src/features/coffee_list/provider/coffee_provider.dart';
import 'package:coffee_mania/src/features/coffee_shop_list/provider/coffee_shop_list_provider.dart';
import 'package:coffee_mania/src/features/coffee_shop_map/providers/map_provider.dart';
import 'package:coffee_mania/src/features/coffee_shop_map/view/widgets/point_details_bottom_sheet.dart';
import 'package:coffee_mania/src/map/domain/model/app_lat_long.dart';
import 'package:coffee_mania/src/map/domain/model/map_point.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'coffee_shop_map_screen.g.dart';

@riverpod
Future<List<LocationDomain>> locations(LocationsRef ref) async {
  final repository = ref.watch(coffeeRepositoryProvider);
  final locationsList = await repository.getLocations();
  return locationsList;
}

class CoffeeShopMapScreen extends ConsumerStatefulWidget {
  const CoffeeShopMapScreen({super.key});

  @override
  ConsumerState<CoffeeShopMapScreen> createState() =>
      _CoffeeShopMapScreenState();
}

class _CoffeeShopMapScreenState extends ConsumerState<CoffeeShopMapScreen> {
  late YandexMapController mapController;

  @override
  void initState() {
    super.initState();
    _initPermission();
  }

  List<MapPoint> _getMapPoints(List<LocationDomain> locations) {
    final location = ref.read(currentLocationProvider);
    return [
      ...List.generate(locations.length, (index) {
        return MapPoint(
          name: locations[index].address,
          latitude: locations[index].lat,
          longitude: locations[index].lng,
        );
      }),
      MapPoint(
        name: 'Текущее положение',
        latitude: location.value!.lat,
        longitude: location.value!.long,
        image: Assets.imagesCurrentLocation,
        scale: 0.2,
      ),
    ];
  }

  List<PlacemarkMapObject> _getPlacemarkObjects(
    BuildContext context,
    List<LocationDomain> locations,
  ) {
    return _getMapPoints(locations)
        .map(
          (pointCoffeeShop) => PlacemarkMapObject(
            mapId: MapObjectId('MapObject $pointCoffeeShop'),
            point: Point(
              latitude: pointCoffeeShop.latitude,
              longitude: pointCoffeeShop.longitude,
            ),
            opacity: 1,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                  pointCoffeeShop.image ?? Assets.imagesMapPoint,
                ),
                scale: pointCoffeeShop.scale ?? 0.5,
              ),
            ),
            onTap: (_, point) async {
              showPointDetailsBottomSheet(
                context: context,
                location: pointCoffeeShop,
                onClickSelected: () async {
                  await ref
                      .read(addressNotifierProvider.notifier)
                      .saveAddress(pointCoffeeShop.name);
                  await Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.coffeeListRoute,
                    (route) => false,
                  );
                },
              );
              await _moveToCurrentLocation(
                AppLatLong(
                  lat: point.latitude,
                  long: point.longitude,
                ),
              );
            },
          ),
        )
        .toList();
  }

  Future<void> _initPermission() async {
    final permissionStatus = await ref.read(permissionProvider.future);

    if (!permissionStatus) {
      final locationRepository = ref.read(appLocationRepositoryProvider);
      await locationRepository.requestPermission();
    }
    await _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    AppLatLong location;
    const defLocation = MoscowLocation();

    try {
      location = await ref.read(currentLocationProvider.future);
    } catch (_) {
      location = defLocation;
    }

    await _moveToCurrentLocation(location);
  }

  Future<void> _moveToCurrentLocation(AppLatLong appLatLong) async {
    await mapController.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 2),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          tilt: 200,
          zoom: 600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationsData = ref.watch(locationsProvider);

    if (locationsData is AsyncLoading) {
      return Material(
        color: context.colorsExt.backgroundPrimaryColor,
        child: Center(
          child: CircularProgressIndicator(
            color: context.colorsExt.accentColor,
          ),
        ),
      );
    }

    if (locationsData is AsyncError) {
      return Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationsData.asError.toString()),
            const SizedBox(height: 12),
            CustomButton(
              onPressed: () => ref.refresh(locationsProvider.future),
              title: context.tr.reboot,
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Assets.iconsArrowLeft,
              onPressed: () => Navigator.pop(context),
            ),
            CustomIconButton(
              icon: Assets.iconsMap,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.coffeeShopListRoute,
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final currentLocation = ref.watch(currentLocationProvider);
                return currentLocation.when(
                  data: (location) {
                    return YandexMap(
                      nightModeEnabled: context.mediaQuery.platformBrightness ==
                          Brightness.dark,
                      onMapCreated: (controller) async {
                        mapController = controller;
                        ref
                            .read(mapControllerProvider.notifier)
                            .state
                            .complete(controller);

                        await _moveToCurrentLocation(location);
                      },
                      mapObjects:
                          _getPlacemarkObjects(context, locationsData.value!),
                    );
                  },
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: context.colorsExt.accentColor,
                    ),
                  ),
                  error: (error, stackTrace) => Center(child: Text('$error')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
