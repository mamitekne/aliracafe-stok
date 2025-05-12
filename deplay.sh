#!/bin/bash

# 1. Flutter web için derleme
flutter build web

# 2. base href satırını değiştirme
sed -i '' 's|<base href="/">|<base href="/aliracafe-stok/">|' build/web/index.html

# 3. build/web klasörünü docs klasörüne kopyalama
rm -rf docs/*
cp -r build/web/* docs/

# 4. Git'e ekleme ve gönderme
git add .
git commit -m "Deploy: Flutter web build and GitHub Pages update"
git push

echo "✅ Deploy tamamlandı. Şuradan kontrol et: https://mamitekne.github.io/aliracafe-stok/"
