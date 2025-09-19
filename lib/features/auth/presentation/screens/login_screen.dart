import 'package:flutter/material.dart';
import 'package:flux_foot_admin/features/auth/presentation/provider/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogingScreen extends StatelessWidget {
  const LogingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0F2C),
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 768;
          return Container(
            // color: Color(0xFF1E2A44),
            child: isMobile ? MobileLoginLayout() : WebLoginLayout(),
          );
        },
      ),
    );
  }
}

//! Separate Widget for Mobile Layout to avoid rebuild issues
class MobileLoginLayout extends StatelessWidget {
  const MobileLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: viewInsets.bottom > 0 ? viewInsets.bottom + 20 : 20,
        ),
        child: Column(
          children: [
            //! Logo section - takes minimal space when keyboard is open
            if (viewInsets.bottom == 0) ...[
              SizedBox(height: size.height * 0.05),
              Image.asset(
                'assets/logo/logo.png',
                width: size.width * 0.25,
                height: size.height * 0.12,
                color: Colors.orangeAccent,
              ),
              SizedBox(height: 16),
              Text(
                'FLUXFOOT',
                style: GoogleFonts.rozhaOne(
                  fontSize: size.width * 0.08,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
            ] else ...[
              SizedBox(height: 20),
              Text(
                'FLUXFOOT',
                style: GoogleFonts.rozhaOne(
                  fontSize: size.width * 0.06,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
            ],

            //! Login form - expands to fill available space
            Expanded(child: SingleChildScrollView(child: LoginForm())),
          ],
        ),
      ),
    );
  }
}

//! Separate Widget for Web Layout
class WebLoginLayout extends StatelessWidget {
  const WebLoginLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/logo.png',
                  width: size.width * 0.1,
                  height: size.height * 0.1,
                  color: Colors.orangeAccent,
                ),
                Text(
                  'FLUXFOOT',
                  style: GoogleFonts.rozhaOne(
                    fontSize: size.width * 0.02,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(child: Center(child: LoginForm())),
      ],
    );
  }
}

//! Separate LoginForm Widget
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Consumer<AuthenticationAdmin>(
      builder: (context, authenticationAdmin, child) {
        return Form(
          key: authenticationAdmin.formkey,
          child: Padding(
            padding: EdgeInsets.only(right: !isMobile ? 30 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? size.width * 0.07 : size.width * 0.03,
                  ),
                ),
                SizedBox(height: 24),

                //! Email Field
                CustomTextFormField(
                  label: 'Enter Email',
                  hintText: 'example@fluxfoot.com',
                  controller: authenticationAdmin.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefIcon: Icon(
                    Icons.email,
                    size: isMobile ? 24 : 20,
                    color: Colors.grey.shade400,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                //! Password Field
                CustomTextFormField(
                  label: 'Enter Password',
                  hintText: '••••••••',
                  controller: authenticationAdmin.passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: !authenticationAdmin.isPasswordVisible,
                  prefIcon: Icon(
                    Icons.lock,
                    size: isMobile ? 24 : 20,
                    color: Colors.grey.shade400,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  suffIcon: authenticationAdmin.isPasswordVisible
                      ? IconButton(
                          onPressed: () =>
                              authenticationAdmin.togglePasswordVisible(),
                          icon: Icon(Icons.visibility, color: Colors.white),
                        )
                      : IconButton(
                          onPressed: () =>
                              authenticationAdmin.togglePasswordVisible(),
                          icon: Icon(Icons.visibility_off, color: Colors.white),
                        ),
                ),

                SizedBox(height: 32),

                //! Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authenticationAdmin.isLoading
                        ? null
                        : () => authenticationAdmin.login(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4C6EF5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: authenticationAdmin.isLoading
                        ? CircularProgressIndicator(color: Colors.orange)
                        : Text(
                            'Sign In',
                            style: GoogleFonts.openSans(
                              fontSize: isMobile ? 16 : 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// !Custom Text Form Field
class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? prefIcon;
  final Widget? suffIcon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefIcon,
    this.suffIcon,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: isMobile ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: isMobile ? 16 : 14,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.openSans(
              color: Colors.grey.shade400,
              fontSize: isMobile ? 16 : 14,
            ),
            prefixIcon: prefIcon,
            suffixIcon: suffIcon,
            fillColor: Color(0xFF2E3A55),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.orangeAccent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
