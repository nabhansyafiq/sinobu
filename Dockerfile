# Gunakan Node.js versi LTS berbasis Debian Buster
FROM node:lts-buster

# Perbarui repositori, instal dependensi, dan bersihkan cache
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Buat direktori kerja
WORKDIR /app

# Salin file package.json dan package-lock.json terlebih dahulu untuk mempercepat cache install
COPY package.json package-lock.json ./

# Instal semua dependensi Node.js dari package.json
RUN npm install && npm install qrcode-terminal

# Salin semua file ke dalam container
COPY . .

# Pastikan izin file dan direktori sesuai agar tidak ada konflik
RUN chmod -R 755 /app

# Expose port 5000 untuk aplikasi
EXPOSE 5000

# Jalankan aplikasi
CMD ["node", "index.js"]
