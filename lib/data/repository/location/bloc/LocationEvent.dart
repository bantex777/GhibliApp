abstract class Locationevent {}

class LoadLocations extends Locationevent {}

class GetLocationDetails extends Locationevent {
  final String id;

  GetLocationDetails(this.id);
}
