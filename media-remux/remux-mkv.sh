#!/bin/bash

SOURCE_DIR="/mnt/entertainment/movies"
cd "$SOURCE_DIR" || { echo "Directory not found: $SOURCE_DIR"; exit 1; }

echo "Scanning for .mkv files in: $SOURCE_DIR"

for file in *.mkv; do
    [ -e "$file" ] || continue  # Skip if no .mkv files

    base="${file%.mkv}"
    output="${base}.mp4"

    if [ -f "$output" ]; then
        echo "Skipping: $output already exists"
        continue
    fi

    # Get number of audio channels from the first audio stream
    channels=$(ffprobe -v error -select_streams a:0 \
        -show_entries stream=channels -of csv=p=0 "$file")

    echo "Processing $file (Audio: ${channels:-unknown})"

    if [ "$channels" = "6" ]; then
        echo "5.1 audio detected — converting audio to AAC 5.1"
        ffmpeg -i "$file" \
            -map 0:v -map 0:a:0 \
            -c:v copy \
            -c:a aac -b:a 384k -ac 6 \
            "$output"
    else
        echo "Stereo or other — remuxing without audio conversion"
        ffmpeg -i "$file" \
            -map 0:v -map 0:a:0 \
            -c:v copy \
            -c:a copy \
            "$output"
    fi

    echo "Finished: $output"
done

echo "All done."
