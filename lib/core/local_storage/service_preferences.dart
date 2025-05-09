
import 'base_preferences.dart';

const String _storageKey = 'service_';

ServicePreferences servicePreferences = ServicePreferences();

class ServicePreferences extends BasePreferences{
  Future<bool> isOnboarding() async {

    return getBoolApplicationSavedInformation(_storageKey, 'onboarding');
  }
  Future<bool> setOnboarding() async {

    return setBoolApplicationSavedInformation(_storageKey, 'onboarding', true);
  }
}