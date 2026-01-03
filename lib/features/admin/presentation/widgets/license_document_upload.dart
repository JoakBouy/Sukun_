import 'package:flutter/material.dart';
import 'package:freud_ai/core/managers/custom_colors.dart';
import 'package:freud_ai/core/managers/sizes_manager.dart';

class LicenseDocumentUpload extends StatefulWidget {
  final Function(String) onDocumentUploaded;

  const LicenseDocumentUpload({
    super.key,
    required this.onDocumentUploaded,
  });

  @override
  State<LicenseDocumentUpload> createState() => _LicenseDocumentUploadState();
}

class _LicenseDocumentUploadState extends State<LicenseDocumentUpload> {
  String? _uploadedDocumentUrl;
  bool _isUploading = false;

  Future<void> _pickDocument() async {
    setState(() => _isUploading = true);

    // Simulate file picker and upload
    await Future.delayed(const Duration(seconds: 2));

    // In production, this would:
    // 1. Use file_picker package to select image/PDF
    // 2. Upload to Firebase Storage or similar
    // 3. Return the download URL

    final mockUrl = 'https://example.com/licenses/license_${DateTime.now().millisecondsSinceEpoch}.pdf';

    setState(() {
      _uploadedDocumentUrl = mockUrl;
      _isUploading = false;
    });

    widget.onDocumentUploaded(mockUrl);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document uploaded successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _removeDocument() {
    setState(() => _uploadedDocumentUrl = null);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomColors>()!;

    if (_uploadedDocumentUrl != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.green, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.check_circle,
                color: colors.green,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Document Uploaded',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.green,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'License verification document',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onBackground.withOpacity(0.6),
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              color: Colors.red,
              onPressed: _removeDocument,
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colors.onBackground.withOpacity(0.2),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud_upload,
            size: 64,
            color: colors.onBackground.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Upload License Document',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload a clear photo or PDF of your medical license',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onBackground.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 24),
          _isUploading
              ? Column(
                  children: [
                    CircularProgressIndicator(color: colors.green),
                    const SizedBox(height: 12),
                    Text(
                      'Uploading...',
                      style: TextStyle(color: colors.onBackground.withOpacity(0.6)),
                    ),
                  ],
                )
              : ElevatedButton.icon(
                  onPressed: _pickDocument,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Choose File'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                ),
          const SizedBox(height: 12),
          Text(
            'Supported formats: JPG, PNG, PDF (Max 10MB)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onBackground.withOpacity(0.5),
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}
