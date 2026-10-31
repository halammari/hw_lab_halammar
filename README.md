# Arbeit (Lab 07)

Before you build:

1. Open `Arbeit.xcodeproj` in Xcode 16 or newer. Xcode will fetch the
   Firebase package automatically (File > Packages > Resolve if it doesn't).
2. Select the Arbeit target > Signing & Capabilities: pick your Team and set
   the Bundle Identifier (it starts as `com.example.Arbeit`).
3. In the Firebase console, register an iOS app with that exact bundle ID,
   download `GoogleService-Info.plist`, and drop it into the `Arbeit/` folder
   (next to ArbeitApp.swift). The project picks it up automatically.
4. Create the Firestore database (test mode) with a `tasks` collection whose
   documents have: name (string), assignedTo (string), dueDate (timestamp),
   dateAdded (timestamp), completed (boolean).
5. Cmd+R to run, Cmd+U to run the tests.

The app (and the tests, which launch the app) will crash on startup
without GoogleService-Info.plist.
