# Free Claude Code - Termux Installer

🚀 Автоматический установщик Free Claude Code для Android (Termux)

## ⚡ Быстрая установка

```bash
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh | bash
```

Или скачайте и запустите:

```bash
# Скачайте установщик
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh -o install.sh

# Сделайте исполняемым
chmod +x install.sh

# Запустите
./install.sh
```

## 🎯 После установки

### Запуск сервера

```bash
~/start_fcc_server.sh
```

### Запуск Claude Code

В новом терминале:

```bash
~/start_fcc_claude.sh
```

### Настройка

1. Откройте в браузере: `http://127.0.0.1:8082/admin`
2. Вставьте ваш API ключ
3. Выберите модель
4. Сохраните настройки

## 📋 Что устанавливается

- ✅ Python 3.14
- ✅ uv (Python package manager)
- ✅ Claude Code CLI
- ✅ Free Claude Code proxy
- ✅ Все необходимые зависимости
- ✅ Скрипты быстрого запуска

## 📖 Документация

- [Быстрый старт](docs/QUICK_START.md) - Быстрое начало работы
- [Руководство по установке](docs/INSTALLATION_GUIDE.md) - Полное руководство
- [Termux документация](docs/TERMUX_README.md) - Подробная документация
- [Обзор пакета](docs/PACKAGE_OVERVIEW.md) - Описание пакета
- [Распространение](docs/DISTRIBUTION.md) - Инструкции по распространению

## 🔧 Полезные команды

```bash
# Проверка установки
bash ~/free-claude-code-termux/scripts/check_install.sh

# Запуск в фоне
nohup ~/start_fcc_server.sh > server.log 2>&1 &

# Проверка логов
tail -f server.log

# Остановка сервера
pkill fcc-server
```

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

### Проверьте систему

```bash
bash ~/free-claude-code-termux/scripts/check_install.sh
```

## 📱 Системные требования

- **Android**: 5.0+
- **Termux**: 0.119+ (из F-Droid)
- **Память**: минимум 2 ГБ свободной
- **Интернет**: стабильное соединение

## 🎓 Где взять API ключ?

### Бесплатные варианты

1. **DeepSeek** - https://platform.deepseek.com/
   - Бесплатный API
   - Хорошие модели

2. **NVIDIA NIM** - https://build.nvidia.com/
   - Бесплатный tier
   - Llama модели

3. **OpenRouter** - https://openrouter.ai/
   - Много моделей
   - Доступные цены

## 📁 Структура проекта

```
free-claude-code-termux/
├── README.md
├── scripts/
│   ├── termux_installer.sh    # Полный установщик
│   ├── quick_install.sh       # Быстрый установщик
│   └── check_install.sh       # Проверка установки
├── config/
│   ├── termux_env.sh          # Переменные окружения
│   └── config_examples.yaml   # Примеры конфигураций
└── docs/
    ├── QUICK_START.md         # Быстрый старт
    ├── INSTALLATION_GUIDE.md  # Руководство по установке
    ├── TERMUX_README.md       # Termux документация
    ├── PACKAGE_OVERVIEW.md    # Обзор пакета
    └── DISTRIBUTION.md        # Распространение
```

## 🎉 Особенности

✅ **Автоматическая установка** - всё делается автоматически
✅ **Проверка системы** - диагностика перед установкой
✅ **Цветной вывод** - понятный прогресс
✅ **Скрипты запуска** - готовые команды
✅ **Конфигурации** - примеры настроек
✅ **Документация** - подробные инструкции
✅ **Диагностика** - проверка установки
✅ **Поддержка** - решение проблем

## 🔄 Обновление

```bash
# Обновление системы
pkg update && pkg upgrade

# Обновление Free Claude Code
uv tool upgrade --force git+https://github.com/Alishahryar1/free-claude-code.git
```

## 📞 Поддержка

- GitHub: https://github.com/Alishahryar1/free-claude-code
- Issues: https://github.com/Alishahryar1/free-claude-code/issues

## 📄 Лицензия

MIT License

---

**Создано с ❤️ для Android пользователей**

*Время установки: 5-15 минут*
*Сложность: Легко*
*Результат: Полностью рабочий Free Claude Code на Android!*