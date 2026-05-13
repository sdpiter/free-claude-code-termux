#!/usr/bin/env bash
#
# Free Claude Code - Quick Termux Installer
# Быстрый установщик Free Claude Code для Android (Termux)
# Версия: 1.0.0
#

set -e

# Цвета для вывода
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🚀 Free Claude Code - Quick Installer${NC}"
echo ""

# Обновление и установка
echo -e "${YELLOW}📦 Установка зависимостей...${NC}"
pkg update -y
pkg install -y python python-dev git curl

# Установка uv
echo -e "${YELLOW}📦 Установка uv...${NC}"
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Установка Free Claude Code
echo -e "${YELLOW}📦 Установка Free Claude Code...${NC}"
uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git

# Создание скриптов запуска
echo -e "${YELLOW}📦 Создание скриптов запуска...${NC}"

cat > ~/start_fcc_server.sh << 'EOF'
#!/usr/bin/env bash
fcc-server --host 0.0.0.0 --port 8082
EOF
chmod +x ~/start_fcc_server.sh

cat > ~/start_fcc_claude.sh << 'EOF'
#!/usr/bin/env bash
fcc
EOF
chmod +x ~/start_fcc_claude.sh

# Настройка окружения
if ! grep -q "uv" ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

mkdir -p ~/.config/fcc

echo ""
echo -e "${GREEN}✅ Установка завершена!${NC}"
echo ""
echo -e "${CYAN}Запуск:${NC}"
echo -e "  ${GREEN}~/start_fcc_server.sh${NC}"
echo -e "  ${GREEN}~/start_fcc_claude.sh${NC}"
echo ""
echo -e "${CYAN}Настройка:${NC}"
echo -e "  ${GREEN}http://127.0.0.1:8082/admin${NC}"
echo ""