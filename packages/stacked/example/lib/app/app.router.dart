// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

import 'package:stacked/stacked.dart' as _i1;
import '../ui/home/home_view.dart' as _i2;
import '../ui/bottom_nav/bottom_nav_example.dart' as _i3;
import '../ui/stream_view/stream_counter_view.dart' as _i4;
import '../ui/details/details_view.dart' as _i5;
import '../ui/form/example_form_view.dart' as _i6;
import '../ui/nonreactive/nonreactive_view.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i9;
import '../datamodels/clashable_two.dart' as _i10;
import '../datamodels/clashable_one.dart' as _i11;
import '../ui/bottom_nav/favorites/favorites_view.dart' as _i12;
import '../ui/bottom_nav/history/history_view.dart' as _i13;
import '../ui/bottom_nav/profile/profile_view.dart' as _i14;
import '../ui/multiple_futures_example/multiple_futures_example_view.dart'
    as _i15;

class Routes {
  static const homeView = '/';

  static const bottomNavExample = '/bottom-nav-example';

  static const streamCounterView = '/stream-counter-view';

  static const detailsView = '/details-view';

  static const exampleFormView = '/example-form-view';

  static const nonReactiveView = '/non-reactive-view';

  static const all = <String>{
    homeView,
    bottomNavExample,
    streamCounterView,
    detailsView,
    exampleFormView,
    nonReactiveView
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.homeView, page: _i2.HomeView),
    _i1.RouteDef(Routes.bottomNavExample, page: _i3.BottomNavExample),
    _i1.RouteDef(Routes.streamCounterView, page: _i4.StreamCounterView),
    _i1.RouteDef(Routes.detailsView, page: _i5.DetailsView),
    _i1.RouteDef(Routes.exampleFormView, page: _i6.ExampleFormView),
    _i1.RouteDef(Routes.nonReactiveView, page: _i7.NonReactiveView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(
          key: args.key,
          title: args.title,
        ),
        settings: data,
      );
    },
    _i3.BottomNavExample: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const BottomNavExample(),
        settings: data,
      );
    },
    _i4.StreamCounterView: (data) {
      final args = data.getArgs<StreamCounterViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => StreamCounterView(
          key: args.key,
          clashableTwo: args.clashableTwo,
        ),
        settings: data,
      );
    },
    _i5.DetailsView: (data) {
      final args = data.getArgs<DetailsViewArguments>(nullOk: false);
      return _i9.CupertinoPageRoute<Map<String, List<String>>>(
        builder: (context) => DetailsView(
          key: args.key,
          name: args.name,
        ),
        settings: data,
      );
    },
    _i6.ExampleFormView: (data) {
      final args = data.getArgs<ExampleFormViewArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => ExampleFormView(
          key: args.key,
          clashableOne: args.clashableOne,
        ),
        settings: data,
      );
    },
    _i7.NonReactiveView: (data) {
      return _i8.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NonReactiveView(),
        settings: data,
        transitionsBuilder: data.transition ?? CustomRouteTransition.sharedAxis,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({this.key, this.title});

  final _i8.Key? key;

  final String? title;
}

class StreamCounterViewArguments {
  const StreamCounterViewArguments({this.key, required this.clashableTwo});

  final _i8.Key? key;

  final _i10.Clashable clashableTwo;
}

class DetailsViewArguments {
  const DetailsViewArguments({this.key, required this.name});

  final _i8.Key? key;

  final String name;
}

class ExampleFormViewArguments {
  const ExampleFormViewArguments({this.key, required this.clashableOne});

  final _i8.Key? key;

  final _i11.Clashable clashableOne;
}

class BottomNavExampleRoutes {
  static const favoritesView = '/favorites-view';

  static const historyView = '/history-view';

  static const profileView = '/profile-view';

  static const all = <String>{favoritesView, historyView, profileView};
}

class BottomNavExampleRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(BottomNavExampleRoutes.favoritesView,
        page: _i12.FavoritesView),
    _i1.RouteDef(BottomNavExampleRoutes.historyView, page: _i13.HistoryView),
    _i1.RouteDef(BottomNavExampleRoutes.profileView, page: _i14.ProfileView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i12.FavoritesView: (data) {
      final args = data.getArgs<NestedFavoritesViewArguments>(
        orElse: () => NestedFavoritesViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => FavoritesView(
          key: args.key,
          id: args.id,
        ),
        settings: data,
      );
    },
    _i13.HistoryView: (data) {
      return _i8.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    },
    _i14.ProfileView: (data) {
      return _i9.CupertinoPageRoute<dynamic>(
        builder: (context) => const ProfileView(),
        settings: data,
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class NestedFavoritesViewArguments {
  const NestedFavoritesViewArguments({this.key, this.id});

  final _i8.Key? key;

  final String? id;
}

class FavoritesViewRoutes {
  static const multipleFuturesExampleView = '/multiple-futures-example-view';

  static const historyView = '/history-view';

  static const all = <String>{multipleFuturesExampleView, historyView};
}

class FavoritesViewRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(FavoritesViewRoutes.multipleFuturesExampleView,
        page: _i15.MultipleFuturesExampleView),
    _i1.RouteDef(FavoritesViewRoutes.historyView, page: _i13.HistoryView)
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i15.MultipleFuturesExampleView: (data) {
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => const MultipleFuturesExampleView(),
        settings: data,
      );
    },
    _i13.HistoryView: (data) {
      return _i8.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HistoryView(),
        settings: data,
        transitionsBuilder: data.transition ??
            (context, animation, secondaryAnimation, child) {
              return child;
            },
      );
    }
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}
