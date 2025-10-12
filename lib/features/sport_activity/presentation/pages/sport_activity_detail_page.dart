import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/di/injection.dart';
import 'package:flutter_sparring/features/sport_activity/domain/usecases/get_sport_activity_by_id_usecase.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/blocs/sport_activity_detail_cubit.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/widgets/sport_activity_details.dart';
import 'package:flutter_sparring/features/transaction/presentation/blocs/upload_proof_payment_cubit.dart';
import 'package:flutter_sparring/features/transaction/presentation/widgets/payment_popup/payment_popup.dart';
import 'package:flutter_sparring/shared/widgets/app_loader.dart';

class SportActivityDetailPage extends StatelessWidget {
  final int activityId;

  const SportActivityDetailPage({super.key, required this.activityId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<SportActivityDetailCubit>()
            ..loadActivity(params: GetSportActivityByIdParams(id: activityId)),
        ),
        BlocProvider(
          create: (_) => getIt<UploadProofPaymentCubit>(),
        ),
      ],
      child: BlocListener<UploadProofPaymentCubit, UploadProofPaymentState>(
        listener: (context, state) {
          if (state is UploadProofPaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }

          if (state is UploadProofPaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Payment uploaded successfully!"),
                backgroundColor: Colors.green,
              ),
            );

            // ✅ Refresh activity detail
            context.read<SportActivityDetailCubit>().loadActivity(
                  params: GetSportActivityByIdParams(id: activityId),
                );

            // ✅ Close bottom sheet safely
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }
        },
        child: Scaffold(
          appBar: AppBar(title: const Text("Activity Details")),
          body: BlocBuilder<SportActivityDetailCubit, SportActivityDetailState>(
            builder: (context, state) {
              if (state is SportActivityDetailLoading) {
                return const Center(child: AppLoader());
              }

              if (state is SportActivityDetailError) {
                return Center(child: Text("Error: ${state.failure.message}"));
              }

              if (state is SportActivityDetailLoaded) {
                return SportActivityDetails(
                  activity: state.activity,
                  onJoin: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (bottomSheetContext) {
                        return BlocProvider.value(
                          value: context.read<UploadProofPaymentCubit>(),
                          child: _PaymentPopupContent(
                            activityTitle: state.activity.title ?? "Unknown activity",
                            amount: state.activity.priceDiscount ?? state.activity.price ?? 0,
                            activityId: state.activity.id,
                          ),
                        );
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _PaymentPopupContent extends StatelessWidget {
  final String activityTitle;
  final int amount;
  final int activityId;

  const _PaymentPopupContent({
    required this.activityTitle,
    required this.amount,
    required this.activityId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadProofPaymentCubit, UploadProofPaymentState>(
      builder: (context, state) {
        final isLoading = state is UploadProofPaymentLoading;

        return Stack(
          children: [
            PaymentPopup(
              amount: amount,
              activityTitle: activityTitle,
              onSubmit: (method, proofFile) {
                context.read<UploadProofPaymentCubit>().processPayment(
                      sportActivityId: activityId,
                      paymentMethodId: method.id,
                      proofFile: proofFile,
                    );
              },
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: const Center(child: AppLoader()),
                ),
              ),
          ],
        );
      },
    );
  }
}
