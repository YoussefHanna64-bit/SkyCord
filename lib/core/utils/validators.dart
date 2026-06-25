import 'package:flutter/material.dart';

class Validators {
  static String? username(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    if (value.trim().length < 3) {
      return "Username must be at least 3 characters";
    }

    return null;
  }

  static String? email(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static String? password(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    return null;
  }

  static String? confirmPassword(
      BuildContext context, String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }

    if (value != password) {
      return "Passwords don't match";
    }

    return null;
  }

  static String? phone(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value.trim())) {
      return "Please enter a valid phone number";
    }

    return null;
  }

  static String? url(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (!RegExp(r'^https?://.+$').hasMatch(value.trim())) {
      return "Please enter a valid URL";
    }

    return null;
  }
}
