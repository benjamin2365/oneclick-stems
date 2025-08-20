from fastapi import FastAPI, File, UploadFile
import subprocess, os, shutil
from pathlib import Path

app = FastAPI()

UPLOAD_DIR = Path("uploads")
OUTPUT_DIR = Path("outputs")
UPLOAD_DIR.mkdir(exist_ok=True)
OUTPUT_DIR.mkdir(exist_ok=True)

@app.post("/separate/")
async def separate_audio(file: UploadFile = File(...)):
    filepath = UPLOAD_DIR / file.filename
    with open(filepath, "wb") as f:
        f.write(await file.read())

    # Run Demucs
    cmd = ["demucs", "-o", str(OUTPUT_DIR), str(filepath)]
    subprocess.run(cmd)

    return {"status": "success", "message": f"Processed {file.filename}", "output": str(OUTPUT_DIR)}
