# Pokédex App

A Flutter application that provides a comprehensive Pokédex experience using the PokeAPI. This app demonstrates clean architecture principles with a focus on maintainability, testability, and user experience.

## 🏗️ Architecture

This project follows **Clean Architecture** principles with a clear separation of concerns across multiple layers:

### 📁 Project Structure

```
lib/
├── application/          # Application layer (Business Logic)
├── data/                 # Data layer (External interfaces)
│   ├── network/          # API communication
│   │   ├── client/
│   │   ├── dto/          # Data Transfer Objects
│   └── repository/       # Repository pattern implementation
├── domain/               # Domain layer (Core business entities)
│   ├── entity/
│   └── exception/
├── presentation/         # Presentation layer (UI)
│   ├── pages/
│   ├── theme/            # Theme and color palette
│   └── widget/
└── main.dart            
```

## 📦 Dependencies & Their Purpose

### **Core Dependencies**

#### **flutter_bloc**
- State management solution

#### **dio** 
- Modern HTTP client for handling API communication with PokeAPI

#### **json_annotation** + **json_serializable**
  - Helps managing converting JSON data, reducing boilerplate and maintaining type safety

#### **cached_network_image**
- Easy to use, offering a good performance boost

#### **infinite_scroll_pagination**
- Easier way to handle infinite scroll with pagination

#### **google_fonts**
- To receive the font used in the whole application

#### **flutter_lints**
- Code quality and style enforcement

## 🔧 Getting Started

### Testing through Firebase App Tester
1. Get to know how to download applications with Firebase via invites from developers: [Get set up as a tester](https://firebase.google.com/docs/app-distribution/get-set-up-as-a-tester?platform=android)
2. Get the App Testes (if doesn't have it yet) and use this [invite link](https://appdistribution.firebase.google.com/testerapps/1:438322881837:android:2720ffd36c94cd40f65fa4/releases/5lobf6p2ea878?utm_source=firebase-console)
3. Download and install the application.
