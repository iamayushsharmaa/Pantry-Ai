# 🥫 Pantry AI

Pantry AI is a mobile app that helps users scan grocery or pantry items and generates recipe suggestions based on ingredients and personal taste preferences using Gemini AI API. It stores user data securely with Firebase and follows Clean Architecture for maintainability.

# 🚀 Features

   📸 Smart Scanning – Capture pantry or grocery items and automatically detect them.
 
   🤖 AI-Powered Recommendations – Get recipe and meal ideas tailored to your taste using Gemini AI.

   📝 Pantry Management – Maintain a digital list of your groceries.

   🔒 User Authentication – Secure login & signup with Firebase Auth.

   ☁️ Cloud Storage & DB – Store user data and pantry items in Firebase Firestore & Storage.

   🎨 Modern UI/UX – Built with Flutter and BLoC for smooth state management.

   🌗 Light & Dark Mode – Seamless theme switching.

# 🏗️ Tech Stack

Layer	Technology
Frontend	Flutter (Dart), BLoC State Management
AI	Gemini AI API
Backend/Cloud	Firebase Auth, Firestore, Firebase Storage
Architecture	Clean Architecture, Repository Pattern
📂 Project Structure
lib/
 ├── features/
 │    ├── pantry/        # Pantry scanning & management
 │    ├── recipes/       # Recipe generation feature
 │    └── auth/          # User authentication
 ├── core/
 │    ├── utils/         # Helpers, constants
 │    └── services/      # API, Firebase services
 ├── main.dart           # Entry point

 
📜 License

MIT License. See LICENSE for details.
