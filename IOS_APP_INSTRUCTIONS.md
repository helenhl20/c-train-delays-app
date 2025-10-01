# Building the iOS App

## Prerequisites
- Mac with Xcode 15+ installed
- iPhone running iOS 16+
- Free Apple ID (no paid developer account needed!)

## Steps to Install on Your iPhone

### 1. Deploy Flask App to Render First
Before building the iOS app, you need to deploy your Flask backend:
1. Go to [render.com](https://render.com) and sign in with GitHub
2. Create a new Web Service
3. Connect `helenhl20/c-train-delays-app` repository
4. Set build command: `pip install -r requirements.txt`
5. Set start command: `gunicorn app:app`
6. Deploy and copy your URL (e.g., `https://ctrain-delays.onrender.com`)

### 2. Update the iOS App with Your Render URL
1. Open [CTrainStatusManager.swift](Sources/CTrainDelays_VSCode/CTrainStatusManager.swift:9)
2. Replace `"https://YOUR-APP-NAME.onrender.com"` with your actual Render URL
3. Save the file

### 3. Create an Xcode Project
Since this is a Swift Package, you need to create an iOS app project:

1. Open Xcode
2. File → New → Project
3. Select "iOS" → "App"
4. Product Name: `CTrainDelays`
5. Interface: SwiftUI
6. Language: Swift
7. Click Next and choose where to save

### 4. Add the Swift Files to Your Project
1. In Xcode, right-click on the `CTrainDelays` folder in the Project Navigator
2. Select "Add Files to CTrainDelays..."
3. Navigate to `/Users/helenlu/Desktop/CTrainDelays/Sources/CTrainDelays_VSCode/`
4. Select all `.swift` files:
   - CTrainDelaysApp.swift
   - CTrainStatusManager.swift
   - ContentView.swift
5. **Important**: Check "Copy items if needed"
6. Click "Add"

### 5. Update the Main App File
1. Delete the default `CTrainDelaysApp.swift` and `ContentView.swift` that Xcode created
2. The files you added in step 4 will replace them

### 6. Connect Your iPhone
1. Connect your iPhone to your Mac with a USB cable
2. Unlock your iPhone and tap "Trust This Computer" if prompted

### 7. Set Up Signing
1. In Xcode, select your project in the Project Navigator
2. Select the `CTrainDelays` target
3. Go to "Signing & Capabilities" tab
4. Check "Automatically manage signing"
5. Select your Team (your Apple ID)
6. Xcode will create a provisioning profile for you

### 8. Enable Notifications
1. Still in "Signing & Capabilities"
2. Click "+ Capability"
3. Add "Push Notifications" (optional, for future remote notifications)
4. Add "Background Modes"
5. Check "Background fetch" and "Remote notifications"

### 9. Build and Run
1. At the top of Xcode, select your iPhone as the destination (not a simulator)
2. Click the Play button (▶) or press Cmd+R
3. The app will build and install on your iPhone

### 10. Trust the Developer Certificate
First time only:
1. On your iPhone, go to Settings → General → VPN & Device Management
2. Find your Apple ID under "Developer App"
3. Tap it and tap "Trust"
4. Now you can open the app!

### 11. Allow Notifications
When you first open the app, it will ask for notification permission:
1. Tap "Allow"
2. Now you'll get notifications when the C Train is delayed!

## How It Works

- **On Launch**: App checks the C Train status immediately
- **Refresh Button**: Manually check for updates anytime
- **Notifications**: When status changes to "Delayed" or "Alert", you'll get a notification
- **Background**: iOS will periodically refresh the app in the background

## Troubleshooting

**App expires after 7 days**:
- With a free Apple ID, you need to rebuild and reinstall every 7 days
- Just connect your phone and hit Run again in Xcode

**Build errors**:
- Make sure you're using Xcode 15+ and iOS 16+
- Clean build folder: Product → Clean Build Folder
- Restart Xcode

**Notifications not working**:
- Check Settings → CTrainDelays → Notifications are enabled
- Make sure you allowed notifications when first opening the app

**Can't find deployment button**:
- Make sure you selected your physical iPhone, not a simulator
- Your iPhone needs to be unlocked and connected

## Updating the App

After deploying Flask to Render:
1. Update the URL in [CTrainStatusManager.swift](Sources/CTrainDelays_VSCode/CTrainStatusManager.swift:9)
2. In Xcode, click the Play button again
3. The updated app will install on your phone
