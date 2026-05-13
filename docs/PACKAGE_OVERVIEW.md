# 📦 Free Claude Code - Termux Installation Package

## 🎉 Пакет готов!

Автоматический установщик Free Claude Code для Android (Termux) успешно создан!

## 📁 Созданные файлы

### 🚀 Установочные скрипты

1. **`termux_installer.sh`** - Полный установщик
   - Проверка системы и интернета
   - Установка всех зависимостей
   - Создание скриптов запуска
   - Генерация инструкций
   - Цветной вывод и прогресс

2. **`quick_install.sh`** - Быстрый установщик
   - Минимум проверок
   - Максимальная скорость
   - Одна команда для установки

3. **`check_install.sh`** - Проверка установки
   - Диагностика всех компонентов
   - Проверка портов и файлов
   - Выявление проблем
   - Цветной отчёт

### ⚙️ Конфигурационные файлы

4. **`termux_env.sh`** - Переменные окружения
   - PATH настройки
   - API ключи
   - Серверные настройки
   - Логирование

5. **`config_examples.yaml`** - Примеры конфигураций
   - config.yaml
   - models.json
   - .env.example
   - admin_config.json

### 📖 Документация

6. **`TERMUX_README.md`** - Полная документация
   - Подробные инструкции
   - Решение проблем
   - Полезные команды
   - Оптимизация

7. **`INSTALLATION_GUIDE.md`** - Руководство по установке
   - Все варианты установки
   - Конфигурация
   - Обновление
   - Структура файлов

8. **`QUICK_START.md`** - Быстрый старт
   - 3 команды для установки
   - Где взять API ключи
   - Основные команды
   - Решение проблем

## ⚡ Как использовать

### Вариант 1: Быстрая установка (рекомендуется)

```bash
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code/main/termux_installer.sh | bash
```

### Вариант 2: Пошаговая установка

```bash
# 1. Скачайте установщик
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code/main/termux_installer.sh -o install.sh

# 2. Сделайте исполняемым
chmod +x install.sh

# 3. Запустите
./install.sh
```

### Вариант 3: Из локальных файлов

```bash
# Если файлы уже скачаны
bash termux_installer.sh
```

## 🎯 После установки

### Запуск

```bash
# Запуск сервера
~/start_fcc_server.sh

# В новом терминале - запуск Claude Code
~/start_fcc_claude.sh
```

### Настройка

1. Откройте: `http://127.0.0.1:8082/admin`
2. Вставьте API ключ
3. Выберите модель
4. Сохраните

## 🔧 Диагностика

```bash
# Проверка установки
bash check_install.sh

# Просмотр инструкций
cat ~/FCC_INSTRUCTIONS.txt

# Проверка логов
tail -f ~/.config/fcc/logs/server.log
```

## 📋 Что устанавливается

✅ Python 3.14
✅ uv (package manager)
✅ Claude Code CLI
✅ Free Claude Code proxy
✅ Git, Curl, Wget
✅ Node.js, NPM
✅ Все зависимости
✅ Скрипты запуска
✅ Конфигурации

## 🆘 Решение проблем

### Установщик не запускается

```bash
chmod +x termux_installer.sh
bash termux_installer.sh
```

### Ошибки с Python

```bash
pkg install -y python python-dev
```

### uv не работает

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
```

### Сервер не запускается

```bash
netstat -tuln | grep 8082
lsof -ti:8082 | xargs kill -9
```

### Проверка системы

```bash
bash check_install.sh
```

## 📱 Системные требования

- **Android**: 5.0+
- **Termux**: 0.119+ (из F-Droid)
- **Память**: минимум 2 ГБ
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

## 📖 Документация

- **QUICK_START.md** - Быстрый старт
- **INSTALLATION_GUIDE.md** - Полное руководство
- **TERMUX_README.md** - Подробная документация
- **check_install.sh** - Диагностика

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

GitHub: https://github.com/Alishahryar1/free-claude-code

## 📄 Лицензия

MIT License

---

**Пакет создан: 2026-05-13**
**Версия: 1.0**
**Статус: ✅ Готов к использованию**

## 🚀 Быстрый старт

```bash
# Одна команда для установки
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code/main/termux_installer.sh | bash

# Запуск
~/start_fcc_server.sh

# Настройка
# http://127.0.0.1:8082/admin
```

**Время установки**: 5-15 минут
**Сложность**: Легко
**Результат**: Полностью рабочий Free Claude Code на Android! 🎉