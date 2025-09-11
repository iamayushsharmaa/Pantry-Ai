🥫 Pantry AI

Pantry AI is a mobile app that helps users scan grocery or pantry items and generates recipe suggestions based on ingredients and personal taste preferences using Gemini AI API. It stores user data securely with Firebase and follows Clean Architecture for maintainability.

🚀 Features

📸 Smart Scanning – Capture pantry or grocery items and automatically detect them.

🤖 AI-Powered Recommendations – Get recipe and meal ideas tailored to your taste using Gemini AI.

📝 Pantry Management – Maintain a digital list of your groceries.

🔒 User Authentication – Secure login & signup with Firebase Auth.

☁️ Cloud Storage & DB – Store user data and pantry items in Firebase Firestore & Storage.

🎨 Modern UI/UX – Built with Flutter and BLoC for smooth state management.

🌗 Light & Dark Mode – Seamless theme switching.

🏗️ Tech Stack
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

⚙️ Setup

Clone the repository

git clone https://github.com/yourusername/pantry-ai.git
cd pantry-ai


Install dependencies

flutter pub get


Configure Firebase

Add your google-services.json (Android) and GoogleService-Info.plist (iOS).

Configure Gemini API

Store your API key securely (e.g., in Firebase Functions or an .env file).

Update the GeminiApiService class with your endpoint if needed.

Run the app

flutter run

🔑 Environment Variables

Create a .env file (or use Firebase Functions for sensitive keys):

GEMINI_API_KEY=your_api_key_here


Never hardcode API keys in your Flutter app; use backend or serverless functions for security.

🧪 Testing

Run unit tests:

flutter test

📸 Screenshots

(Add screenshots or GIFs of your app here)

🤝 Contributing

Fork the repo

Create a feature branch: git checkout -b feature-name

Commit changes: git commit -m "Add new feature"

Push to the branch: git push origin feature-name

Open a Pull Request

📜 License

MIT License. See LICENSE for details.
