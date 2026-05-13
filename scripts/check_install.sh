#!/data/data/com.termux/files/usr/bin/bash

#############################################
# Free Claude Code - Installation Checker
# Проверка установки и диагностика
#############################################

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${GREEN}"
    echo "========================================"
    echo "  Free Claude Code - Проверка установки"
    echo "========================================"
    echo -e "${NC}"
}

print_status() {
    local name=$1
    local status=$2
    local version=$3

    if [ "$status" = "ok" ]; then
        echo -e "${GREEN}✅ $name${NC}"
        if [ -n "$version" ]; then
            echo -e "   Версия: $version"
        fi
    elif [ "$status" = "warning" ]; then
        echo -e "${YELLOW}⚠️  $name${NC}"
        if [ -n "$version" ]; then
            echo -e "   $version"
        fi
    else
        echo -e "${RED}❌ $name${NC}"
        if [ -n "$version" ]; then
            echo -e "   $version"
        fi
    fi
}

check_command() {
    local cmd=$1
    local name=$2

    if command -v $cmd &> /dev/null; then
        local version=$($cmd --version 2>&1 | head -n 1 || echo "установлен")
        print_status "$name" "ok" "$version"
        return 0
    else
        print_status "$name" "error" "не установлен"
        return 1
    fi
}

check_file() {
    local file=$1
    local name=$2

    if [ -f "$file" ]; then
        print_status "$name" "ok" "существует"
        return 0
    else
        print_status "$name" "error" "не найден"
        return 1
    fi
}

check_directory() {
    local dir=$1
    local name=$2

    if [ -d "$dir" ]; then
        print_status "$name" "ok" "существует"
        return 0
    else
        print_status "$name" "error" "не найден"
        return 1
    fi
}

check_port() {
    local port=$1
    local name=$2

    if netstat -tuln 2>/dev/null | grep -q ":$port "; then
        print_status "$name" "warning" "порт занят"
        return 1
    else
        print_status "$name" "ok" "порт свободен"
        return 0
    fi
}

check_internet() {
    if ping -c 1 google.com &> /dev/null; then
        print_status "Интернет" "ok" "доступен"
        return 0
    else
        print_status "Интернет" "error" "недоступен"
        return 1
    fi
}

check_disk_space() {
    local free_space=$(df ~ | tail -1 | awk '{print $4}')
    local free_gb=$((free_space / 1024 / 1024))

    if [ $free_gb -gt 2 ]; then
        print_status "Дисковое пространство" "ok" "${free_gb} ГБ свободно"
        return 0
    else
        print_status "Дисковое пространство" "warning" "менее 2 ГБ свободно"
        return 1
    fi
}

main() {
    print_header

    local errors=0
    local warnings=0

    echo -e "${BLUE}📱 Система:${NC}"
    check_internet || ((errors++))
    check_disk_space || ((warnings++))
    echo ""

    echo -e "${BLUE}🔧 Базовые пакеты:${NC}"
    check_command "git" "Git" || ((errors++))
    check_command "python" "Python" || ((errors++))
    check_command "pip" "Pip" || ((errors++))
    check_command "curl" "Curl" || ((errors++))
    check_command "wget" "Wget" || ((errors++))
    check_command "node" "Node.js" || ((errors++))
    check_command "npm" "NPM" || ((errors++))
    echo ""

    echo -e "${BLUE}📦 Python инструменты:${NC}"
    check_command "uv" "uv" || ((errors++))
    check_command "python3.14" "Python 3.14" || ((errors++))
    echo ""

    echo -e "${BLUE}🤖 Claude Code:${NC}"
    check_command "claude" "Claude Code CLI" || ((errors++))
    check_command "fcc-server" "Free Claude Code" || ((errors++))
    echo ""

    echo -e "${BLUE}📁 Файлы и директории:${NC}"
    check_directory "$HOME/.local/bin" "Local bin" || ((warnings++))
    check_directory "$HOME/.config/fcc" "Config directory" || ((warnings++))
    check_file "$HOME/start_fcc_server.sh" "Start server script" || ((warnings++))
    check_file "$HOME/start_fcc_claude.sh" "Start Claude script" || ((warnings++))
    check_file "$HOME/FCC_INSTRUCTIONS.txt" "Instructions file" || ((warnings++))
    echo ""

    echo -e "${BLUE}🌐 Сеть:${NC}"
    check_port 8082 "Порт 8082" || ((warnings++))
    echo ""

    echo -e "${GREEN}========================================${NC}"
    if [ $errors -eq 0 ] && [ $warnings -eq 0 ]; then
        echo -e "${GREEN}✅ Всё установлено правильно!${NC}"
        echo ""
        echo "🚀 Для запуска:"
        echo "   ~/start_fcc_server.sh"
        echo ""
        echo "⚙️  После запуска откройте:"
        echo "   http://127.0.0.1:8082/admin"
    elif [ $errors -eq 0 ]; then
        echo -e "${YELLOW}⚠️  Установка завершена с предупреждениями${NC}"
        echo ""
        echo "Предупреждения: $warnings"
        echo "Ошибки: $errors"
        echo ""
        echo "Система должна работать, но проверьте предупреждения выше."
    else
        echo -e "${RED}❌ Обнаружены ошибки!${NC}"
        echo ""
        echo "Ошибки: $errors"
        echo "Предупреждения: $warnings"
        echo ""
        echo "Рекомендуется переустановить:"
        echo "bash termux_installer.sh"
    fi
    echo -e "${GREEN}========================================${NC}"

    return $errors
}

main
exit $?