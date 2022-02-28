# TestChatApp

About the test app routing:

1. At the entry point - SceneDelegate calls "AppStarter" custom class;

2. AppStarter - sets rootViewController, by calling SendBirdSDK method based on condition: if User has ID, AppStarter sets MainView, otherwise sets AuthView;
  
3. AuthView - requires to input User ID then calls SendBirdSDK method, that will provide the User as new User or will just login;

4. MainView - calls SendBirdSDK method, which fetches all app channels. 
    - Also, MainView can Create New Channel by setting (optional) other participants of new creating channel. 
    - And finally MainView can push to the MessageView of selected channel;
    
5. MessageView - calls SendBirdSDK method, which fetches all the selected channel's previous messages;

Note: For now the app has little bug - when AppStarter calls SendBirdSDK "initializeWithAppId", sometimes response could fetch error or something else. P.S. If this case will be repeating again, just kill the app and then open it again.
 Had not enough time to find out and fix this buggie :) 
