#!/bin/bash
# Start Sistem Pakar Motor Matic - UPDATED UI Version

echo "🚀 Starting Sistem Pakar Motor Matic..."
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Terminal 1: Server
echo -e "${BLUE}=== Terminal 1: Start Backend Server ===${NC}"
echo "cd server && npm install && npm start"
echo ""

# Terminal 2: Client
echo -e "${BLUE}=== Terminal 2: Start Frontend Client ===${NC}"
echo "cd client && npm install && npm run dev"
echo ""

# Instructions
echo -e "${GREEN}📋 INSTRUKSI MENJALANKAN SISTEM:${NC}"
echo ""
echo "1. Buka 2 terminal"
echo ""
echo "2. Terminal Pertama (Backend):"
echo "   cd server"
echo "   npm install (jika belum)"
echo "   npm start"
echo "   → Server akan berjalan di http://localhost:4000"
echo ""
echo "3. Terminal Kedua (Frontend):"
echo "   cd client"
echo "   npm install (jika belum)"
echo "   npm run dev"
echo "   → Client akan berjalan di http://localhost:5173"
echo ""
echo "4. Buka browser di http://localhost:5173"
echo ""
echo "5. Mulai konsultasi:"
echo "   - Pilih diagnosa motor Anda"
echo "   - Modal akan muncul dengan pertanyaan"
echo "   - Jawab dengan 'Ya' atau 'Tidak'"
echo "   - Lihat hasil diagnosis dalam modal"
echo ""
echo -e "${YELLOW}✨ FITUR BARU:${NC}"
echo "   ✓ UI dengan Modal Popup (tidak perlu scroll)"
echo "   ✓ Pertanyaan dalam bahasa awam (mudah dipahami)"
echo "   ✓ Gejala ringan seperti lampu/klakson mati"
echo "   ✓ Hasil diagnosis instant dalam popup"
echo "   ✓ Responsive untuk desktop dan mobile"
echo ""
echo -e "${YELLOW}📝 CATATAN PENTING:${NC}"
echo "   - Sistem menggunakan Backward Chaining + DFS"
echo "   - Hasil adalah PASTI (tidak ada probability)"
echo "   - Semua pertanyaan bisa dijawab 'Ya' atau 'Tidak'"
echo ""
