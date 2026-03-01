# Cüneyt YILMAZ — Kurumsal Web Sitesi

## GitHub Pages ile Yayınlama

Bu site GitHub Pages üzerinden ücretsiz olarak yayınlanabilir.

### Adımlar

1. **GitHub'da yeni depo oluşturun**
   - [github.com/new](https://github.com/new) adresine gidin
   - Depo adı: `cuneyt-yilmaz` (veya tercih ettiğiniz ad)
   - "Create repository" tıklayın

2. **Kodu GitHub'a gönderin**
   ```bash
   cd cuneyt-yilmaz-kurumsal-site
   git remote add origin https://github.com/emrahguler635/cuneyt-yilmaz.git
   git push -u origin main
   ```

3. **GitHub Pages'i etkinleştirin**
   - Depo sayfasında **Settings** → **Pages**
   - "Source" kısmında **Deploy from a branch** seçin
   - Branch: `main` / Folder: `/ (root)` seçin
   - **Save** tıklayın

4. **Site adresi**
   - Birkaç dakika sonra site şu adreste yayında olacak:
   - `https://emrahguler635.github.io/cuneyt-yilmaz/`

---

## Kurulum / Çalıştırma (Yerel)
Bu site statik (HTML/CSS/JS) bir projedir.

### 1) Klasörü açın
`index.html` dosyasını çift tıklayarak açabilirsiniz.

### 2) (Önerilen) Basit bir yerel sunucu ile çalıştırın
Bazı tarayıcılar yerel dosyada (file://) JS/CSS davranışlarını kısıtlayabilir.

Python yüklüyse:

- Windows / macOS / Linux:
  - Python 3:
    - Proje klasöründe terminal açın ve:
      `python -m http.server 8000`
    - Tarayıcıdan: http://localhost:8000

## Görselleri Değiştirme
Görseller `assets/img/` altındadır.
- Slider: `slide-1.png`, `slide-2.png`, `slide-3.png`
- Haberler: `news-1.jpg`, `news-2.jpg`, `news-3.jpg`
- Profil: `profile.jpg`

Kendi görsellerinizle aynı isimle değiştirmeniz yeterlidir.
