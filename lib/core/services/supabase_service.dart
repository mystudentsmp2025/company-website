import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> submitLead({
    required String name,
    required String email,
    required String message,
    String? mobile,
  }) async {
    await client.from('leads').insert({
      'name': name,
      'email': email,
      'message': message,
      'mobile': mobile,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
