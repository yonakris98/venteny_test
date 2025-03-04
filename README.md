# Task Management App

## How to Run the Application

1. **Install APK / Run the Project**

   - Install the provided APK file on your device.
   - Or, to run from the project source, use the following command in the terminal:
     ```bash
     flutter run
     ```

2. **If running from the project**, execute the following command before starting the application:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Login Information**

   - Use the following credentials to log in:
     - **Email:** [eve.holt@reqres.in](mailto\:eve.holt@reqres.in)
     - **Password:** cityslicka

## Features

1. **Add Task Item**

   - Open the hamburger icon on the top-left corner.
   - Tap the "Add Item" button to create a new task.

2. **Dark Mode**

   - Open the hamburger icon on the top-left corner.
   - Tap the theme switch button to toggle between light and dark mode.

3. **Search Tasks**

   - Enter the task name (displayed in bold) in the search bar to find specific tasks.

4. **Filter Tasks**

   - Tap the filter icon on the top-right corner.
   - Select the task status to filter tasks accordingly.

5. **Delete Task**

   - Tap the red trash icon on the task item to delete it.

6. **Offline Mode**

   - When offline, task data will be retrieved from the local database.
   - When online, task data will sync with the API.

## Architecture

The project follows a clean architecture approach, structured into the following layers:

1. **Presentation Layer**

   - Contains widgets, pages, and BLoC (Business Logic Component) for UI logic.

2. **Domain Layer**

   - Includes core business rules with entities, use cases, and repository interfaces.

3. **Data Layer**

   - Handles data operations through models, repository implementations, and data sources (local and remote).

4. **Core Layer**

   - Utility classes, network management, and local database operations.

## Third-Party Libraries

The application uses the following third-party libraries:

- `flutter_bloc: ^9.0.0` - State management with BLoC pattern
- `freezed: ^2.5.2` - Immutable data classes and union types
- `json_serializable: ^6.8.0` - JSON serialization/deserialization
- `sqflite: ^2.3.2` - SQLite database management
- `path: ^1.8.0` - Path manipulation for file storage
- `connectivity_plus: ^5.0.2` - Monitoring network connectivity status
- `bloc_test: ^10.0.0` - Testing BLoC components
- `mocktail: ^1.0.1` - Mocking framework for unit tests

