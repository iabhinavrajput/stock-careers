import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:stock_careers/blocs/ebook/ebook_detail_bloc.dart';
import 'package:stock_careers/blocs/ebook/ebook_detail_event.dart';
import 'package:stock_careers/blocs/ebook/ebook_detail_state.dart';
import '../../../utils/constants/colors.dart';

class EbookDetailScreen extends StatefulWidget {
  final String ebookId;

  const EbookDetailScreen({Key? key, required this.ebookId}) : super(key: key);

  @override
  State<EbookDetailScreen> createState() => _EbookDetailScreenState();
}

class _EbookDetailScreenState extends State<EbookDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EbookDetailBloc>().add(FetchEbookDetail(widget.ebookId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Ebook Pdf",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/images/avatar.png',
                height: 50,
                width: 50,
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<EbookDetailBloc, EbookDetailState>(
        builder: (context, state) {
          if (state is EbookDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EbookDetailLoaded) {
            return Column(
              children: [
                Expanded(
                  child: PDFView(
                    filePath: state.localPdfPath,
                    enableSwipe: true,
                    swipeHorizontal: false,
                    autoSpacing: false,
                    pageFling: true,
                  ),
                ),
              ],
            );
          } else if (state is EbookDetailError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
