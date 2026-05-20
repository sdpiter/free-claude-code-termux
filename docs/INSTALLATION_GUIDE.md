# 📖 Руководство по установке - Free Claude Code Termux

## 📋 Содержание

1. [Системные требования](#системные-требования)
2. [Подготовка](#подготовка)
3. [Установка](#установка)
4. [Настройка](#настройка)
5. [Проверка](#проверка)
6. [Удаление](#удаление)
7. [Обновление](#обновление)
8. [Решение проблем](#решение-проблем)

## 📱 Системные требования

### Обязательные
- **Android**: 5.0 или выше
- **Termux**: 0.119 или выше (из F-Droid)
- **Память**: минимум 2 ГБ свободной
- **Интернет**: стабильное соединение

### Рекомендуемые
- **Android**: 7.0 или выше
- **Память**: 4 ГБ свободной
- **Процессор**: 4 ядра или больше

## 🛠️ Подготовка

### 1. Установка Termux

**Важно:** Устанавливайте только из F-Droid!

```bash
# Скачайте Termux из F-Droid
# https://f-droid.org/packages/com.termux/
```

### 2. Настройка Termux

```bash
# Обновите пакеты
pkg update && pkg upgrade

# Установите необходимые пакеты
pkg install -y python python-dev git curl wget

# Разрешите доступ к хранилищу (если нужно)
termux-setup-storage
```

### 3. Проверка системы

```bash
# Проверьте версию Android
getprop ro.build.version.release

# Проверьте свободное место
df -h

# Проверьте интернет
ping google.com
```

## 📥 Установка

### Способ 1: Автоматическая установка (рекомендуется)

```bash
# Запустите установщик одной командой
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh | bash
```

### Способ 2: Пошаговая установка

```bash
# 1. Скачайте установщик
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh -o install.sh

# 2. Сделайте исполняемым
chmod +x install.sh

# 3. Запустите
./install.sh
```

### Способ 3: Быстрая установка

```bash
# Быстрая установка без лишних проверок
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/quick_install.sh | bash
```

### Способ 4: Ручная установка

```bash
# 1. Установите зависимости
pkg update -y
pkg install -y python python-dev git curl

# 2. Установите uv
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# 3. Установите Free Claude Code
uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git

# 4. Создайте скрипты запуска
cat > ~/start_fcc_server.sh << 'EOF'
#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"
fcc-server --host 0.0.0.0 --port 8082
EOF
chmod +x ~/start_fcc_server.sh

cat > ~/start_fcc_claude.sh << 'EOF'
#!/usr/bin/env bash
export PATH="$HOME/.local/bin:$PATH"
fcc-claude
EOF
chmod +x ~/start_fcc_claude.sh

# 5. Настройте окружение
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
mkdir -p ~/.config/fcc
```

## ⚙️ Настройка

### 1. Получение API ключа

**Бесплатные варианты:**

#### DeepSeek
1. Перейдите на https://platform.deepseek.com/
2. Зарегистрируйтесь
3. Получите API ключ
4. Ключ начинается с `sk-`

#### NVIDIA NIM
1. Перейдите на https://build.nvidia.com/
2. Зарегистрируйтесь
3. Получите API ключ
4. Ключ начинается с `nvapi-`

#### OpenRouter
1. Перейдите на https://openrouter.ai/
2. Зарегистрируйтесь
3. Пополните баланс
4. Получите API ключ
5. Ключ начинается с `sk-or-v1-`

### 2. Настройка через веб-интерфейс

```bash
# Запустите сервер
~/start_fcc_server.sh
```

1. Откройте в браузере: `http://127.0.0.1:8082/admin`
2. Вставьте ваш API ключ
3. Выберите модель
4. Настройте параметры
5. Сохраните настройки

### 3. Настройка через конфигурационный файл

```bash
# Отредактируйте конфигурацию
nano ~/.config/fcc/config.yaml
```

Пример конфигурации:
```yaml
api:
  provider: "openrouter"
  api_key: "sk-or-v1-xxxxxxxxxxxxxxxx"
  base_url: "https://openrouter.ai/api/v1"

model:
  name: "anthropic/claude-3.5-sonnet"
  temperature: 0.7
  max_tokens: 4096

server:
  host: "0.0.0.0"
  port: 8082
  debug: false
```

## ✅ Проверка

### 1. Проверка установки

```bash
# Запустите скрипт проверки
bash ~/free-claude-code-termux/scripts/check_install.sh
```

### 2. Проверка компонентов

```bash
# Проверьте Python
python --version

# Проверьте uv
uv --version

# Проверьте Free Claude Code
fcc-server --version
fcc-claude --version
```

### 3. Проверка сервера

```bash
# Запустите сервер
~/start_fcc_server.sh

# В новом терминале проверьте
curl http://127.0.0.1:8082/health
```

### 4. Проверка CLI

```bash
# Запустите Claude Code
~/start_fcc_claude.sh

# Попробуйте команду
"Привет! Как дела?"
```

## 🗑️ Удаление

### Полное удаление

```bash
# 1. Остановите сервер
pkill fcc-server

# 2. Удалите Free Claude Code
uv tool uninstall free-claude-code

# 3. Удалите скрипты
rm ~/start_fcc_server.sh
rm ~/start_fcc_claude.sh

# 4. Удалите конфигурацию
rm -rf ~/.config/fcc

# 5. Удалите uv (опционально)
rm -rf ~/.local/bin/uv
rm -rf ~/.local/share/uv

# 6. Очистите PATH
nano ~/.bashrc
# Удалите строку с uv
```

### Частичное удаление

```bash
# Только удаление конфигурации
rm -rf ~/.config/fcc

# Только удаление скриптов
rm ~/start_fcc_server.sh
rm ~/start_fcc_claude.sh
```

## 🔄 Обновление

### Обновление системы

```bash
# Обновите Termux
pkg update && pkg upgrade

# Обновите Python
pkg install -y python python-dev
```

### Обновление Free Claude Code

```bash
# Обновите Free Claude Code
uv tool upgrade --force git+https://github.com/Alishahryar1/free-claude-code.git

# Или переустановите
uv tool uninstall free-claude-code
uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git
```

### Обновление скриптов

```bash
# Скачайте новые скрипты
cd ~/free-claude-code-termux
git pull

# Или скачайте заново
curl -L https://raw.githubusercontent.com/Alishahryar1/free-claude-code-termux/main/scripts/termux_installer.sh -o install.sh
chmod +x install.sh
./install.sh
```

## 🆘 Решение проблем

### Проблема: Установщик не запускается

**Решение:**
```bash
chmod +x install.sh
bash install.sh
```

### Проблема: Ошибки с Python

**Решение:**
```bash
pkg install -y python python-dev
pkg reinstall python
```

### Проблема: Нет интернет-соединения

**Решение:**
```bash
# Проверьте соединение
ping google.com

# Перезапустите Termux
# Настройки → Termux → Очистить кэш

# Проверьте VPN/Proxy
```

### Проблема: Недостаточно места

**Решение:**
```bash
# Проверьте место
df -h

# Очистите кэш Termux
pkg clean

# Удалите ненужные пакеты
pkg autoremove
```

### Проблема: uv не найден

**Решение:**
```bash
# Добавьте в PATH
export PATH="$HOME/.local/bin:$PATH"

# Или добавьте в ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Проблема: Сервер не запускается

**Решение:**
```bash
# Проверьте установку
bash ~/free-claude-code-termux/scripts/check_install.sh

# Проверьте логи
cat ~/.config/fcc/logs/server.log

# Проверьте порт
netstat -tuln | grep 8082

# Попробуйте другой порт
fcc-server --port 8083
```

### Проблема: Ошибки API

**Решение:**
```bash
# Проверьте API ключ
cat ~/.config/fcc/config.yaml

# Проверьте соединение с API
curl https://openrouter.ai/api/v1/models

# Попробуйте другой провайдер
```

### Проблема: Медленная работа

**Решение:**
```bash
# Увеличьте память
# Настройки → Termux → Termux:Boot

# Используйте кэш
# Включите в config.yaml:
cache:
  enabled: true
  ttl: 3600
```

## 📚 Дополнительная документация

- [Быстрый старт](QUICK_START.md) - Быстрое начало
- [Termux документация](TERMUX_README.md) - Подробная документация
- [Обзор пакета](PACKAGE_OVERVIEW.md) - Описание пакета
- [Распространение](DISTRIBUTION.md) - Инструкции по распространению

## 📞 Поддержка

- GitHub: https://github.com/Alishahryar1/free-claude-code-termux
- Issues: https://github.com/Alishahryar1/free-claude-code-termux/issues
- Termux Wiki: https://wiki.termux.com/

---

**Удачи с установкой!** 🚀