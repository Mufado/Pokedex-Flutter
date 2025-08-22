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

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pokedex_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```
