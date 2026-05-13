#!/data/data/com.termux/files/usr/bin/bash

#############################################
# Free Claude Code - Quick Installer
# Быстрая установка в одну команду
#############################################

set -e

echo "🚀 Free Claude Code - Быстрая установка"
echo "========================================"
echo ""

# Обновление и установка базовых пакетов
pkg update && pkg upgrade -y && \
pkg install -y git python python-pip curl wget nodejs make clang && \

# Установка uv
curl -LsSf https://astral.sh/uv/install.sh | sh && \

# Настройка PATH
export PATH="$HOME/.local/bin:$PATH" && \
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && \

# Установка Python 3.14
uv python install 3.14 && \

# Установка Claude Code
npm install -g @anthropic-ai/claude-code && \

# Установка Free Claude Code
uv tool install --force git+https://github.com/Alishahryar1/free-claude-code.git && \

# Создание скриптов запуска
cat > ~/start_fcc.sh << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
export PATH="$HOME/.local/bin:$PATH"
fcc-server
EOF
chmod +x ~/start_fcc.sh && \

echo ""
echo "✅ Установка завершена!"
echo ""
echo "🚀 Для запуска:"
echo "   ~/start_fcc.sh"
echo ""
echo "⚙️  После запуска откройте:"
echo "   http://127.0.0.1:8082/admin"
echo ""
echo "📝 Для просмотра инструкций:"
echo "   cat ~/FCC_INSTRUCTIONS.txt"
echo ""