import 'package:stacked_generator/src/generators/base_generator.dart';
import 'package:stacked_generator/src/generators/getit/services_config.dart';

import 'dependency_config/dependency_config.dart';

class StackedLocatorContentGenerator extends BaseGenerator {
  final String locatorName;
  final String locatorSetupName;
  final ServicesConfig servicesConfig;

  StackedLocatorContentGenerator({
    required this.servicesConfig,
    required this.locatorName,
    required this.locatorSetupName,
  });
  @override
  String generate() {
    final services = servicesConfig.services;
    writeLine("// ignore_for_file: public_member_api_docs");

    _generateImports(services);

    newLine();
    writeLine('final $locatorName = StackedLocator.instance;');
    newLine();

    final hasPresolve = services.any((service) => service.hasResolveFunction);

    writeLine(
        '${hasPresolve ? 'Future' : 'void'} $locatorSetupName ({String? environment , EnvironmentFilter? environmentFilter}) ${hasPresolve ? 'async' : ''} {');

    newLine();
    writeLine('// Register environments');

    writeLine(
        '$locatorName.registerEnvironment(environment: environment, environmentFilter: environmentFilter);');

    newLine();
    writeLine('// Register dependencies');

    // Loop through all service definitions and generate the code for it
    for (final serviceDefinition in services) {
      final registrationCodeForType = serviceDefinition.body(locatorName);
      writeLine(registrationCodeForType);
    }

    writeLine('}');

    return stringBuffer.toString();
  }

  void _generateImports(List<DependencyConfig> services) {
    // write route imports
    final imports = <String?>{"package:stacked_core/stacked_core.dart"};

    imports.addAll(services.map((service) => service.import));
    imports.addAll(services.map((service) => service.abstractedImport));

    services.forEach((element) {
      if (element.params != null) {
        element.params!.forEach((im) {
          if (im.imports != null) {
            imports.addAll(im.imports!);
          }
        });
      }
    });

    var validImports =
        imports.where((import) => import != null).toSet().cast<String>();
    var dartImports =
        validImports.where((element) => element.startsWith('dart')).toSet();
    sortAndGenerate(dartImports);
    newLine();

    var packageImports =
        validImports.where((element) => element.startsWith('package')).toSet();
    sortAndGenerate(packageImports);
    newLine();

    var rest = validImports.difference({...dartImports, ...packageImports});
    sortAndGenerate(rest);
  }
}
