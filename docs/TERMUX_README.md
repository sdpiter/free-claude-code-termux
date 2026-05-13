# Free Claude Code - Termux Installer

🚀 Автоматический установщик Free Claude Code для Android (Termux)

## 📱 Что это?

Этот установщик автоматически настроит Free Claude Code на вашем Android телефоне через Termux. Вам не нужно вручную устанавливать зависимости - скрипт сделает всё за вас!

## ⚡ Быстрая установка

### Шаг 1: Установите Termux

Скачайте Termux из **F-Droid** (рекомендуется):
```
https://f-droid.org/packages/com.termux/
```

Или из Google Play (менее функциональная версия)

### Шаг 2: Запустите установщик

Откройте Termux и выполните:

```bash
# Скачайте установщик
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code/main/termux_installer.sh -o install.sh

# Сделайте исполняемым
chmod +x install.sh

# Запустите установку
./install.sh
```

Или одной командой:
```bash
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code/main/termux_installer.sh | bash
```

### Шаг 3: Дождитесь завершения

Установка займёт 5-15 минут в зависимости от скорости интернета.

## 🎯 После установки

### Запуск сервера:

```bash
~/start_fcc_server.sh
```

### Запуск Claude Code:

В **новом** терминале Termux:

```bash
~/start_fcc_claude.sh
```

### Настройка:

1. После запуска сервера откройте в браузере:
   ```
   http://127.0.0.1:8082/admin
   ```

2. Вставьте ваш API ключ от провайдера:
   - **NVIDIA NIM**: https://build.nvidia.com/
   - **Kimi**: https://platform.moonshot.cn/
   - **Wafer**: https://wafer.ai/
   - **OpenRouter**: https://openrouter.ai/
   - **DeepSeek**: https://platform.deepseek.com/
   - **LM Studio**: https://lmstudio.ai/ (локальный)
   - **Ollama**: https://ollama.ai/ (локальный)

3. Выберите модель и сохраните настройки

## 📋 Что устанавливается

- ✅ Python 3.14
- ✅ uv (Python package manager)
- ✅ Claude Code CLI
- ✅ Free Claude Code proxy
- ✅ Все необходимые зависимости
- ✅ Скрипты быстрого запуска

## 🔧 Полезные команды

```bash
# Обновление системы
pkg update && pkg upgrade

# Проверка установки
fcc-server --help

# Запуск сервера в фоне
nohup ~/start_fcc_server.sh > server.log 2>&1 &

# Проверка логов
tail -f server.log

# Остановка сервера
pkill fcc-server
```

## 🆘 Решение проблем

### Установщик не запускается

```bash
# Убедитесь, что файл исполняемый
chmod +x install.sh

# Или запустите напрямую через bash
bash install.sh
```

### Ошибки с Python

```bash
# Переустановите Python
pkg install -y python python-dev

# Проверьте версию
python --version
```

### uv не работает

```bash
# Переустановите uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Добавьте в PATH
export PATH="$HOME/.local/bin:$PATH"
```

### Сервер не запускается

```bash
# Проверьте, что порт свободен
netstat -tuln | grep 8082

# Если занят, остановите процесс
lsof -ti:8082 | xargs kill -9

# Перезапустите Termux
```

### Нет интернет-соединения

```bash
# Проверьте соединение
ping google.com

# Если не работает, проверьте настройки Termux:
termux-setup-storage
```

## 📱 Оптимизация для Termux

### Сохранение энергии

```bash
# Запускайте сервер только когда нужно
# Используйте nohup для фонового режима
nohup ~/start_fcc_server.sh > /dev/null 2>&1 &
```

### Автозапуск при старте Termux

Добавьте в `~/.bashrc`:

```bash
# Автозапуск сервера (раскомментируйте если нужно)
# ~/start_fcc_server.sh &
```

## 🔒 Безопасность

- Не делитесь своим API ключом
- Используйте HTTPS для API запросов
- Регулярно обновляйте пакеты
- Храните API ключи в безопасном месте

## 📊 Системные требования

- **Android**: 5.0+
- **Память**: минимум 2 ГБ свободной
- **Интернет**: стабильное соединение
- **Termux**: версия 0.119+

## 🎓 Дополнительные ресурсы

- [Free Claude Code GitHub](https://github.com/Alishahryar1/free-claude-code)
- [Termux Wiki](https://wiki.termux.com/)
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)

## 🤝 Поддержка

Если возникли проблемы:

1. Проверьте раздел "Решение проблем"
2. Посмотрите логи: `cat ~/FCC_INSTRUCTIONS.txt`
3. Создайте issue на GitHub

## 📝 Лицензия

MIT License - см. файл LICENSE в оригинальном репозитории

---

**Создано с ❤️ для Android пользователей**

*Последнее обновление: 2026-05-13*