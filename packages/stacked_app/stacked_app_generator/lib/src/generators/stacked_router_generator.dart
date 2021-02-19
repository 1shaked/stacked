import 'package:analyzer/dart/element/element.dart';
import 'package:stacked_app/stacked_app_annotations.dart';
import 'package:stacked_app_generator/import_resolver.dart';
import 'package:stacked_app_generator/route_config_resolver.dart';
import 'package:stacked_app_generator/src/generators/router_class_generator.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

const stackedRouteChecker = TypeChecker.fromRuntime(StackedRoute);

class StackedRouterGenerator extends GeneratorForAnnotation<StackedApp> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    var libs = await buildStep.resolver.libraries.toList();
    var importResolver = ImportResolver(libs, element.source.uri.path);

    var routerResolver = RouterConfigResolver(importResolver);
    final routerConfig = await routerResolver.resolve(annotation, element);

    return RouterClassGenerator(routerConfig).generate();
  }
}
