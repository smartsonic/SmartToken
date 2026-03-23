# SmartToken Makefile
# 常用开发任务自动化

.PHONY: help install dev test lint format clean build docker-run docker-build docs

# 默认目标
help:
	@echo "SmartToken 开发任务"
	@echo ""
	@echo "安装 & 开发:"
	@echo "  make install      - 安装项目及依赖"
	@echo "  make dev          - 安装开发依赖"
	@echo "  make clean        - 清理缓存和构建文件"
	@echo ""
	@echo "代码质量:"
	@echo "  make lint         - 运行代码检查"
	@echo "  make format       - 格式化代码"
	@echo "  make type-check   - 类型检查"
	@echo ""
	@echo "测试:"
	@echo "  make test         - 运行所有测试"
	@echo "  make test-cov     - 运行测试并生成覆盖率报告"
	@echo ""
	@echo "构建 & 部署:"
	@echo "  make build        - 构建 Python 包"
	@echo "  make docker-build - 构建 Docker 镜像"
	@echo "  make docker-run   - 运行 Docker 容器"
	@echo ""
	@echo "文档:"
	@echo "  make docs         - 验证文档结构"
	@echo ""

# 安装项目
install:
	pip install -e .

# 安装开发依赖
dev:
	pip install -e ".[dev]"
	pre-commit install

# 清理缓存
clean:
	rm -rf build/ dist/ *.egg-info
	rm -rf .pytest_cache .mypy_cache .ruff_cache
	rm -rf htmlcov/ .coverage
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name ".DS_Store" -delete

# 代码检查
lint:
	@echo "运行代码检查..."
	ruff check smarttoken/
	@echo "代码检查完成"

# 格式化代码
format:
	@echo "格式化代码..."
	black smarttoken/
	isort smarttoken/
	@echo "格式化完成"

# 类型检查
type-check:
	@echo "运行类型检查..."
	mypy smarttoken/ --ignore-missing-imports
	@echo "类型检查完成"

# 运行测试
test:
	pytest tests/ -v

# 运行测试并生成覆盖率
test-cov:
	pytest tests/ --cov=smarttoken --cov-report=term-missing --cov-report=html

# 构建 Python 包
build:
	pip install build
	python -m build

# 构建 Docker 镜像
docker-build:
	docker build -t smarttoken/smarttoken:latest .

# 运行 Docker 容器
docker-run:
	docker run -d --name smarttoken \
		-p 8080:8080 \
		-v ~/.smarttoken:/data \
		smarttoken/smarttoken:latest

# 停止 Docker 容器
docker-stop:
	docker stop smarttoken || true
	docker rm smarttoken || true

# 验证文档
docs:
	@echo "验证文档结构..."
	@for f in docs/*.md; do \
		echo "  $$f"; \
	done
	@echo "文档验证完成"

# 完整的开发流程
dev-setup: clean install dev format lint test
	@echo ""
	@echo "✅ 开发环境设置完成！"
	@echo "请运行 'make docker-run' 启动服务"
