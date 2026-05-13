#!/data/data/com.termux/files/usr/bin/bash

#############################################
# Free Claude Code - Termux Installer
# Автоматический установщик для Android
#############################################

set -e  # Остановиться при ошибке

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функции для вывода
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Free Claude Code - Termux Installer"
    echo "========================================"
    echo -e "${NC}"
}

# Проверка root прав
check_root() {
    if [ "$EUID" -eq 0 ]; then
        print_warning "Запуск от root не рекомендуется"
    fi
}

# Проверка интернет-соединения
check_internet() {
    print_info "Проверка интернет-соединения..."
    if ping -c 1 google.com &> /dev/null; then
        print_success "Интернет доступен"
    else
        print_error "Нет интернет-соединения!"
        exit 1
    fi
}

# Обновление системы
update_system() {
    print_info "Обновление пакетов Termux..."
    pkg update && pkg upgrade -y
    print_success "Система обновлена"
}

# Установка базовых пакетов
install_base_packages() {
    print_info "Установка базовых пакетов..."
    pkg install -y git python python-pip curl wget nodejs make clang openssl libffi
    print_success "Базовые пакеты установлены"
}

# Установка uv
install_uv() {
    print_info "Установка uv (Python package manager)..."

    if command -v uv &> /dev/null; then
        print_success "uv уже установлен"
    else
        curl -LsSf https://astral.sh/uv/install.sh | sh
        print_success "uv установлен"
    fi

    # Добавление uv в PATH
    if ! grep -q "uv" ~/.bashrc; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        print_success "uv добавлен в PATH"
    fi

    export PATH="$HOME/.local/bin:$PATH"
}

# Установка Python 3.14
install_python() {
    print_info "Установка Python 3.14..."

    if command -v uv &> /dev/null; then
        uv python install 3.14
        print_success "Python 3.14 установлен"
    else
        print_error "uv не установлен!"
        exit 1
    fi
}

# Установка Claude Code CLI
install_claude_code() {
    print_info "Установка Claude Code CLI..."

    if command -v claude &> /dev/null; then
        print_success "Claude Code уже установлен"
    else
        npm install -g @anthropic-ai/claude-code
        print_success "Claude Code установлен"
    fi
}

# Установка Free Claude Code
install_free_claude_code() {
    print_info "Установка Free Claude Code proxy..."

    if command -v fcc-server &> /dev/null; then
        print_warning "Free Claude Code уже установлен"
        read -p "Переустановить? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git
            print_success "Free Claude Code переустановлен"
        fi
    else
        uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git
        print_success "Free Claude Code установлен"
    fi
}

# Создание директории для конфигурации
setup_config_dir() {
    print_info "Создание директории для конфигурации..."
    mkdir -p ~/.config/fcc
    print_success "Директория создана"
}

# Создание скрипта быстрого запуска
create_start_scripts() {
    print_info "Создание скриптов запуска..."

    # Скрипт запуска сервера
    cat > ~/start_fcc_server.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
export PATH="$HOME/.local/bin:$PATH"
echo "🚀 Запуск Free Claude Code сервера..."
fcc-server
EOF
    chmod +x ~/start_fcc_server.sh

    # Скрипт запуска Claude Code
    cat > ~/start_fcc_claude.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
export PATH="$HOME/.local/bin:$PATH"
echo "🤖 Запуск Claude Code..."
fcc-claude
EOF
    chmod +x ~/start_fcc_claude.sh

    print_success "Скрипты запуска созданы"
}

# Создание файла с инструкциями
create_instructions() {
    print_info "Создание файла с инструкциями..."

    cat > ~/FCC_INSTRUCTIONS.txt << 'EOF'
========================================
Free Claude Code - Инструкции
========================================

🚀 БЫСТРЫЙ ЗАПУСК:

1. Запуск сервера:
   ~/start_fcc_server.sh

2. В другом терминале запуск Claude Code:
   ~/start_fcc_claude.sh

⚙️ НАСТРОЙКА:

1. После запуска сервера откройте в браузере:
   http://127.0.0.1:8082/admin

2. Вставьте ваш API ключ от одного из провайдеров:
   - NVIDIA NIM: https://build.nvidia.com/
   - Kimi: https://platform.moonshot.cn/
   - Wafer: https://wafer.ai/
   - OpenRouter: https://openrouter.ai/
   - DeepSeek: https://platform.deepseek.com/
   - LM Studio: https://lmstudio.ai/ (локальный)
   - Ollama: https://ollama.ai/ (локальный)

3. Выберите модель и сохраните настройки

📱 ПОЛЕЗНЫЕ КОМАНДЫ:

- Обновление: pkg update && pkg upgrade
- Проверка установки: fcc-server --help
- Очистка кэша: pkg clean

🆘 РЕШЕНИЕ ПРОБЛЕМ:

Если сервер не запускается:
1. Проверьте, что порт 8082 свободен
2. Перезапустите Termux
3. Проверьте интернет-соединение

Если возникают ошибки с Python:
pkg install -y python-dev

Если uv не работает:
curl -LsSf https://astral.sh/uv/install.sh | sh

📞 ПОДДЕРЖКА:
GitHub: https://github.com/Alishahryar1/free-claude-code
EOF

    print_success "Инструкции созданы: ~/FCC_INSTRUCTIONS.txt"
}

# Проверка установки
verify_installation() {
    print_info "Проверка установки..."

    local all_good=true

    if command -v uv &> /dev/null; then
        print_success "uv установлен: $(uv --version)"
    else
        print_error "uv не установлен"
        all_good=false
    fi

    if command -v python3.14 &> /dev/null; then
        print_success "Python 3.14 установлен"
    else
        print_error "Python 3.14 не установлен"
        all_good=false
    fi

    if command -v claude &> /dev/null; then
        print_success "Claude Code установлен"
    else
        print_error "Claude Code не установлен"
        all_good=false
    fi

    if command -v fcc-server &> /dev/null; then
        print_success "Free Claude Code установлен"
    else
        print_error "Free Claude Code не установлен"
        all_good=false
    fi

    if [ "$all_good" = true ]; then
        return 0
    else
        return 1
    fi
}

# Главная функция
main() {
    print_header

    print_info "Начинаю установку Free Claude Code..."
    echo ""

    check_root
    check_internet
    update_system
    install_base_packages
    install_uv
    install_python
    install_claude_code
    install_free_claude_code
    setup_config_dir
    create_start_scripts
    create_instructions

    echo ""
    print_info "Проверка установки..."
    if verify_installation; then
        echo ""
        print_success "========================================"
        print_success "Установка успешно завершена!"
        print_success "========================================"
        echo ""
        print_info "Для запуска используйте:"
        print_info "  ~/start_fcc_server.sh"
        echo ""
        print_info "Для просмотра инструкций:"
        print_info "  cat ~/FCC_INSTRUCTIONS.txt"
        echo ""
        print_warning "После запуска сервера откройте:"
        print_warning "http://127.0.0.1:8082/admin"
        echo ""
    else
        echo ""
        print_error "Установка завершена с ошибками!"
        print_error "Проверьте сообщения выше и попробуйте снова."
        exit 1
    fi
}

# Запуск
main