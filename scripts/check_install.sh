#!/usr/bin/env bash
#
# Free Claude Code - Installation Checker
# Скрипт проверки установки Free Claude Code для Android (Termux)
# Версия: 1.0.0
#

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Счетчики
PASSED=0
FAILED=0
WARNINGS=0

# Функции для вывода
print_header() {
    echo -e "${CYAN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║   🔍 Free Claude Code - Installation Checker              ║"
    echo "║                                                            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✅ PASS${NC} - $1"
    ((PASSED++))
}

print_error() {
    echo -e "${RED}❌ FAIL${NC} - $1"
    ((FAILED++))
}

print_warning() {
    echo -e "${YELLOW}⚠️  WARN${NC} - $1"
    ((WARNINGS++))
}

print_info() {
    echo -e "${BLUE}ℹ️  INFO${NC} - $1"
}

print_section() {
    echo ""
    echo -e "${CYAN}━━━ $1 ━━━${NC}"
}

# Проверка команды
check_command() {
    local cmd=$1
    local name=$2

    if command -v $cmd &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -1)
        print_success "$name установлен: $version"
    else
        print_error "$name не установлен"
    fi
}

# Проверка файла
check_file() {
    local file=$1
    local name=$2

    if [ -f "$file" ]; then
        print_success "$name существует"
    else
        print_error "$name не найден"
    fi
}

# Проверка папки
check_dir() {
    local dir=$1
    local name=$2

    if [ -d "$dir" ]; then
        print_success "$name существует"
    else
        print_error "$name не найден"
    fi
}

# Проверка порта
check_port() {
    local port=$1
    local name=$2

    if netstat -tuln 2>/dev/null | grep -q ":$port "; then
        print_success "$name порт $port открыт"
    else
        print_warning "$name порт $port не используется"
    fi
}

# Проверка интернет-соединения
check_internet() {
    print_section "Проверка интернет-соединения"

    if ping -c 1 -W 5 google.com &> /dev/null; then
        print_success "Интернет-соединение есть"
    else
        print_error "Нет интернет-соединения"
    fi
}

# Проверка системы
check_system() {
    print_section "Проверка системы"

    # Версия Android
    local android_version=$(getprop ro.build.version.release)
    print_info "Версия Android: $android_version"

    # Архитектура
    local arch=$(uname -m)
    print_info "Архитектура: $arch"

    # Свободное место
    local free_space=$(df -m . | tail -1 | awk '{print $4}')
    if [ "$free_space" -ge 2048 ]; then
        print_success "Свободного места: ${free_space} МБ"
    else
        print_warning "Мало свободного места: ${free_space} МБ"
    fi

    # Память
    local total_mem=$(free -m | grep Mem | awk '{print $2}')
    print_info "Всего памяти: ${total_mem} МБ"
}

# Проверка Python
check_python() {
    print_section "Проверка Python"

    check_command "python" "Python"
    check_command "python3" "Python 3"

    # Проверка pip
    if command -v pip &> /dev/null; then
        print_success "pip установлен"
    else
        print_error "pip не установлен"
    fi
}

# Проверка uv
check_uv() {
    print_section "Проверка uv"

    check_command "uv" "uv"

    # Проверка PATH
    if echo $PATH | grep -q "$HOME/.local/bin"; then
        print_success "uv в PATH"
    else
        print_warning "uv не в PATH (добавьте в ~/.bashrc)"
    fi
}

# Проверка Free Claude Code
check_fcc() {
    print_section "Проверка Free Claude Code"

    check_command "fcc-server" "fcc-server"
    check_command "fcc-claude" "fcc-claude"

    # Проверка скриптов запуска
    check_file "$HOME/start_fcc_server.sh" "Скрипт запуска сервера"
    check_file "$HOME/start_fcc_claude.sh" "Скрипт запуска Claude Code"

    # Проверка конфигурации
    check_dir "$HOME/.config/fcc" "Папка конфигурации"
    check_file "$HOME/.config/fcc/config.yaml" "Файл конфигурации"
}

# Проверка процессов
check_processes() {
    print_section "Проверка процессов"

    if pgrep -f "fcc-server" > /dev/null; then
        print_success "fcc-server запущен"
    else
        print_warning "fcc-server не запущен"
    fi

    if pgrep -f "fcc-claude" > /dev/null; then
        print_success "fcc-claude запущен"
    else
        print_warning "fcc-claude не запущен"
    fi
}

# Проверка портов
check_ports() {
    print_section "Проверка портов"

    check_port 8082 "Free Claude Code"
}

# Проверка логов
check_logs() {
    print_section "Проверка логов"

    if [ -f "$HOME/.config/fcc/logs/server.log" ]; then
        local log_size=$(du -h "$HOME/.config/fcc/logs/server.log" | cut -f1)
        print_success "Лог сервера существует: $log_size"
    else
        print_warning "Лог сервера не найден"
    fi
}

# Проверка зависимостей
check_dependencies() {
    print_section "Проверка зависимостей"

    check_command "git" "Git"
    check_command "curl" "cURL"
    check_command "wget" "wget"
    check_command "tar" "tar"
    check_command "unzip" "unzip"
}

# Итоговый отчет
print_summary() {
    echo ""
    echo -e "${CYAN}━━━ Итоговый отчет ━━━${NC}"
    echo ""
    echo -e "${GREEN}✅ Пройдено: $PASSED${NC}"
    echo -e "${RED}❌ Ошибки: $FAILED${NC}"
    echo -e "${YELLOW}⚠️  Предупреждения: $WARNINGS${NC}"
    echo ""

    if [ $FAILED -eq 0 ]; then
        echo -e "${GREEN}🎉 Все проверки пройдены!${NC}"
        return 0
    else
        echo -e "${RED}❌ Обнаружены ошибки. Пожалуйста, исправьте их.${NC}"
        return 1
    fi
}

# Рекомендации
print_recommendations() {
    if [ $FAILED -gt 0 ] || [ $WARNINGS -gt 0 ]; then
        echo ""
        echo -e "${CYAN}━━━ Рекомендации ━━━${NC}"
        echo ""

        if [ $FAILED -gt 0 ]; then
            echo -e "${YELLOW}Для исправления ошибок:${NC}"
            echo -e "  1. Запустите установщик: ${GREEN}bash ~/free-claude-code-termux/scripts/termux_installer.sh${NC}"
            echo -e "  2. Или быстрый установщик: ${GREEN}bash ~/free-claude-code-termux/scripts/quick_install.sh${NC}"
            echo ""
        fi

        if ! echo $PATH | grep -q "$HOME/.local/bin"; then
            echo -e "${YELLOW}Добавьте uv в PATH:${NC}"
            echo -e "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.bashrc"
            echo -e "  source ~/.bashrc"
            echo ""
        fi

        if ! pgrep -f "fcc-server" > /dev/null; then
            echo -e "${YELLOW}Запустите сервер:${NC}"
            echo -e "  ${GREEN}~/start_fcc_server.sh${NC}"
            echo ""
        fi
    fi
}

# Главная функция
main() {
    print_header

    # Проверки
    check_internet
    check_system
    check_python
    check_uv
    check_fcc
    check_dependencies
    check_processes
    check_ports
    check_logs

    # Итог
    print_summary
    print_recommendations

    exit $FAILED
}

# Запуск
main