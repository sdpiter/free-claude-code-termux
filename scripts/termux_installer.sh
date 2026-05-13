#!/usr/bin/env bash
#
# Free Claude Code - Termux Installer
# Автоматический установщик Free Claude Code для Android (Termux)
# Версия: 1.0.0
#

set -e

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Функции для вывода
print_header() {
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║   🚀 Free Claude Code - Termux Installer                  ║"
    echo "║                                                            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_step() {
    echo -e "${CYAN}📋 $1${NC}"
}

# Проверка прав root
check_root() {
    print_step "Проверка прав доступа..."
    if [ "$(id -u)" = "0" ]; then
        print_error "Не запускайте этот скрипт от root!"
        exit 1
    fi
    print_success "Права доступа в порядке"
}

# Проверка интернет-соединения
check_internet() {
    print_step "Проверка интернет-соединения..."
    if ! ping -c 1 -W 5 google.com &> /dev/null; then
        print_error "Нет интернет-соединения!"
        exit 1
    fi
    print_success "Интернет-соединение есть"
}

# Проверка свободного места
check_disk_space() {
    print_step "Проверка свободного места..."
    local free_space=$(df -m . | tail -1 | awk '{print $4}')
    if [ "$free_space" -lt 2048 ]; then
        print_error "Недостаточно свободного места! Нужно минимум 2 ГБ"
        exit 1
    fi
    print_success "Свободного места: ${free_space} МБ"
}

# Проверка версии Android
check_android_version() {
    print_step "Проверка версии Android..."
    local android_version=$(getprop ro.build.version.release)
    local major_version=$(echo $android_version | cut -d. -f1)

    if [ "$major_version" -lt 5 ]; then
        print_error "Требуется Android 5.0 или выше!"
        exit 1
    fi
    print_success "Версия Android: $android_version"
}

# Обновление пакетов Termux
update_packages() {
    print_step "Обновление пакетов Termux..."
    pkg update -y
    pkg upgrade -y
    print_success "Пакеты обновлены"
}

# Установка зависимостей
install_dependencies() {
    print_step "Установка зависимостей..."
    pkg install -y python git curl wget unzip tar
    print_success "Зависимости установлены"
}

# Установка uv
install_uv() {
    print_step "Установка uv (Python package manager)..."

    if command -v uv &> /dev/null; then
        print_info "uv уже установлен"
        return
    fi

    # Проверяем, работаем ли в Termux
    if [ -n "$TERMUX_VERSION" ]; then
        print_info "Обнаружен Termux, устанавливаем uv через pip..."
        pip install --upgrade pip
        pip install uv
    else
        # Стандартная установка для Linux/Mac
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi

    export PATH="$HOME/.local/bin:$PATH"

    if ! command -v uv &> /dev/null; then
        print_error "Не удалось установить uv"
        exit 1
    fi

    print_success "uv установлен"
}

# Установка Free Claude Code
install_free_claude_code() {
    print_step "Установка Free Claude Code..."

    if command -v fcc-server &> /dev/null; then
        print_info "Free Claude Code уже установлен"
        return
    fi

    uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git

    if ! command -v fcc-server &> /dev/null; then
        print_error "Не удалось установить Free Claude Code"
        exit 1
    fi

    print_success "Free Claude Code установлен"
}

# Создание скриптов запуска
create_startup_scripts() {
    print_step "Создание скриптов запуска..."

    # Скрипт запуска сервера
    cat > ~/start_fcc_server.sh << 'EOF'
#!/usr/bin/env bash
# Free Claude Code Server Launcher

echo "🚀 Запуск Free Claude Code Server..."
fcc-server --host 0.0.0.0 --port 8082
EOF

    chmod +x ~/start_fcc_server.sh

    # Скрипт запуска Claude Code
    cat > ~/start_fcc_claude.sh << 'EOF'
#!/usr/bin/env bash
# Free Claude Code CLI Launcher

echo "🤖 Запуск Free Claude Code CLI..."
fcc
EOF

    chmod +x ~/start_fcc_claude.sh

    print_success "Скрипты запуска созданы"
}

# Настройка окружения
setup_environment() {
    print_step "Настройка окружения..."

    # Добавление uv в PATH
    if ! grep -q "uv" ~/.bashrc; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    fi

    # Создание папки для конфигураций
    mkdir -p ~/.config/fcc

    print_success "Окружение настроено"
}

# Создание конфигурации по умолчанию
create_default_config() {
    print_step "Создание конфигурации по умолчанию..."

    cat > ~/.config/fcc/config.yaml << 'EOF'
# Free Claude Code Configuration

# API Settings
api:
  # API Provider: openrouter, deepseek, nvidia, kimi, wafer, lmstudio, ollama
  provider: openrouter
  api_key: ""
  base_url: ""

# Model Settings
model:
  name: "anthropic/claude-3.5-sonnet"
  temperature: 0.7
  max_tokens: 4096

# Server Settings
server:
  host: "0.0.0.0"
  port: 8082
  debug: false

# Cache Settings
cache:
  enabled: true
  ttl: 3600

# Rate Limiting
rate_limit:
  enabled: true
  requests_per_minute: 60

# CORS
cors:
  enabled: true
  origins: ["*"]
EOF

    print_success "Конфигурация создана"
}

# Отображение инструкций
show_instructions() {
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗"
    echo "║                  🎉 Установка завершена!                            ║"
    echo "╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${CYAN}📋 Следующие шаги:${NC}"
    echo ""
    echo -e "1. ${YELLOW}Запустите сервер:${NC}"
    echo -e "   ${GREEN}~/start_fcc_server.sh${NC}"
    echo ""
    echo -e "2. ${YELLOW}В новом терминале запустите Claude Code:${NC}"
    echo -e "   ${GREEN}~/start_fcc_claude.sh${NC}"
    echo ""
    echo -e "3. ${YELLOW}Откройте в браузере:${NC}"
    echo -e "   ${GREEN}http://127.0.0.1:8082/admin${NC}"
    echo ""
    echo -e "4. ${YELLOW}Вставьте ваш API ключ и выберите модель${NC}"
    echo ""
    echo -e "${CYAN}📚 Где взять API ключ:${NC}"
    echo ""
    echo -e "• ${GREEN}DeepSeek${NC} - https://platform.deepseek.com/ (бесплатно)"
    echo -e "• ${GREEN}NVIDIA NIM${NC} - https://build.nvidia.com/ (бесплатно)"
    echo -e "• ${GREEN}OpenRouter${NC} - https://openrouter.ai/ (доступно)"
    echo ""
    echo -e "${CYAN}🔧 Полезные команды:${NC}"
    echo ""
    echo -e "• ${GREEN}~/start_fcc_server.sh${NC} - запуск сервера"
    echo -e "• ${GREEN}~/start_fcc_claude.sh${NC} - запуск Claude Code"
    echo -e "• ${GREEN}pkill fcc-server${NC} - остановка сервера"
    echo ""
    echo -e "${CYAN}📖 Документация:${NC}"
    echo -e "   https://github.com/Alishahryar1/free-claude-code-termux"
    echo ""
}

# Главная функция
main() {
    print_header

    # Проверки
    check_root
    check_internet
    check_disk_space
    check_android_version

    echo ""
    print_info "Начинаем установку..."
    echo ""

    # Установка
    update_packages
    install_dependencies
    install_uv
    install_free_claude_code
    create_startup_scripts
    setup_environment
    create_default_config

    echo ""
    show_instructions

    print_success "Установка успешно завершена!"
}

# Запуск
main