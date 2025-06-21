import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_bloc.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_event.dart';
import 'package:trendychef/Presentation/profile/pages/dash_board/bloc/user_dash_state.dart';
import 'package:trendychef/Presentation/widgets/textFIelds/text_field.dart';
import 'package:trendychef/core/services/data/models/user_model.dart';
import 'package:trendychef/l10n/app_localizations.dart';

void showEditDialog(BuildContext context, Address address, String phone) {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController(text: phone);
  final streetController = TextEditingController(text: address.street);
  final cityController = TextEditingController(text: address.city);
  final stateController = TextEditingController(text: address.state);
  final postalCodeController = TextEditingController(text: address.postalCode);
  final countryController = TextEditingController(text: address.country);

  final lang = AppLocalizations.of(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (dialogContext) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 600),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.edit_location_alt_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang?.editAddress ?? 'Edit Address',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              lang?.updateYourDeliveryInformation ??
                                  'Update your delivery information',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Form Content
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            buildTextField(
                              controller: phoneController,
                              label: "Phone Number",
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone number is required';
                                } else if (RegExp(
                                  r'^[0-9]{10,15}$',
                                ).hasMatch(value)) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            buildTextField(
                              controller: streetController,
                              label: "Street Address",
                              icon: Icons.home_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Street address is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField(
                                    controller: cityController,
                                    label: "City",
                                    icon: Icons.location_city_outlined,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'City is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: buildTextField(
                                    controller: stateController,
                                    label: "State",
                                    icon: Icons.map_outlined,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'State is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField(
                                    controller: postalCodeController,
                                    label: "Postal Code",
                                    icon: Icons.local_post_office_outlined,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Postal code is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: buildTextField(
                                    controller: countryController,
                                    label: "Country",
                                    icon: Icons.public_outlined,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Country is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Action Buttons
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              final updatedAddress = Address(
                                street: streetController.text,
                                city: cityController.text,
                                state: stateController.text,
                                postalCode: postalCodeController.text,
                                country: countryController.text,
                              );

                              final updatedPhone = phoneController.text;
                              final state = context.read<UserDashBloc>().state;

                              if (state is UserDashLoaded) {
                                final currentUser = state.user;
                                context.read<UserDashBloc>().add(
                                  UserAddressEditEvent(
                                    user: UserModel(
                                      id: currentUser.id,
                                      name: currentUser.name,
                                      phone: updatedPhone,
                                      address: updatedAddress,
                                    ),
                                  ),
                                );
                              }

                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: const Text(
                            "Save Changes",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
