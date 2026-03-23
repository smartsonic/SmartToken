#!/usr/bin/env bash
#
# SmartToken 一键安装脚本
# 支持 Linux 和 macOS
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印函数
print_header() {
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║            SmartToken AI Smart Router                     ║"
    echo "║              智能 · 安全 · 便捷 · 省钱                   ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# 检查操作系统
check_os() {
    print_status "检测操作系统..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        OS="windows"
    else
        print_error "不支持的操作系统: $OSTYPE"
        exit 1
    fi

    print_success "检测到操作系统: $OS"
}

# 检查 Python 版本
check_python() {
    print_status "检查 Python 版本..."

    if ! command -v python3 &> /dev/null; then
        print_error "未找到 Python3，请先安装 Python 3.9 或更高版本"
        print_status "安装指南: https://www.python.org/downloads/"
        exit 1
    fi

    PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    PYTHON_MAJOR=$(python3 -c 'import sys; print(sys.version_info[0])')
    PYTHON_MINOR=$(python3 -c 'import sys; print(sys.version_info[1])')

    if [[ "$PYTHON_MAJOR" -lt 3 ]] || [[ "$PYTHON_MAJOR" -eq 3 && "$PYTHON_MINOR" -lt 9 ]]; then
        print_error "Python 版本过低，需要 Python 3.9+，当前版本: $PYTHON_VERSION"
        exit 1
    fi

    print_success "Python 版本: $PYTHON_VERSION"
}

# 检查 pip
check_pip() {
    print_status "检查 pip..."

    if ! python3 -m pip --version &> /dev/null; then
        print_error "未找到 pip，请先安装 pip"
        exit 1
    fi

    print_success "pip 可用"
}

# 安装 SmartToken
install_smarttoken() {
    print_status "安装 SmartToken..."

    # 升级 pip
    python3 -m pip install --upgrade pip

    # 安装 SmartToken
    pip install smarttoken

    print_success "SmartToken 安装完成"
}

# 验证安装
verify_installation() {
    print_status "验证安装..."

    if command -v smarttoken &> /dev/null; then
        VERSION=$(smarttoken --version 2>/dev/null || echo "未知")
        print_success "SmartToken 命令行工具已安装: $VERSION"
    else
        print_warning "smarttoken 命令未找到，尝试重新加载环境"
        if [[ "$SHELL" == *"zsh"* ]]; then
            source ~/.zshrc
        else
            source ~/.bashrc
        fi
    fi
}

# 创建配置目录
setup_config() {
    print_status "创建配置目录..."

    CONFIG_DIR="$HOME/.smarttoken"
    mkdir -p "$CONFIG_DIR"

    print_success "配置目录: $CONFIG_DIR"
}

# 显示完成信息
show_completion() {
    echo ""
    print_header
    echo ""
    echo -e "${GREEN}✅ 安装完成！${NC}"
    echo ""
    echo "下一步："
    echo "  1. 初始化配置："
    echo -e "     ${BLUE}smarttoken init${NC}"
    echo ""
    echo "  2. 启动服务："
    echo -e "     ${BLUE}smarttoken run${NC}"
    echo ""
    echo "  3. 查看帮助："
    echo -e "     ${BLUE}smarttoken --help${NC}"
    echo ""
    echo "文档：https://docs.smarttoken.dev"
    echo ""
}

# Docker 安装
install_docker() {
    print_status "使用 Docker 安装..."

    if ! command -v docker &> /dev/null; then
        print_error "未找到 Docker，请先安装 Docker"
        print_status "安装指南: https://docs.docker.com/get-docker/"
        exit 1
    fi

    print_status "拉取 Docker 镜像..."
    docker pull smarttoken/smarttoken:latest

    print_status "创建配置目录..."
    mkdir -p "$HOME/.smarttoken"

    print_status "启动容器..."
    docker run -d \
        --name smarttoken \
        -p 8080:8080 \
        -v "$HOME/.smarttoken:/data" \
        smarttoken/smarttoken:latest

    print_success "Docker 容器已启动"
    print_status "访问 http://localhost:8080 查看状态"
}

# 显示使用说明
show_usage() {
    echo ""
    print_header
    echo ""
    echo "使用方法："
    echo ""
    echo "  直接安装（需要 Python）："
    echo "    curl -fsSL https://smarttoken.dev/install.sh | bash"
    echo ""
    echo "  Docker 安装（推荐）："
    echo "    curl -fsSL https://smarttoken.dev/install.sh | bash -s docker"
    echo ""
    echo "  pip 安装："
    echo "    pip install smarttoken"
    echo ""
}

# 主函数
main() {
    print_header

    # 解析参数
    if [[ "$1" == "docker" ]]; then
        install_docker
        exit 0
    fi

    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        show_usage
        exit 0
    fi

    # 执行安装步骤
    check_os
    check_python
    check_pip
    install_smarttoken
    verify_installation
    setup_config
    show_completion
}

# 执行主函数
main "$@"
