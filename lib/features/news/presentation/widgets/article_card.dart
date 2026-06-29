import 'package:flutter/material.dart';
import '../../domain/entities/article_entity.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Memberikan jarak luar agar tidak menempel ke tepi layar
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A24), // Warna Dark Mode (Hitam kebiruan elegan)
        borderRadius: BorderRadius.circular(16.0), // Ujung melengkung
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- 1. BAGIAN KIRI: GAMBAR ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              // CATATAN: Jika di ArticleEntity kamu punya properti untuk gambar 
              // (misalnya: article.urlToImage), kamu bisa ganti Container ini dengan:
              // Image.network(article.urlToImage ?? '', width: 80, height: 80, fit: BoxFit.cover),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.grey[800],
                child: const Icon(Icons.image, color: Colors.grey, size: 40),
              ),
            ),
            
            const SizedBox(width: 16.0), // Jarak antara gambar dan teks
            
            // --- 2. BAGIAN TENGAH: TEKS (JUDUL & DESKRIPSI) ---
            Expanded( // Expanded agar teks mengisi sisa ruang yang ada
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2, // Maksimal 2 baris sesuai screenshot
                    overflow: TextOverflow.ellipsis, // Jika kepanjangan, potong pakai '...'
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    article.description, // Kalau di entity kamu ada properti author, bisa diganti article.author
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
            ),
            
            // --- 3. BAGIAN KANAN: TOMBOL BOOKMARK ---
            IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.grey),
              onPressed: () {
                // Tombol ini disiapkan untuk Langkah 3 (Simpan ke Isar Database)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Fitur Offline-First segera hadir!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}