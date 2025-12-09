import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/auth/view_models/provider/auth_provider.dart';
import 'package:flux_foot_admin/features/auth/views/widgets/custom_textform.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
                    color: WebColors.textWhite,
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
                    color: WebColors.iconGreyShade,
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
                  obscureText: !authenticationAdmin.isPasswordVisible,
                  textInputAction: TextInputAction.next,
                  prefIcon: Icon(
                    Icons.lock,
                    size: isMobile ? 24 : 20,
                    color: WebColors.iconGreyShade,
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
                          icon: Icon(
                            Icons.visibility,
                            color: WebColors.textWhite,
                          ),
                        )
                      : IconButton(
                          onPressed: () =>
                              authenticationAdmin.togglePasswordVisible(),
                          icon: Icon(
                            Icons.visibility_off,
                            color: WebColors.textWhite,
                          ),
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
                      backgroundColor: WebColors.buttonBlue,
                      foregroundColor: WebColors.textWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: authenticationAdmin.isLoading
                        ? CircularProgressIndicator(
                            color: WebColors.borderSideOrangeAcnt,
                          )
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
