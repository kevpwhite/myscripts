# Smart MKV Remux Script

This script batch-processes `.mkv` video files in a directory, checking the audio type and converting them intelligently to `.mp4` for direct playback in Jellyfin, Plex, or other media servers.

---

## 🎯 What It Does

- Scans `.mkv` files in the specified directory
- Detects whether the first audio stream is 5.1 surround (6 channels)
- If 5.1 audio is found:
  - Converts the audio to **AAC 5.1 (384 kbps)** while preserving the video stream
- If stereo or other audio is found:
  - Remuxes the file without any re-encoding (lossless)
- Skips files that already have a `.mp4` version in the same directory

---

## 🛠 Requirements

- `ffmpeg`
- `ffprobe`
- Bash-compatible shell

Tested on:
- Debian 12
- Ubuntu-based distros
- TrueNAS SCALE VM with Debian container

---

## 📦 Install on Debian-Based Systems

```bash
sudo apt update
sudo apt install ffmpeg
```

---

## ⚙️ Setup Instructions

### 1. Clone or download this repository

```bash
git clone https://github.com/kevpwhite/myscripts.git
cd media-remux
```

> Or simply download `remux-mkv.sh` directly if not using Git.

---

### 2. Edit the script and set the source directory

Open the script in your editor and change the `SOURCE_DIR` variable at the top:

```bash
SOURCE_DIR="/path/to/your/mkv/files"
```

Example:

```bash
SOURCE_DIR="/mnt/entertainment/movies"
```

---

### 3. Make the script executable

```bash
chmod +x remux-mkv.sh
```

---

### 4. Run the script

```bash
./remux-mkv.sh
```

---

## 💡 Example Output

```bash
Scanning for .mkv files in: /mnt/entertainment/movies
Processing Avatar.The.Way.of.Water.mkv (Audio: 6)
5.1 audio detected — converting audio to AAC 5.1
Finished: Avatar.The.Way.of.Water.mp4

Processing The.Matrix.mkv (Audio: 2)
Stereo or other — remuxing without audio conversion
Finished: The.Matrix.mp4
```

---

## ⚠️ Notes

- The script only processes `.mkv` files.
- Original `.mkv` files are **not deleted**.
- Already-existing `.mp4` files are skipped automatically.
- Only the **first audio stream** is inspected and retained.
- Subtitles and additional audio tracks are **not preserved** in this version.

---

## 🧠 Why Use This?

Many `.mkv` files include unsupported audio formats like DTS, TrueHD, or FLAC — especially in Blu-ray rips. These trigger transcoding on platforms like Jellyfin and Plex, causing:

- High CPU usage
- Playback delays or buffering
- Failure to play on mobile or web clients

This script ensures compatibility and enables **direct play** by converting just the audio to AAC where needed, leaving the video untouched.

---

## 📜 License

MIT License — free to use, modify, and share.
