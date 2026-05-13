# Free Claude Code - Termux Installer

## Версия
1.0.0

## Дата создания
2026-05-13

## Описание
Автоматический установщик Free Claude Code для Android (Termux)

## Структура проекта
```
free-claude-code-termux/
├── README.md                    # Основная документация
├── LICENSE                      # Лицензия MIT
├── .gitignore                   # Игнорируемые файлы
├── CHANGELOG.md                 # История изменений
├── scripts/                     # Установочные скрипты
│   ├── termux_installer.sh     # Полный установщик
│   ├── quick_install.sh        # Быстрый установщик
│   └── check_install.sh        # Проверка установки
├── config/                      # Конфигурационные файлы
│   ├── termux_env.sh           # Переменные окружения
│   └── config_examples.yaml   # Примеры конфигураций
└── docs/                        # Документация
    ├── QUICK_START.md          # Быстрый старт
    ├── INSTALLATION_GUIDE.md   # Руководство по установке
    ├── TERMUX_README.md        # Termux документация
    ├── PACKAGE_OVERVIEW.md     # Обзор пакета
    └── DISTRIBUTION.md         # Распространение
```

## Установка

### Быстрая установка
```bash
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh | bash
```

### Пошаговая установка
```bash
# 1. Скачайте установщик
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh -o install.sh

# 2. Сделайте исполняемым
chmod +x install.sh

# 3. Запустите
./install.sh
```

## Использование

### Запуск сервера
```bash
~/start_fcc_server.sh
```

### Запуск Claude Code
```bash
~/start_fcc_claude.sh
```

### Настройка
Откройте в браузере: `http://127.0.0.1:8082/admin`

## Требования

- Android 5.0+
- Termux 0.119+ (из F-Droid)
- Минимум 2 ГБ свободной памяти
- Стабильное интернет-соединение

## Поддерживаемые API провайдеры

- OpenRouter
- DeepSeek
- NVIDIA NIM
- Kimi
- Wafer
- LM Studio (локальный)
- Ollama (локальный)

## Лицензия

MIT License - см. файл LICENSE

## Поддержка

GitHub: https://github.com/Alishahryar1/free-claude-code-termux