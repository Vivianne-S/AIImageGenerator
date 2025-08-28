AIImageGenerator

Turn text prompts into stunning AI-generated images on your iPhone!
AIImageGenerator is a SwiftUI-based iOS app that uses Stability AI to generate images from text prompts. Enter a prompt, generate your image and save it directly to your Photo Library!

Features:
•	Generate images from any text prompt
•	View generated images in a scrollable list
•	Download images directly to your iPhone Photos
•	Beautiful gradient background with modern UI
•	Fast and responsive on real devices


Screenshots:

Main screen with prompt field and Generate button
<img width="1290" height="2796" alt="IMG_2360" src="https://github.com/user-attachments/assets/1eed734b-55ef-43c3-ad3f-6d2660a5c97a" />

Generated image and download button
<img width="1290" height="2796" alt="IMG_2356" src="https://github.com/user-attachments/assets/a09440dc-9a70-4bc0-a6af-c1da5a2b0c33" />
<img width="1024" height="1024" alt="IMG_2357" src="https://github.com/user-attachments/assets/219b6586-a7db-4da8-bc21-f997fe1f8bc5" />
<img width="1024" height="1024" alt="IMG_2358" src="https://github.com/user-attachments/assets/41642b49-960d-48aa-a862-6eff62bd86f1" />
<img width="1290" height="2796" alt="IMG_2359" src="https://github.com/user-attachments/assets/e82550e5-d4d4-4c2e-ab20-a9083cf9f30a" />


Requirements:
	•	Xcode 15.5 or later
	•	iOS 18.0+ (real devices recommended since simulation will lose network connection)
	•	Swift 5.9+
	•	Stability AI account with a valid API key

 Setup:
 	1.	Create a local configuration file Config.xcconfig in the project root: STABILITY_AI_KEY = sk-XXXXXXXXXXXXXXXXXXXXXXXX
	2.	Add this file to .gitignore to prevent committing your API key: Config.xcconfig
 	3.	Reference the key in Info.plist: <key>STABILITY_AI_KEY</key> <string>$(STABILITY_AI_KEY)</string>
  4.	The app automatically fetches the key from Info.plist and Config.xcconfig when running on a real device.

  Usage:
  1.	Enter a text prompt in the input field (e.g., "purple cat").
	2.	Tap Generate Image.
	3.	Wait for the image to be generated and displayed.
	4.	Tap the download icon on the image to save it to Photos.

Project Structure:
	•	Models/ – Contains GeneratedImage and other model classes
	•	ViewModels/ – ImageGeneratorViewModel handles logic and API requests
	•	Views/ – SwiftUI views: ContentView, ImageCardView
	•	Services/ – ImageGeneratorService handles API requests to Stability AI
	•	Resources/ – Assets, Info.plist, and configuration

 Notes:
 	•	Images are generated using Stable Diffusion XL 1024-v1-0
	•	Default image size: 512x512 (adjustable in ImageGeneratorService)
	•	Downloads save images to Photos with user permission
	•	Gradient and UI elements give a modern, visually appealing look

  
