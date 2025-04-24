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
  late PDFViewController pdfViewController;
  int currentPage = 0;
  int totalPages = 0;
  double zoomLevel = 1.0; // Initial zoom level

  @override
  void initState() {
    super.initState();
    context.read<EbookDetailBloc>().add(FetchEbookDetail(widget.ebookId));
  }

  void jumpToPage(int page) {
    pdfViewController.setPage(page);
  }

  void zoomIn() {
    setState(() {
      if (zoomLevel < 3.0) {
        zoomLevel += 0.5; // Increase zoom level
      }
    });
  }

  void zoomOut() {
    setState(() {
      if (zoomLevel > 1.0) {
        zoomLevel -= 0.5; // Decrease zoom level
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ebook Detail'),
        backgroundColor:  Theme.of(context).brightness == Brightness.dark
              ? AppColors.background
              : Colors.white,
      ),
      body: BlocBuilder<EbookDetailBloc, EbookDetailState>(
        builder: (context, state) {
          if (state is EbookDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EbookDetailLoaded) {
            return Column(
              children: [
                Expanded(
                  child: Transform.scale(
                    scale: zoomLevel, // Apply zoom effect by scaling the container
                    child: PDFView(
                      filePath: state.localPdfPath,
                      enableSwipe: true, // Enable swipe gestures
                      swipeHorizontal: true, // Disable horizontal swipe
                      autoSpacing: true, // Enable auto-spacing between pages
                      pageFling: true, // Enable page fling effect
                      nightMode: false, // Disable night mode
                      fitPolicy: FitPolicy.WIDTH, // Fit PDF to width
                      onRender: (pages) {
                        setState(() {
                          totalPages = pages!;
                        });
                      },
                      onPageChanged: (page, total) {
                        setState(() {
                          currentPage = page!;
                        });
                      },
                      onViewCreated: (controller) {
                        pdfViewController = controller;
                      },
                      onError: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $error')),
                        );
                      },
                      onPageError: (page, error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error on page $page: $error')),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.zoom_in),
                        onPressed: zoomIn,
                      ),
                      Text("Page ${currentPage + 1} of $totalPages"),
                      IconButton(
                        icon: Icon(Icons.zoom_out),
                        onPressed: zoomOut,
                      ),
                    ],
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
