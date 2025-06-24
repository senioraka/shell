#!/bin/bash

# Boshlanish sanasi
start_date="2021-01-01"
# Tugash sanasi (bugungi sana)
end_date=$(date +%Y-%m-%d)
# Har kuni nechta commit
commits_per_day=20

# Temp fayl yaratamiz
touch temp.txt
git add temp.txt

current_date="$start_date"

while [[ "$current_date" < "$end_date" ]]; do
  for ((i=1; i<=$commits_per_day; i++)); do
    # Har bir commit uchun vaqt yasaymiz (i * 2 daqiqa oraliqda)
    commit_time=$(date -d "$current_date + $((i * 2)) minutes" +"%Y-%m-%dT%H:%M:%S")

    # Temp faylga tasodifiy text yozib commit qilamiz
    echo "Commit number $i on $current_date" >> temp.txt
    git add temp.txt

    # Sana bilan commit
    GIT_AUTHOR_DATE="$commit_time" \
    GIT_COMMITTER_DATE="$commit_time" \
    git commit -m "Fake commit $i on $current_date"
  done

  # Keyingi kun
  current_date=$(date -I -d "$current_date + 1 day")
done

echo "✅ Barcha commitlar yaratildi!"
echo "👉 Endi GitHub'ga push qil: git push origin main --force"
