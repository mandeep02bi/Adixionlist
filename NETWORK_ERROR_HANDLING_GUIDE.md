# Network Error Handling Guide

## Overview
This guide explains how to handle network errors in your Flutter app and automatically navigate users to the home page when network issues occur.

## What Was Implemented

### 1. Network Error Navigator (`lib/Core/networking/network_error_navigator.dart`)
A global service that:
- Detects network-related errors (timeout, no internet, connection errors)
- Shows error messages via snackbar
- Automatically navigates to home page when network errors occur
- Provides dialog option for retry functionality

### 2. Updated Error Handling in BLoCs
Modified `AddPatientBloc` to include status codes in error states, allowing network error detection.

### 3. Updated UI Error Handling
Modified `add_patient_screen.dart` to use the network error navigator.

## Network Error Types Detected

The following errors will trigger navigation to home page:
- **Connection Timeout** (`CONNECT_TIMEOUT = -1`)
- **Receive Timeout** (`RECIEVE_TIMEOUT = -3`)
- **Send Timeout** (`SEND_TIMEOUT = -4`)
- **No Internet Connection** (`NO_INTERNET_CONNECTION = -6`)
- **Default/Unknown Errors** (`DEFAULT = -7`)

## How to Use

### Method 1: Auto-Navigate to Home (Recommended)

In your BLoC listener:

```dart
import 'package:doctor/Core/networking/network_error_navigator.dart';
import 'package:doctor/Core/networking/error_handler.dart';

BlocListener<YourBloc, YourState>(
  listener: (context, state) {
    if (state is YourErrorState) {
      // Check if it's a network error
      final isNetworkError = state.statusCode == ResponseCode.CONNECT_TIMEOUT ||
          state.statusCode == ResponseCode.RECIEVE_TIMEOUT ||
          state.statusCode == ResponseCode.SEND_TIMEOUT ||
          state.statusCode == ResponseCode.NO_INTERNET_CONNECTION ||
          state.statusCode == ResponseCode.DEFAULT;

      if (isNetworkError) {
        // Navigate to home page
        NetworkErrorNavigator.handleNetworkError(
          context,
          ApiErroModel(
            status: false,
            statusCode: state.statusCode,
            message: state.message,
            data: null,
          ),
          navigateToHome: true,
          showSnackbar: true,
        );
      } else {
        // Show error message only
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red.shade600,
          ),
        );
      }
    }
  },
  child: YourWidget(),
)
```

### Method 2: Show Dialog with Retry Option

```dart
if (state is YourErrorState && isNetworkError) {
  NetworkErrorNavigator.showNetworkErrorDialog(
    context,
    onRetry: () {
      // Retry the operation
      context.read<YourBloc>().add(RetryEvent());
    },
    onGoHome: () {
      // Custom home navigation (optional)
      Get.offAll(() => const Doctorhomesc());
    },
  );
}
```

### Method 3: Custom Error Handling

```dart
if (state is YourErrorState) {
  NetworkErrorNavigator.handleNetworkError(
    context,
    ApiErroModel(
      status: false,
      statusCode: state.statusCode,
      message: state.message,
      data: null,
    ),
    navigateToHome: false,  // Don't auto-navigate
    showSnackbar: true,      // Just show error
  );
}
```

## Updating Other BLoCs

To apply this pattern to other BLoCs in your app:

### Step 1: Update BLoC Error State

```dart
class YourErrorState extends YourState {
  final String message;
  final int statusCode;
  
  YourErrorState(this.message, {this.statusCode = -7});
}
```

### Step 2: Update BLoC Error Emission

```dart
result.when(
  success: (response) {
    emit(YourSuccessState(response));
  },
  error: (error) {
    emit(YourErrorState(
      error.failure.message,
      statusCode: error.failure.statusCode,
    ));
  },
);
```

### Step 3: Update UI Listener

Add the network error handling logic shown in Method 1 above.

## Example: Apply to Login Screen

```dart
// In login_bloc.dart
class LoginError extends LoginState {
  final String message;
  final int statusCode;
  LoginError(this.message, {this.statusCode = -7});
}

// In login_bloc.dart - error emission
error: (error) {
  emit(LoginError(
    error.failure.message,
    statusCode: error.failure.statusCode,
  ));
}

// In login_screen.dart - listener
import 'package:doctor/Core/networking/network_error_navigator.dart';
import 'package:doctor/Core/networking/error_handler.dart';

BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if (state is LoginError) {
      final isNetworkError = state.statusCode == ResponseCode.CONNECT_TIMEOUT ||
          state.statusCode == ResponseCode.RECIEVE_TIMEOUT ||
          state.statusCode == ResponseCode.SEND_TIMEOUT ||
          state.statusCode == ResponseCode.NO_INTERNET_CONNECTION ||
          state.statusCode == ResponseCode.DEFAULT;

      if (isNetworkError) {
        NetworkErrorNavigator.handleNetworkError(
          context,
          ApiErroModel(
            status: false,
            statusCode: state.statusCode,
            message: state.message,
            data: null,
          ),
          navigateToHome: true,
          showSnackbar: true,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    }
  },
  child: LoginForm(),
)
```

## Testing

To test network error handling:

1. **Turn off WiFi/Data** - This will trigger `NO_INTERNET_CONNECTION`
2. **Use slow network** - May trigger timeouts
3. **Simulate server down** - Will trigger various connection errors

All these scenarios should automatically navigate users to the home page with an appropriate error message.

## Configuration

You can customize the behavior in `network_error_navigator.dart`:

- **Delay before navigation**: Change `Duration(milliseconds: 500)`
- **Snackbar duration**: Change `Duration(seconds: 3)`
- **Home page route**: Change `Get.offAll(() => const Doctorhomesc())`

## Benefits

✅ **Better UX**: Users aren't stuck on error screens
✅ **Consistent**: All network errors handled the same way
✅ **Recoverable**: Users can retry from home page
✅ **Informative**: Users see what went wrong
✅ **Safe**: Prevents app from being in unstable state

## Notes

- The `_isShowingError` flag prevents multiple simultaneous navigations
- Uses GetX navigation (`Get.offAll`) to clear navigation stack
- Error messages are shown via Material SnackBar
- Home page is the fallback for all network errors
