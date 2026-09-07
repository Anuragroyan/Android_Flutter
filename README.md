🤖 Android_Flutter

# Android_Flutter contains Python machine learning model files for Sarcasm Detector, Spam Message Detector, and Social Media Detector. These models are intended for integration with Flutter applications, enabling on-device text classification and AI-powered predictions.

🚀 Android_Flutter

A Flutter project containing Android applications integrated with machine learning models for Sarcasm Detection, Spam Message Detection, and Social Media Detection.

🚀 Getting Started

Follow the steps below to set up and run the project locally.

1. Clone the Repository

git clone <repository-url>
cd Android_Flutter

2. Verify Flutter Installation

Check that Flutter and the required development tools are installed:

flutter doctor

Make sure the Flutter SDK, Android SDK, and Android development tools are properly configured.

3. Install Dependencies

Install all required Flutter packages:

flutter pub get

4. Connect an Android Device

Check the available devices:

flutter devices

Start an Android emulator or connect a physical Android device with USB debugging enabled.

5. Run the Application

Run the Flutter application:

flutter run

To run the application on a specific device:

flutter run -d <device-id>

⸻

🤖 Machine Learning Models

The repository contains Python-based machine learning models for:

* 🤖 Sarcasm Detection
* 📩 Spam Message Detection
* 📱 Social Media Detection

Verify Python Installation

python --version

If the project contains a requirements.txt file, install the required Python dependencies:

pip install -r requirements.txt

⸻

🔄 Application Flow
<img width="1226" height="1283" alt="image" src="https://github.com/user-attachments/assets/856f65d0-d9d4-4d51-90cb-34c1e9c8b9ed" />

⸻

🛠️ Troubleshooting

If you experience Flutter build, dependency, or cache-related issues, run:

flutter clean
flutter pub get
flutter run

📌 Notes

* Replace <repository-url> with the actual GitHub repository URL.
* Replace <device-id> with the ID of your connected Android device.
* Ensure that Flutter, Android SDK, and Python are properly configured before running the project.
