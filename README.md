# Task Manager Documentation

## Overview

This project is a Flutter-based Task Manager app that utilizes **BLoC (Business Logic Component)** for state management, **Dio** for API requests, **SharedPreferences** for local storage, and **Firebase** for authentication and notifications.

## App Screenshot

![Screenshot_1739988419](https://github.com/user-attachments/assets/600e0e30-0394-4f5c-ba4d-944412caed24)

![Screenshot_1739988400](https://github.com/user-attachments/assets/ea3790d4-96fa-4331-9877-19bb97a9ffe0)
![Screenshot_1739988410](https://github.com/user-attachments/assets/a293ad5a-e64f-4a61-bc31-6e302d8c67cf)

## Folder Structure

```
lib/
│── core/
│   ├── storage/
│   │   ├── task_local_store.dart
│
│── models/
│   ├── tasks/
│   │   ├── task_model.dart
│
│── view_models/
│   ├── auth/
│   │   ├── repo/
│   │   │   ├── auth_repository.dart
│   │   ├── cubit/
│   │   │   ├── auth_cubit.dart
│   ├── tasks/
│   │   ├── repositories/
│   │   │   ├── task_repository.dart
│   │   ├── bloc/
│   │   │   ├── task_bloc.dart
│   │   │   ├── task_event.dart
│   │   │   ├── task_state.dart
│
│── views/
│   ├── auth/
│   │   ├── login_screen.dart
│   ├── tasks/
│   │   ├── task_screen.dart
│
│── main.dart
│── app_routes.dart
```

## Dependencies

- **flutter\_bloc**: State management with BLoC
- **dio**: API requests
- **freezed\_annotation**: Code generation for immutable classes
- **shared\_preferences**: Local storage
- **mockito** & **flutter\_test**: Unit testing

---

## Authentication

### **AuthRepository** (`auth_repository.dart`)

Handles user authentication:

- **`loginUser(username, password)`** → Logs in user and stores token in SharedPreferences
- **`saveToken(token)`** → Saves token locally
- **`logoutUser()`** → Removes token from local storage
- **`isUserLoggedIn()`** → Checks if user is logged in

### **AuthCubit** (`auth_cubit.dart`)

Manages authentication state:

- **`login(username, password)`** → Calls `AuthRepository.loginUser()` and emits login status
- **`logout()`** → Calls `AuthRepository.logoutUser()` and emits logout status
- **`checkLoginStatus()`** → Checks if the user is logged in and emits the result

---

## Task Management

### **TaskRepository** (`task_repository.dart`)

Handles API requests for tasks:

- **`fetchTasks(page, limit)`** → Fetches paginated tasks from API
- **`addTask(model)`** → Adds a new task via API
- **`updateTask(taskId, completed)`** → Updates task completion status
- **`deleteTask(taskId)`** → Deletes a task via API

### **TaskBloc** (`task_bloc.dart`)

Manages task states and events:

- **Events:** `fetchTasks`, `addTask`, `updateTask`, `deleteTask`
- **States:** `initial`, `loading`, `success`, `failure`
- **Handles local storage sync using TaskLocalStorage**

### **TaskLocalStorage** (`task_local_store.dart`)

Manages local task storage:

- **`saveTasks(tasks)`** → Saves tasks locally
- **`loadTasks()`** → Loads tasks from local storage
- **`clearTasks()`** → Clears stored tasks

---

## Routing

### **AppRoutes** (`app_routes.dart`)

Defines app navigation:

- **`/login`** → Login Screen
- **`/task`** → Task Management Screen

---

## Logging

### **AppBlocObserver** (`app_bloc_observer.dart`)

Observes BLoC state changes and errors:

- Logs state transitions
- Logs errors and stack traces

---

## Testing

Tests are located in `test/` folder.

### **Unit Testing AuthRepository (********`auth_repository_test.dart`********\*\*\*\*\*\*\*\*\*\*\*\*):**

- Mocks Dio requests
- Tests login and failure cases

### **Unit Testing TaskBloc (********`task_bloc_test.dart`********\*\*\*\*\*\*\*\*\*\*\*\*):**

- Tests task fetching, adding, updating, and deletion
- Uses mock API responses

### **Unit Testing TaskLocalStorage (********`task_local_store_test.dart`********\*\*\*\*\*\*\*\*\*\*\*\*):**

- Ensures local storage operations work correctly

---

