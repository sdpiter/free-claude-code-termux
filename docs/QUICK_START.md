# 🚀 Free Claude Code - Termux Quick Start

## ⚡ Быстрая установка (3 команды)

```bash
# 1. Скачайте и запустите установщик
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code/main/termux_installer.sh | bash

# 2. Запустите сервер
~/start_fcc_server.sh

# 3. В новом терминале запустите Claude Code
~/start_fcc_claude.sh
```

## 🎯 После установки

Откройте в браузере: `http://127.0.0.1:8082/admin`

Вставьте API ключ от одного из провайдеров:
- **OpenRouter**: https://openrouter.ai/
- **DeepSeek**: https://platform.deepseek.com/
- **NVIDIA NIM**: https://build.nvidia.com/

## 📱 Где взять API ключ?

### OpenRouter (рекомендуется)
1. Зайдите на https://openrouter.ai/
2. Зарегистрируйтесь
3. Получите API ключ в настройках
4. Вставьте в админ-панели

### DeepSeek (бесплатно)
1. Зайдите на https://platform.deepseek.com/
2. Зарегистрируйтесь
3. Получите бесплатный API ключ
4. Вставьте в админ-панели

### NVIDIA NIM (бесплатно)
1. Зайдите на https://build.nvidia.com/
2. Зарегистрируйтесь
3. Получите бесплатный API ключ
4. Вставьте в админ-панели

## 🔧 Полезные команды

```bash
# Проверка установки
bash check_install.sh

# Просмотр инструкций
cat ~/FCC_INSTRUCTIONS.txt

# Запуск в фоне
nohup ~/start_fcc_server.sh > server.log 2>&1 &

# Проверка логов
tail -f server.log

# Остановка сервера
pkill fcc-server
```

## 🆘 Проблемы?

### Установщик не работает?
```bash
chmod +x termux_installer.sh
bash termux_installer.sh
```

### Сервер не запускается?
```bash
# Проверьте порт
netstat -tuln | grep 8082

# Остановите если занят
lsof -ti:8082 | xargs kill -9
```

### Проверьте систему
```bash
bash check_install.sh
```

## 📖 Полная документация

Смотрите `INSTALLATION_GUIDE.md` для подробных инструкций.

## ✅ Что установится?

- Python 3.14
- uv package manager
- Claude Code CLI
- Free Claude Code proxy
- Все зависимости

## 🎉 Готово!

После установки у вас будет полностью рабочий Free Claude Code на Android!

---

**Время установки**: 5-15 минут
**Требуемая память**: ~2 ГБ
**Интернет**: нужен для установки и работы