# weather_app

This Flutter project is a weather app that utilizes the OpenWeatherMap API
to display the current weather for the user's current location as well as
weather information for any city the user searches for.
The app follows the Clean Architecture principles, 
with a modular structure organized into core and feature modules. 
This architecture promotes separation of concerns and allows for easier maintenance, 
scalability, and testability of the codebase.

## Features

- Current Location Weather:
  The app automatically fetches the weather data 
  for the user's current location upon opening the app.

- Search Weather by City:
  Users can search for weather information of any city by entering the city name
  in the search bar.

- Weather Details:
  The app displays relevant weather details, such as temperature,
  weather condition, humidity, wind speed, etc.


## Getting Started

To run the project locally and test the app on your device or emulator, 
follow these steps:

### - Clone the repository:
  Use the following command to clone the repository to your local machine:
  [https://github.com/ahmad-hossi/weather_app.git](https://github.com/ahmad-hossi/weather_app.git)

### - Dependencies installation: 
- Ensure you have Flutter installed on your machine.
- If not, follow the Flutter installation guide:
  [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

- After installing Flutter, navigate to the project root directory and execute
- the following command to get all the required dependencies:
  `flutter pub get `

### - Add your API Key
- The app relies on the OpenWeatherMap API to fetch weather data. 
- To use the API, you need to obtain an API key from OpenWeatherMap. 
- Visit their website [https://openweathermap.org/](https://openweathermap.org/) 
- and sign up to get your API key.
- Once you have obtained your API key, 
- open the _lib/core/constants/app_constant.dart_ 
- file and replace YOUR_API_KEY_HERE with your actual API key.

### - Run the app
- Connect your device or start an emulator,
- then execute the following command to run the app:
- `flutter run`


## - Run the Test
- to run test for this project just execute the following command
- `flutter test`

## - Contributing
- Contributions to the Weather App are welcome and encouraged!
- If you encounter any bugs, have feature requests, or want to improve the app, 
- please consider submitting a pull request. Before making any substantial changes,
- it is recommended to create an issue to discuss the proposed changes
- and ensure they align with the project's goals.