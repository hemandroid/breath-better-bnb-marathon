// import 'dart:convert';
// import 'package:breath_better_bnb_marathon/features/launcher_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   ConsumerState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   final String _googleApiKey = "AIzaSyCFRZ7194KvXP7HaEDTSQr2tNMarpIuWew"; // Replace with your Google API key
//   String _address = "Loading address..."; // Default message
//   Position? _currentPosition; // To store current position (latitude, longitude)
//   TextEditingController _controller = TextEditingController();
//   List<dynamic> _suggestions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation(); // Get current location when the screen is initialized
//   }
//
//   // Function to get the current location (latitude and longitude)
//   Future<void> _getCurrentLocation() async {
//     // Request permission for location access
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       setState(() {
//         _address = "Location permission denied";
//       });
//       return;
//     }
//
//     // Get the current position (latitude, longitude)
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     // Update the current position and address
//     setState(() {
//       _currentPosition = position;
//       _address = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
//     });
//
//     // Now fetch the address using reverse geocoding
//     _getAddressFromCoordinates(position.latitude, position.longitude);
//   }
//
//   // Function to get address from latitude and longitude (reverse geocoding)
//   Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
//     final url =
//         "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_googleApiKey";
//
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['results'].isNotEmpty) {
//           // Get the formatted address from the results
//           final address = data['results'][0]['formatted_address'];
//           setState(() {
//             _address = address; // Update address with the fetched one
//           });
//         } else {
//           setState(() {
//             _address = "No address found for this location";
//           });
//         }
//       } else {
//         setState(() {
//           _address = "Error fetching address: ${response.statusCode}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _address = "Error fetching address: $e";
//       });
//     }
//   }
//
//   // Fetch places based on the search query
//   Future<void> _fetchSuggestions(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _suggestions = [];
//       });
//       return;
//     }
//
//     final url =
//         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_googleApiKey";
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         _suggestions = data['predictions'];
//       });
//     } else {
//       throw Exception('Failed to load suggestions');
//     }
//   }
//
//   // Handle selection of a place suggestion
//   void _selectSuggestion(String placeId) {
//     _getPlaceDetails(placeId);
//     setState(() {
//       _suggestions = []; // Hide suggestions after selection
//       _controller.clear(); // Clear the text field
//     });
//   }
//
//   // Function to get details of the selected place
//   Future<void> _getPlaceDetails(String placeId) async {
//     final url =
//         "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleApiKey";
//
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         final result = data["result"];
//         final address = result["formatted_address"];
//
//         setState(() {
//           _address = address;
//         });
//       } else {
//         setState(() {
//           _address = "Error fetching details: ${response.statusCode}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _address = "Error fetching details: $e";
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     //  bottomNavigationBar: CustomBottomNavigationBar(),
//      // appBar: AppBar(title: const Text("Current Location and Search")),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Search Bar
//               TextField(
//                 controller: _controller,
//                 decoration: const InputDecoration(
//                   labelText: "Search for a place",
//                   border: OutlineInputBorder(),
//                   suffixIcon: Icon(Icons.search),
//                 ),
//                 onChanged: (value) {
//                   _fetchSuggestions(value); // Fetch suggestions as user types
//                 },
//               ),
//               const SizedBox(height: 20),
//
//               // Display suggestions if there are any
//               if (_suggestions.isNotEmpty)
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: _suggestions.length,
//                     itemBuilder: (context, index) {
//                       final suggestion = _suggestions[index];
//                       return ListTile(
//                         title: Text(suggestion['description']),
//                         onTap: () {
//                           _selectSuggestion(suggestion['place_id']);
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               const SizedBox(height: 20),
//
//               // Card view for current address
//               if (_currentPosition != null) ...[
//                 Card(
//                   elevation: 5,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Your Current Address",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "Latitude: ${_currentPosition!.latitude}",
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "Longitude: ${_currentPosition!.longitude}",
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "Address: $_address",
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Add logic to fetch AQI data here
//                     // For example, you can call a method like `_getAQIData()`
//                     // _getAQIData();
//                   },
//                   child: const Text("Know your AQI"),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                     textStyle: const TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }

import 'dart:convert';
import 'package:breath_better_bnb_marathon/core/navigation/navigation_service.dart';
import 'package:breath_better_bnb_marathon/core/routes/route_constants.dart';
import 'package:breath_better_bnb_marathon/features/launcher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// Define the StateProviders for storing current location and address
final currentLocationProvider = StateProvider<Position?>((ref) => null);
final currentAddressProvider = StateProvider<String>((ref) => "Loading address...");

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String _googleApiKey = "AIzaSyCFRZ7194KvXP7HaEDTSQr2tNMarpIuWew"; // Replace with your Google API key
  TextEditingController _controller = TextEditingController();
  List<dynamic> _suggestions = [];

  @override
  void initState() {
    super.initState();
    // If the location is already stored, we don't need to fetch it again.
    if (ref.read(currentLocationProvider) == null) {
      _getCurrentLocation();
    }
  }

  // Function to get the current location (latitude and longitude)
  Future<void> _getCurrentLocation() async {
    // Request permission for location access
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ref.read(currentAddressProvider.notifier).state = "Location permission denied";
      return;
    }

    // Get the current position (latitude, longitude)
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Update the current position and address
    ref.read(currentLocationProvider.notifier).state = position;
    ref.read(currentAddressProvider.notifier).state = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";

    // Now fetch the address using reverse geocoding
    _getAddressFromCoordinates(position.latitude, position.longitude);
  }

  // Function to get address from latitude and longitude (reverse geocoding)
  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$_googleApiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          // Get the formatted address from the results
          final address = data['results'][0]['formatted_address'];
          ref.read(currentAddressProvider.notifier).state = address; // Update address with the fetched one
        } else {
          ref.read(currentAddressProvider.notifier).state = "No address found for this location";
        }
      } else {
        ref.read(currentAddressProvider.notifier).state = "Error fetching address: ${response.statusCode}";
      }
    } catch (e) {
      ref.read(currentAddressProvider.notifier).state = "Error fetching address: $e";
    }
  }

  // Fetch places based on the search query
  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$_googleApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _suggestions = data['predictions'];
      });
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  // Handle selection of a place suggestion
  void _selectSuggestion(String placeId) {
    _getPlaceDetails(placeId);
    setState(() {
      _suggestions = []; // Hide suggestions after selection
      _controller.clear(); // Clear the text field
    });
  }

  // Function to get details of the selected place
  Future<void> _getPlaceDetails(String placeId) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleApiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data["result"];
        final address = result["formatted_address"];

        setState(() {
          ref.read(currentAddressProvider.notifier).state = address;
        });
      } else {
        ref.read(currentAddressProvider.notifier).state = "Error fetching details: ${response.statusCode}";
      }
    } catch (e) {
      ref.read(currentAddressProvider.notifier).state = "Error fetching details: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Read the current location and address from Riverpod providers
    final currentLocation = ref.watch(currentLocationProvider);
    final address = ref.watch(currentAddressProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Search for a place",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  _fetchSuggestions(value); // Fetch suggestions as user types
                },
              ),
              const SizedBox(height: 20),

              // Display suggestions if there are any
              if (_suggestions.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        title: Text(suggestion['description']),
                        onTap: () {
                          _selectSuggestion(suggestion['place_id']);
                        },
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),

              // Card view for current address
              if (currentLocation != null) ...[
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Current Address",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Latitude: ${currentLocation.latitude}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Longitude: ${currentLocation.longitude}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Address: $address",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to fetch AQI data here
                    // For example, you can call a method like `_getAQIData()`
                    // _getAQIData();
                    ref.read(navigationServiceProvider).navigateTo(RouteConstants.precautions);
                  },
                  child: const Text("Know your AQI"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
