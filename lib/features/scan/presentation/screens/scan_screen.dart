import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_route_names.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/scan_bloc.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  void dispose() {
    context.read<ScanBloc>().add(DisposeCamera());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ScanBloc, ScanState>(
      listener: (context, state) {
        if (state.imagePath != null && !state.hasNavigated) {
          context.read<ScanBloc>().add(MarkNavigationHandled());

          context.pushReplacementNamed(
            AppRouteNames.tastePreference,
            extra: state.imagePath,
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading || state.controller == null) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF00A87D)),
            ),
          );
        }

        final controller = state.controller!;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.previewSize!.height,
                    height: controller.value.previewSize!.width,
                    child: CameraPreview(controller),
                  ),
                ),
              ),

              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 48,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      l10n.scan_your_ingredient,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        state.isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          context.read<ScanBloc>().add(ToggleFlash()),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 40,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/gallery.svg',
                        width: 28,
                        height: 28,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          context.read<ScanBloc>().add(PickFromGallery()),
                    ),

                    GestureDetector(
                      onTap: () => context.read<ScanBloc>().add(CaptureImage()),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: SvgPicture.asset(''),
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.cameraswitch, color: Colors.white),
                      onPressed: () =>
                          context.read<ScanBloc>().add(SwitchCamera()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
