import 'build_config.dart';
import 'env_config.dart';

enum Environment { development, production }

void env(Environment environment) {
  const String prod = "https://gorest.co.in/public/v2";

  const String dev = "https://gorest.co.in/public/v2";

  EnvConfig config = environment == Environment.production
      ? EnvConfig(
          appName: "GoREST",
          baseUrl: prod,
          shouldCollectCrashLog: true,
        )
      : EnvConfig(
          appName: "GoREST Dev",
          baseUrl: dev,
          shouldCollectCrashLog: true,
        );

  BuildConfig.instantiate(envType: environment, envConfig: config);
}
