# MovieApp

📌 Project Title
Trending Movies Flutter App

A Flutter app that shows a list of trending movies using the TMDB API with clean UI and detailed information for each movie.

🧰 Features
🔥 Trending movies fetched from TMDB API

🔎 Search movies by title

🧭 Infinite scroll / Pagination (if implemented)

🎬 Movie detail screen with:

Poster

Title

Overview

Release Date

Rating

Cast list (horizontal scroll)

Embedded YouTube trailer

⚡ Shimmer loading effect

📱 Responsive UI

📦 Tech Stack
Technology	Usage
Flutter	Cross-platform UI
Dart	Programming language
State Mgmt	Provider / Riverpod / Bloc (mention your choice)
HTTP/Dio	API calls
youtube_player_flutter	Embedded YouTube trailers
shimmer	Loading placeholders

🔌 API Used
The Movie Database (TMDB)

Trending API Endpoint

Make sure to add your API key in the code.

🚀 Getting Started
1. Clone the repo
git clone https://github.com/yourusername/trending-movies-flutter.git
cd trending-movies-flutter
2. Install dependencies
flutter pub get
3. Add your TMDB API key
In lib/constants/api_constants.dart (create this file if needed):
const String apiKey = 'YOUR_API_KEY_HERE';
4. Run the app
flutter run
📂 Project Structure (optional but helpful)
lib/
├── models/
├── screens/
│   ├── home_screen.dart
│   └── movie_detail_screen.dart
├── widgets/
├── services/
├── providers/
└── main.dart


📃 License
This project is licensed under the MIT License.

Let me know if you want help writing the code, setting up the folder structure, or preparing the GitHub repo.
