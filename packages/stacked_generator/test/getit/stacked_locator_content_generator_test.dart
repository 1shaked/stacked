import 'package:stacked_generator/src/generators/enums/dependency_type.dart';
import 'package:stacked_generator/src/generators/exceptions/invalid_generator_input_exception.dart';
import 'package:stacked_generator/src/generators/getit/dependency_config.dart';
import 'package:stacked_generator/src/generators/getit/dependency_param_config.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';
import 'package:stacked_generator/src/generators/getit/stacked_locator_content_generator.dart';
import 'package:test/test.dart';

import '../helpers/getit_constants.dart';

void main() {
  group('StackedLocatorContentGeneratorTest -', () {
    group('generate -', () {
      void callGeneratorWithServicesConfigAndExpectResult(
          ServicesConfig servicesConfig, dynamic expectedResult,
          {String? locatorName, String? locatorSetupName}) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            servicesConfig: servicesConfig,
            locatorName: locatorName ?? 'filledstacksLocator',
            locatorSetupName:
                locatorSetupName ?? 'filledstacksLocatorSetupName');
        expect(stackedLocaterContentGenerator.generate(), expectedResult);
      }

      void callGeneratorWithServicesConfigAndExpectException<T>(
          ServicesConfig servicesConfig,
          [String? exceptionMessage]) {
        final stackedLocaterContentGenerator = StackedLocatorContentGenerator(
            servicesConfig: servicesConfig,
            locatorName: 'filledstacksLocator',
            locatorSetupName: 'filledstacksLocatorSetupName');
        expect(
          () => stackedLocaterContentGenerator.generate(),
          throwsA(predicate<dynamic>((e) => e is T && exceptionMessage == null
              ? true
              : e.message == exceptionMessage)),
        );
      }

      test('with one DependencyConfig ', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              params: {DependencyParamConfig()})
        ]);
        callGeneratorWithServicesConfigAndExpectResult(
            servicesConfig, kStackedLocaterWithOneDependencyOutput,
            locatorName: 'ebraLocator',
            locatorSetupName: 'ebraLocatorSetupName');
      });
      test('with two dependencies', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              params: {DependencyParamConfig()}),
          DependencyConfig(
              import: 'importTwo',
              className: 'FireService',
              params: {DependencyParamConfig()})
        ]);

        callGeneratorWithServicesConfigAndExpectResult(
            servicesConfig, kStackedLocaterWithTwoDependenciesOutput);
      });
      test('with two dependencies and added DependencyParamConfig imports', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              params: {
                DependencyParamConfig(imports: {
                  'importsSetOne',
                  'importsSetTwo',
                })
              }),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(
            servicesConfig, kStackedLocaterWithOneDependencyOutputWithImports);
      });

      test('with one DependencyConfig that has abstractedImport', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedImport: 'abstractedImportOne',
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithAbstractedImport);
      });
      test('with one DependencyConfig that has abstractedTypeClassName', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              abstractedTypeClassName: 'abstractedTypeClassNamee',
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithAbstractedTypeClassName);
      });
      test('with one DependencyConfig that has environments', () {
        final servicesConfig = ServicesConfig(services: [
          DependencyConfig(
              import: 'importOne',
              className: 'GeolocaorService',
              environments: {'dev', 'prod'},
              params: {DependencyParamConfig()}),
        ]);

        callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
            kStackedLocaterWithOneDependencyOutputWithEnviroments);
      });
      group('PresolvedSingleton -', () {
        test(
            'with one DependencyConfig that has presolveFunction and type = DependencyType.PresolvedSingleton',
            () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.PresolvedSingleton,
                import: 'importOne',
                className: 'GeolocaorService',
                presolveFunction: 'staticPresolveFunction',
                params: {DependencyParamConfig()}),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithPresolveFunctionAndDependencyTypePresolvedSingleton);
        });
      });
      group('Factory -', () {
        test(
            'with one DependencyConfig that has presolveFunction and [type=DependencyType.Factory]',
            () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.Factory,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {DependencyParamConfig()}),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactory);
        });
      });
      group('DependencyType.FactoryWithParam -', () {
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params is null
, Should throw a null exception''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
              type: DependencyType.FactoryWithParam,
              import: 'importOne',
              className: 'GeolocaorService',
            ),
          ]);

          callGeneratorWithServicesConfigAndExpectException<TypeError>(
              servicesConfig);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params isempty
, Should throw a InvalidGeneratorInputException''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {}),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty but DependencyParamConfig type is null
, Should throw a InvalidGeneratorInputException''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {DependencyParamConfig()}),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig isFactoryParam=true,
, Should throw a InvalidGeneratorInputException that atleast one [DependencyParamConfig] 
needs to have isFactoryParam needs to be true''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {DependencyParamConfig(type: '')}),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              'At least one paramter is requerd for FactoryWithParam registration ');
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType
, Should throw a InvalidGeneratorInputException that factory needs to be nullable''',
            () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectException<
                  InvalidGeneratorInputException>(servicesConfig,
              "Factory params must be nullable. Parameter null is not nullable");
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType?
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParams);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and default value is shit
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    defaultValueCode: 'shit',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValue);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and isPositional=true
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    isPositional: true,
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsPositionalIsTrue);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and default value is shit and isPositional=true
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    isPositional: true,
                    defaultValueCode: 'shit',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndDefaultValueIsshitAndIsPositionalIsTrue);
        });
        test('''
with one DependencyConfig that has [type=DependencyType.FactoryWithParams] and params
is not empty and DependencyParamConfig type is newType? and name is hello
, Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.FactoryWithParam,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  DependencyParamConfig(
                    type: 'newType?',
                    name: 'hello',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeFactoryWithParamsAndIsNameIsHello);
        });
      });
      group('Singleton -', () {
        test('''
with one DependencyConfig that has [type=DependencyType.Singleton],
 Should ignors all [params] DependencyParamConfig and generate the same code''',
            () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.Singleton,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {
                  // this is ignored in singlton
                  DependencyParamConfig(
                    type: 'newType?',
                    name: 'hello',
                    isFactoryParam: true,
                  ),
                }),
          ]);

          final servicesConfigWithEmptyParams = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.Singleton,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {}),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton);
          callGeneratorWithServicesConfigAndExpectResult(
              servicesConfigWithEmptyParams,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeSinglton);
        });
      });
      group('LazySingleton -', () {
        test('''
with one DependencyConfig that has [type=DependencyType.LazySingleton],
 Should generate code''', () {
          final servicesConfig = ServicesConfig(services: [
            DependencyConfig(
                type: DependencyType.LazySingleton,
                import: 'importOne',
                className: 'GeolocaorService',
                params: {}),
          ]);

          callGeneratorWithServicesConfigAndExpectResult(servicesConfig,
              kStackedLocaterWithOneDependencyOutputWithDependencyTypeLazySinglton);
        });
      });
    });
  });
}
