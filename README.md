# OneClick Stems 🎶

A mobile + backend solution to separate MP3 into vocals, drums, bass, and instruments using **Demucs**.

## 🚀 Features
- Upload MP3 from Flutter mobile app
- Backend powered by FastAPI + Demucs
- Automatic APK builds with GitHub Actions

## 📂 Project Structure
- `backend/` → FastAPI + Demucs
- `mobile_flutter/` → Flutter mobile app
- `.github/workflows/` → CI/CD for APK

## 🔧 Run Backend
```bash
cd backend
docker build -t oneclick-stems .
docker run -d -p 8000:8000 oneclick-stems
