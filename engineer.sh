#!/bin/bash

# === CONFIGURATION ===
GIT_AUTHOR_NAME="Shamir Enor"
GIT_AUTHOR_EMAIL="azamjonbro@gmail.com"

git config user.name "$GIT_AUTHOR_NAME"
git config user.email "$GIT_AUTHOR_EMAIL"

touch pixel.txt

# Engineer matnining 7 qatordan iborat pixel shakli
PIXEL_MATRIX=(
"  #     ##    ###   ###   ###   ###   ###   ###  "
" # #   # #   #     #     #     #     #     #     "
"###   ###    ##    ##    ##    ##    ##    ##    "
"# #   # #     #     #     #     #     #     #    "
"# #   # #    ##    ##    ##    ##    ##    ##    "
"# #   # #   #     #     #     #     #     #      "
"# #   ###   ###   ###   ###   ###   ###   ###    "
)

# Sana boshlanishi: 2022-yilning birinchi yakshanbasi
start_date="2022-01-02"

for ((col=0; col<${#PIXEL_MATRIX[0]}; col++)); do
  for ((row=0; row<7; row++)); do
    char="${PIXEL_MATRIX[$row]:$col:1}"
    if [[ "$char" == "#" ]]; then
      weeks=$col
      day_of_week=$row
      offset_days=$((weeks * 7 + day_of_week))
      commit_date=$(date -d "$start_date + $offset_days days" +"%Y-%m-%d")

      echo "🟩 Pixel ($col,$row) — $commit_date — 20 commits"

      for ((c=1; c<=20; c++)); do
        time_offset="$((c * 2)) minutes"
        full_time=$(date -d "$commit_date $time_offset" +"%Y-%m-%dT%H:%M:%S")

        echo "Engineer pixel $col,$row - $c" >> pixel.txt
        git add pixel.txt
        GIT_AUTHOR_DATE="$full_time" GIT_COMMITTER_DATE="$full_time" \
        git commit -m "Pixel $col,$row commit $c" > /dev/null 2>&1
      done
    fi
  done
done

echo ""
echo "✅ 'ENGINEER' yozuvi 2022-yil contribution graphga chizildi!"
echo "📤 Endi push qil: git remote add origin https://github.com/senioraka/YANGI-REPO && git push -u origin main --force"
