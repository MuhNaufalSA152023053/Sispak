# Sistem Pakar Otomotif

Sistem pakar otomotif berbasis **Backward Chaining** dengan strategi penelusuran **Depth-First Search (DFS)** dan perhitungan **Certainty Factor (CF)**. Proyek ini dibangun dengan arsitektur **decoupled** antara frontend dan backend agar mudah dikembangkan, diuji, dan di-deploy secara terpisah.

Saat ini basis pengetahuan difokuskan pada **diagnosa kerusakan motor matic**, dengan alur konsultasi interaktif yang dimulai dari pemilihan dugaan kerusakan, lalu sistem memverifikasi gejala pendukung satu per satu sampai menghasilkan diagnosis akhir.

## Informasi Proyek

- **Jenis proyek:** Project kelompok
- **Mata kuliah:** Sistem Pakar dan Bahasa Alamiah
- **Kelompok:** Kelompok 4 (**PawPaw**)

## Highlights

- Arsitektur terpisah: `React + Vite` di frontend dan `Node.js + Express` di backend
- Inference engine berbasis **goal-driven backward chaining**
- Penelusuran aturan menggunakan **DFS** secara rekursif
- **Working memory per sesi** untuk menghindari pertanyaan berulang
- Dukungan **Certainty Factor** skala `0.00 - 1.00`
- Fitur penjelasan:
  - **Mengapa?** untuk menjelaskan alasan pertanyaan aktif
  - **Bagaimana?** untuk menampilkan jejak penalaran akhir
- Knowledge base disimpan dalam file JSON agar mudah diperluas

## Ruang Lingkup Pengetahuan Saat Ini

Knowledge base yang aktif saat ini memuat:

- `9` hipotesis kerusakan
- `21` fakta/gejala
- `15` aturan produksi

Contoh hipotesis yang tersedia:

- Mesin mati total (mogok)
- Sistem pendingin gagal (overheat)
- Masalah pada kampas ganda/CVT (gredek)
- Laher roda depan rusak
- Kebocoran oli pada blok mesin
- Malfungsi sistem elektronik

## Tech Stack

### Frontend

- React 18
- Vite
- Fetch API

### Backend

- Node.js
- Express
- CORS

### Knowledge & Inference

- Production Rules (`IF-THEN`)
- Backward Chaining
- Depth-First Search (DFS)
- Certainty Factor (CF)
- Session-based Working Memory

## Arsitektur Sistem

```text
+---------------------------+
| React Consultation UI     |
| - Pilih goal              |
| - Jawab satu gejala       |
| - Lihat Mengapa/Bagaimana |
+------------+--------------+
             |
             | HTTP / JSON
             v
+---------------------------+
| Express Inference API     |
| - Session management      |
| - Consultation flow       |
| - Error handling          |
+------------+--------------+
             |
             v
+---------------------------+
| Inference Engine          |
| - Backward chaining       |
| - Recursive DFS           |
| - CF calculation          |
+------------+--------------+
             |
             v
+---------------------------+
| Knowledge Base            |
| - goals                   |
| - facts                   |
| - rules                   |
| - explanations            |
+---------------------------+
```

## Cara Kerja Sistem

1. Pengguna memilih **dugaan kerusakan** sebagai goal awal.
2. Backend memulai **backward chaining** dari goal tersebut.
3. Mesin inferensi menelusuri aturan yang dapat membuktikan goal.
4. Jika sebuah premis belum diketahui dan bersifat `askable`, sistem mengirim **satu pertanyaan** ke frontend.
5. Jawaban pengguna disimpan di **working memory per sesi**.
6. Sistem melanjutkan penelusuran dengan pendekatan **DFS** sampai:
   - hipotesis terbukti, atau
   - seluruh jalur aturan gagal diverifikasi.
7. Jika terbukti, sistem menghitung **Certainty Factor** berdasarkan kekuatan aturan dan premis yang terpenuhi.

## Fitur Utama

### 1. Goal-Driven Consultation

Konsultasi dimulai dari hipotesis yang dipilih pengguna, bukan dari daftar gejala acak. Pendekatan ini membuat alur lebih sesuai dengan metode backward chaining.

### 2. Session-Based Working Memory

Setiap sesi konsultasi memiliki memori kerja sendiri untuk menyimpan fakta yang sudah dijawab pengguna. Dengan cara ini, sistem tidak mengulang pertanyaan yang sama selama sesi masih aktif.

### 3. Explanation Facility

- **Mengapa?**
  Menjelaskan aturan apa yang sedang diverifikasi dan premis mana yang sedang dibutuhkan.
- **Bagaimana?**
  Menampilkan jalur penalaran yang diambil sistem hingga mencapai hasil akhir.

### 4. Certainty Factor

Diagnosis tidak hanya menghasilkan status benar/salah, tetapi juga tingkat keyakinan dalam bentuk nilai CF.

## Struktur Proyek

