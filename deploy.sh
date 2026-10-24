#!/bin/bash

# Скрипт для автоматической загрузки на GitHub
# Использование: ./deploy.sh USERNAME TOKEN

if [ $# -lt 2 ]; then
    echo "Использование: $0 <username> <token>"
    echo "Пример: $0 john-doe ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    exit 1
fi

USERNAME=$1
TOKEN=$2
REPO="hogwarts-app"

echo "🚀 Загрузка Hogwarts Reader & Editor на GitHub..."
echo "Пользователь: $USERNAME"
echo "Репозиторий: $REPO"
echo ""

# Создаём репозиторий
echo "📦 Создаём репозиторий..."
curl -s -X POST \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO\",\"description\":\"Hogwarts Reader & Editor - PWA для чтения и редактирования текстов\",\"private\":false,\"auto_init\":false}"

echo ""
echo "✅ Репозиторий создан!"
echo ""

# Инициализируем git
echo "📁 Инициализируем git..."
git init
git add .
git commit -m "Initial commit: Hogwarts Reader & Editor PWA"

# Добавляем remote
git remote add origin https://$USERNAME:$TOKEN@github.com/$USERNAME/$REPO.git

# Пушим
echo "📤 Загружаем файлы..."
git push -u origin main

echo ""
echo "✅ Загрузка завершена!"
echo ""
echo "🌐 Ваш сайт будет доступен через 1-2 минуты по адресу:"
echo "https://$USERNAME.github.io/$REPO/"
echo ""
echo " Чтобы установить как десктопное приложение:"
echo "1. Откройте ссылку выше в Chrome/Edge"
echo "2. Нажмите на иконку установки в адресной строке"
echo "3. Подтвердите установку"
echo ""
echo "⚙️ Для включения GitHub-интеграции:"
echo "1. Откройте приложение"
echo "2. Нажмите ⚙️ (настройки)"
echo "3. Введите ваш GitHub токен"
echo ""
