// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flux_foot_admin/core/constants/web_colors.dart';
import 'package:flux_foot_admin/features/user_management/views/widgets/showing_userdetails_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserTable extends StatelessWidget {
  const UserTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WebColors.bgDarkBlue1,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: WebColors.bgDarkBlue2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Phone No',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Text(
                    'View Details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: WebColors.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // The list content
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: WebColors.logocolor,
                    size: 70,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: GoogleFonts.openSans(color: WebColors.errorRed),
                  ),
                );
              }
              final allUsers = snapshot.data?.docs ?? [];
              final displayUsers = allUsers;

              if (displayUsers.isEmpty) {
                return Center(
                  child: Text(
                    'No Users found.',
                    style: GoogleFonts.openSans(color: WebColors.textWhite),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayUsers.length,
                itemBuilder: (context, index) {
                  final userDoc = displayUsers[index];
                  final data = userDoc.data();

                  if (data == null) return const SizedBox.shrink();

                  final userData = data as Map<String, dynamic>;
                  final userId = userDoc.id;

                  final name = userData['name'] ?? 'N/A';
                  final dynamic phoneValue = userData['phone'];
                  final String phone = phoneValue != null
                      ? phoneValue.toString()
                      : 'N/A';
                  final email = userData['email'] ?? 'N/A';
                  final dynamic dobValue = userData['dob'];
                  final String dob = dobValue != null
                      ? dobValue.toString()
                      : 'N/A';
                  final dynamic imageUrlValue = userData['imageUrl'];
                  final String imageUrl = imageUrlValue != null
                      ? imageUrlValue.toString()
                      : '';
                  final bool isOnline = userData['isOnline'] as bool? ?? false;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: WebColors.bgDarkBlue2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        //! Name
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 13,
                                backgroundImage: imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : null,
                                child: imageUrl.isEmpty
                                    ? const Icon(
                                        Icons.person_outlined,
                                        size: 20,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  name,
                                  style: GoogleFonts.openSans(
                                    color: WebColors.textWhite,
                                    fontSize: 15,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //! Phone
                        Expanded(
                          flex: 2,
                          child: Text(
                            phone,
                            style: GoogleFonts.openSans(
                              color: WebColors.textWhiteLite,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //! Email
                        Expanded(
                          flex: 2,
                          child: Text(
                            email,
                            style: GoogleFonts.openSans(
                              color: WebColors.textWhiteLite,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        //! Status
                        Expanded(
                          flex: 2,
                          child: Text(
                            isOnline ? 'Online' : 'Offline',
                            style: GoogleFonts.openSans(
                              color: isOnline
                                  ? WebColors.activeGreen
                                  : WebColors.errorRed,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        //!  View Details
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: IconButton(
                              color: WebColors.buttonBlue,
                              onPressed: () {
                                onShowUserDetails(
                                  context,
                                  isOnline,
                                  userId,
                                  name,
                                  email,
                                  phone,
                                  dob,
                                  imageUrl,
                                );
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