```text
.
|-- client/
|   |-- index.html
|   |-- package.json
|   |-- vite.config.js
|   `-- src/
|       |-- App.jsx
|       |-- main.jsx
|       |-- api/
|       |   `-- consultationApi.js
|       |-- components/
|       |   |-- ConsultationContainer.jsx
|       |   |-- GoalSelector.jsx
|       |   |-- QuestionCard.jsx
|       |   |-- ReasoningTrace.jsx
|       |   `-- ResultPanel.jsx
|       `-- styles/
|           `-- app.css
|
`-- server/
    |-- package.json
    `-- src/
        |-- app.js
        |-- index.js
        |-- config/
        |   `-- knowledgeBase.js
        |-- data/
        |   |-- rules.json
        |   `-- rules.schema.json
        |-- routes/
        |   `-- consultationRoutes.js
        `-- services/
            |-- inferenceEngine.js
            `-- sessionStore.js
```

## Struktur Knowledge Base

Knowledge base disimpan di `server/src/data/rules.json` dengan komponen utama:

- `metadata`: informasi domain dan metode inferensi
- `goals`: daftar hipotesis kerusakan
- `facts`: daftar fakta atau gejala
- `rules`: aturan produksi untuk pembuktian hipotesis

Contoh skema sederhana:

```json
{
  "goals": [
    {
      "id": "mesin_overheat",
      "label": "Sistem Pendingin Gagal (Overheat)"
    }
  ],
  "facts": [
    {
      "id": "suhu_di_atas_130",
      "askable": true,
      "question": "Apakah indikator mendeteksi suhu mesin melampaui 130 derajat celcius?"
    }
  ],
  "rules": [
    {
      "id": "R-OVH-01",
      "conclusion": "mesin_overheat",
      "premises": ["suhu_di_atas_130", "air_radiator_habis"],
      "cf": 0.9
    }
  ]
}
```

## API Utama

Base URL default:

```text
http://localhost:4000/api
```

Endpoint yang tersedia:

- `GET /goals`
  Mengambil daftar hipotesis yang bisa dipilih pengguna.
- `POST /consultations/start`
  Membuat sesi konsultasi baru berdasarkan `goalId`.
- `POST /consultations/:sessionId/answer`
  Mengirim jawaban untuk pertanyaan aktif.
- `GET /consultations/:sessionId/why`
  Mengambil penjelasan mengapa pertanyaan aktif diajukan.
- `GET /consultations/:sessionId/how`
  Mengambil jejak penalaran sesi.
- `DELETE /consultations/:sessionId`
  Menghapus sesi konsultasi.

## Menjalankan Proyek Secara Lokal

### Prasyarat

- Node.js 18+ disarankan
- npm

### 1. Install dependency

```bash
cd server
npm install

cd ../client
npm install
```

### 2. Konfigurasi environment

Backend mendukung nilai default, tetapi Anda bisa membuat file `server/.env`:

```env
PORT=4000
CLIENT_ORIGIN=http://localhost:5173
SESSION_TTL_MINUTES=30
```

Frontend juga mendukung nilai default, tetapi Anda bisa membuat file `client/.env`:

```env
VITE_API_BASE_URL=http://localhost:4000/api
```

### 3. Jalankan backend

```bash
cd server
npm run dev
```

### 4. Jalankan frontend

```bash
cd client
npm run dev
```

Frontend akan berjalan di:

```text
http://localhost:5173
```

Backend default akan berjalan di:

```text
http://localhost:4000
```

## Scripts

### Client

- `npm run dev` menjalankan Vite development server
- `npm run build` membuat production build
- `npm run preview` menampilkan hasil build secara lokal

### Server

- `npm run dev` menjalankan Express server dengan mode watch
- `npm run start` menjalankan server normal
- `npm run check` memeriksa sintaks file inti backend

## Validasi dan Pengujian

Proyek ini telah diverifikasi pada level dasar berikut:

- backend lolos `npm run check`
- frontend berhasil `npm run build`
- alur API konsultasi berhasil diuji dari `start -> why -> answer -> result`

## Catatan Implementasi

- Session store saat ini masih menggunakan **in-memory storage**
- Knowledge base dapat diperluas cukup dengan menambah fakta dan aturan di `rules.json`
- Arsitektur saat ini cocok untuk dikembangkan ke:
  - database persistent untuk sesi
  - autentikasi pengguna
  - dashboard admin untuk mengelola aturan
  - deployment terpisah frontend/backend

## Roadmap Pengembangan

- Tambah `.env.example`
- Tambah automated test untuk inference engine dan API
- Tambah halaman admin knowledge base
- Tambah visualisasi pohon penalaran
- Tambah dukungan multi-domain kendaraan

## Tim Pengembang

Project ini dibuat oleh **Kelompok 4 (PawPaw)** untuk mata kuliah **Sistem Pakar dan Bahasa Alamiah**.

| NRP | Nama Lengkap |
| --- | --- |
| 152023046 | Rafi Syahrulfallah |
| 152023053 | Muhammad Naufal Shidqi A |
| 152023065 | Nicky Aditya Bagus |
| 152023059 | Muhammad Lutfi Alamsyah |
| 152023078 | Muhammad Daffa H A |
