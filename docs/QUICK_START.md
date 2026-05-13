# 🚀 Быстрый старт - Free Claude Code Termux

## ⚡ Установка за 3 шага

### 1. Установите Termux
Скачайте Termux из F-Droid: https://f-droid.org/packages/com.termux/

### 2. Запустите установщик
```bash
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh | bash
```

### 3. Настройте и запустите
```bash
# Запустите сервер
~/start_fcc_server.sh

# В новом терминале запустите Claude Code
~/start_fcc_claude.sh
```

Откройте в браузере: `http://127.0.0.1:8082/admin`

## 🎯 Первые шаги

### Получение API ключа

**Бесплатные варианты:**
- **DeepSeek** - https://platform.deepseek.com/ (бесплатно)
- **NVIDIA NIM** - https://build.nvidia.com/ (бесплатно)
- **OpenRouter** - https://openrouter.ai/ (доступно)

### Настройка

1. Откройте `http://127.0.0.1:8082/admin`
2. Вставьте ваш API ключ
3. Выберите модель
4. Сохраните настройки

## 💻 Основные команды

### Запуск
```bash
# Запуск сервера
~/start_fcc_server.sh

# Запуск Claude Code CLI
~/start_fcc_claude.sh
```

### Управление
```bash
# Остановка сервера
pkill fcc-server

# Проверка статуса
pgrep -f fcc-server

# Просмотр логов
tail -f ~/.config/fcc/logs/server.log
```

### Проверка установки
```bash
# Полная проверка
bash ~/free-claude-code-termux/scripts/check_install.sh
```

## 🔧 Конфигурация

### Изменение порта
```bash
# Отредактируйте скрипт запуска
nano ~/start_fcc_server.sh

# Измените порт
fcc-server --host 0.0.0.0 --port 8083
```

### Изменение модели
1. Откройте `http://127.0.0.1:8082/admin`
2. Выберите другую модель
3. Сохраните настройки

## 📱 Использование на Android

### В Termux
```bash
# Запуск в фоне
nohup ~/start_fcc_server.sh > server.log 2>&1 &

# Проверка логов
tail -f server.log
```

### В браузере на Android
1. Откройте Chrome/Firefox
2. Перейдите на `http://127.0.0.1:8082/admin`
3. Настройте и используйте

## 🆘 Решение проблем

### Установщик не запускается
```bash
chmod +x install.sh
bash install.sh
```

### Ошибки с Python
```bash
pkg install -y python python-dev
```

### Нет интернет-соединения
```bash
# Проверьте соединение
ping google.com

# Перезапустите Termux
# Настройки → Termux → Очистить кэш
```

### Сервер не запускается
```bash
# Проверьте установку
bash ~/free-claude-code-termux/scripts/check_install.sh

# Проверьте логи
cat ~/.config/fcc/logs/server.log
```

### Порт занят
```bash
# Найдите процесс
netstat -tuln | grep 8082

# Убейте процесс
pkill fcc-server

# Используйте другой порт
fcc-server --port 8083
```

## 📚 Дополнительная документация

- [Руководство по установке](INSTALLATION_GUIDE.md) - Полное руководство
- [Termux документация](TERMUX_README.md) - Подробная документация
- [Обзор пакета](PACKAGE_OVERVIEW.md) - Описание пакета
- [Распространение](DISTRIBUTION.md) - Инструкции по распространению

## 🎉 Готово!

Теперь вы можете использовать Free Claude Code на Android!

### Что дальше?

1. 📖 Изучите [документацию](docs/)
2. 🎨 Настройте под свои нужды
3. 🚀 Начните кодить с Claude Code
4. 📢 Поделитесь с друзьями

## 💡 Советы

- Используйте `nohup` для запуска в фоне
- Настройте автозапуск при необходимости
- Используйте `tmux` для нескольких сессий
- Регулярно проверяйте обновления

## 📞 Поддержка

- GitHub: https://github.com/Alishahryar1/free-claude-code-termux
- Issues: https://github.com/Alishahryar1/free-claude-code-termux/issues

---

**Удачи с Free Claude Code на Android!** 🚀