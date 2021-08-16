# Movie Tracker With Hive

This Is A Flutter Project That Was Made As An Assignment For The Yellow Class Company.

# Assignment
1. Build A Simple Aesthetic App To Add/edit/delete/list Movies That A User Has Watched.
2. Show An Infinite Scrollable Listview Containing All The Movies That A User Has Created.
3. Implement A Form To Add A New Movie Or Edit An Existing One. (Fields To Keep: Name, Director And A Poster Image Of The Movie)
4. Each List Item Should Have A Delete Icon To Remove That Movie From The List And An Edit Icon To Allow Edit On That Movie.
5. Store The Data In Either Hive Or Sqflite Local Database.

# Prerequisites To Work With This Repository 🐱‍🏍
1. Flutter SDK
2. Android Studio Or Visual Studio Code
3. Dart Plugin
4. Setup Project In The Firebase Console (For Google Sign In)
5. Add Your SHA-Keys To The Firebase App And Obtain google-services.json From Firebase
6. Flutter Doctor Status In The Flutter Console As:

   ![Screenshot 2021-08-16 105906](https://user-images.githubusercontent.com/60723631/129515471-c43a83df-c471-4d9d-ae85-56b8393890cb.png)

# Packages Used 🤖
### **Dependencies**

1. [GetWidget](https://docs.getwidget.dev/getting-started/#installation-guide)
2. [HTTP](https://pub.dev/packages/http)
3. [Hive](https://pub.dev/packages/hive)
4. [Hive Flutter](https://pub.dev/packages/hive_flutter)
5. [Firebase](https://pub.dev/packages/firebase)
6. [Firebase Core](https://pub.dev/packages/firebase_core)
7. [Firebase Auth](https://pub.dev/packages/firebase_auth)
8. [Google Sign In](https://pub.dev/packages/google_sign_in)
9. [Font Awesome Flutter](https://pub.dev/packages/font_awesome_flutter)
10. [URL Launcher](https://pub.dev/packages/url_launcher)
11. [Flutter Toast](https://pub.dev/packages/fluttertoast)

### **Dev Dependencies**
1. [Hive Generator](https://pub.dev/packages/hive_generator)
2. [Build Runner](https://pub.dev/packages/build_runner)

# Implementation 📗

The Application Has A Google Sign In (Which Is Must Before Continuing Any Further) Feature And An Inbuilt Way To Look For The Details Of Any Movie By Using An HTTP Request To An API. From There You Can Grab The Poster Link And See Other Details (Which Can be Added To Hive Local Storage If Needed). Then You Can Go To The Hive Local Storage And Enter The Data Like Name, Poster Link (You Have Copied), Director Name And You Can Add It To Hive. You Can View, Add, Edit Or Delete This Stored Data With The Help Of A Form And With Interactive Buttons. You Can Also Visit The Added Link In The Hive Through Your Web Browser To View The Full Size Of The Poster And Download It With A Click Of A Button.

[Demo Video](https://drive.google.com/file/d/15Gl1jSNGFDIjZLt71kOQdSzO3tM9jxmD/view?usp=sharing)

[APK File](https://drive.google.com/file/d/1PeDno9H1NQNarVH_mB1GkYgTxVUtocU_/view?usp=sharing)

# Screenshots 📱

<p align="center">
<table>
  <tr>
    <td>Home Page</td>
     <td>Movie Search</td>
     <td>Movie List</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/60723631/129518411-0ca28be8-ff72-437a-a6b2-bb5a0d6c1c0d.png" width=100%></td>
    <td><img src="https://user-images.githubusercontent.com/60723631/129520335-06be0f87-4e83-4c09-8879-41e85a7c3fb5.png" width=100%></td>
    <td><img src="https://user-images.githubusercontent.com/60723631/129520123-07a69c57-b567-4a67-a797-1fb76ed07870.png" width=100%></td>
  </tr>
 </table>
</p>

<p align="center">
<table>
  <tr>
    <td>Movie Details</td>
     <td>Adding To Hive</td>
     <td>Hive Local Storage</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/60723631/129520176-3461b915-2b55-45b6-82b1-c02f0bb6b671.png" width=100%></td>
    <td><img src="https://user-images.githubusercontent.com/60723631/129520522-d40525a2-f1a0-46bf-a5a5-9c719168da86.png" width=100%></td>
    <td><img src="https://user-images.githubusercontent.com/60723631/129520579-cb0bd8e3-3097-4d6b-948b-ce9a526eb5ba.png" width=100%></td>
  </tr>
 </table>
</p>
