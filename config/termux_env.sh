#!/usr/bin/env bash
#
# Free Claude Code - Termux Environment Configuration
# Переменные окружения для Free Claude Code в Termux
# Версия: 1.0.0
#

# ============================================
# PATH Configuration
# ============================================

# Добавление uv в PATH
export PATH="$HOME/.local/bin:$PATH"

# Добавление Python scripts в PATH
export PATH="$HOME/.local/bin/python-scripts:$PATH"

# ============================================
# Python Configuration
# ============================================

# Python version
export PYTHON_VERSION="3.14"

# Python path
export PYTHONPATH="$HOME/.local/lib/python$PYTHON_VERSION/site-packages:$PYTHONPATH"

# Pip configuration
export PIP_NO_CACHE_DIR=1
export PIP_DISABLE_PIP_VERSION_CHECK=1

# ============================================
# Free Claude Code Configuration
# ============================================

# FCC home directory
export FCC_HOME="$HOME/.config/fcc"

# FCC data directory
export FCC_DATA="$FCC_HOME/data"

# FCC cache directory
export FCC_CACHE="$FCC_HOME/cache"

# FCC logs directory
export FCC_LOGS="$FCC_HOME/logs"

# FCC config file
export FCC_CONFIG="$FCC_HOME/config.yaml"

# ============================================
# Server Configuration
# ============================================

# Server host
export FCC_SERVER_HOST="0.0.0.0"

# Server port
export FCC_SERVER_PORT="8082"

# Server debug mode
export FCC_SERVER_DEBUG="false"

# ============================================
# API Configuration
# ============================================

# API provider (openrouter, deepseek, nvidia, kimi, wafer, lmstudio, ollama)
export FCC_API_PROVIDER="openrouter"

# API key (задается через интерфейс)
# export FCC_API_KEY=""

# API base URL (опционально)
# export FCC_API_BASE_URL=""

# ============================================
# Model Configuration
# ============================================

# Default model
export FCC_MODEL_NAME="anthropic/claude-3.5-sonnet"

# Model temperature
export FCC_MODEL_TEMPERATURE="0.7"

# Max tokens
export FCC_MODEL_MAX_TOKENS="4096"

# ============================================
# Cache Configuration
# ============================================

# Enable cache
export FCC_CACHE_ENABLED="true"

# Cache TTL (seconds)
export FCC_CACHE_TTL="3600"

# ============================================
# Rate Limiting Configuration
# ============================================

# Enable rate limiting
export FCC_RATE_LIMIT_ENABLED="true"

# Requests per minute
export FCC_RATE_LIMIT_RPM="60"

# ============================================
# CORS Configuration
# ============================================

# Enable CORS
export FCC_CORS_ENABLED="true"

# CORS origins
export FCC_CORS_ORIGINS="*"

# ============================================
# Logging Configuration
# ============================================

# Log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
export FCC_LOG_LEVEL="INFO"

# Log file
export FCC_LOG_FILE="$FCC_LOGS/server.log"

# ============================================
# Security Configuration
# ============================================

# Enable authentication
export FCC_AUTH_ENABLED="false"

# Admin password (задается через интерфейс)
# export FCC_ADMIN_PASSWORD=""

# ============================================
# Performance Configuration
# ============================================

# Max workers
export FCC_MAX_WORKERS="4"

# Request timeout (seconds)
export FCC_REQUEST_TIMEOUT="300"

# ============================================
# Development Configuration
# ============================================

# Development mode
export FCC_DEV_MODE="false"

# Hot reload
export FCC_HOT_RELOAD="false"

# ============================================
# Helper Functions
# ============================================

# Создание директорий FCC
create_fcc_dirs() {
    mkdir -p "$FCC_HOME"
    mkdir -p "$FCC_DATA"
    mkdir -p "$FCC_CACHE"
    mkdir -p "$FCC_LOGS"
}

# Проверка установки FCC
check_fcc_installation() {
    if command -v fcc-server &> /dev/null; then
        echo "✅ Free Claude Code установлен"
        return 0
    else
        echo "❌ Free Claude Code не установлен"
        return 1
    fi
}

# Запуск FCC сервера
start_fcc_server() {
    echo "🚀 Запуск Free Claude Code Server..."
    fcc-server --host "$FCC_SERVER_HOST" --port "$FCC_SERVER_PORT"
}

# Запуск FCC CLI
start_fcc_cli() {
    echo "🤖 Запуск Free Claude Code CLI..."
    fcc-claude
}

# Остановка FCC сервера
stop_fcc_server() {
    echo "🛑 Остановка Free Claude Code Server..."
    pkill fcc-server
}

# Проверка статуса FCC
check_fcc_status() {
    if pgrep -f "fcc-server" > /dev/null; then
        echo "✅ FCC сервер запущен"
        echo "🌐 Доступен по адресу: http://$FCC_SERVER_HOST:$FCC_SERVER_PORT"
    else
        echo "❌ FCC сервер не запущен"
    fi
}

# Просмотр логов FCC
view_fcc_logs() {
    if [ -f "$FCC_LOG_FILE" ]; then
        tail -f "$FCC_LOG_FILE"
    else
        echo "❌ Лог файл не найден: $FCC_LOG_FILE"
    fi
}

# ============================================
# Initialization
# ============================================

# Создание директорий при загрузке
create_fcc_dirs

# Вывод информации о конфигурации
if [ "$1" = "--info" ]; then
    echo "📋 Free Claude Code Configuration:"
    echo "   Home: $FCC_HOME"
    echo "   Data: $FCC_DATA"
    echo "   Cache: $FCC_CACHE"
    echo "   Logs: $FCC_LOGS"
    echo "   Config: $FCC_CONFIG"
    echo "   Server: http://$FCC_SERVER_HOST:$FCC_SERVER_PORT"
fi