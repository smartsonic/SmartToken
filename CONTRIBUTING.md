---
AIGC:
    ContentProducer: Minimax Agent AI
    ContentPropagator: Minimax Agent AI
    Label: AIGC
    ProduceID: "00000000000000000000000000000000"
    PropagateID: "00000000000000000000000000000000"
    ReservedCode1: 30460221008231ad4135d4e60cf8e5d56848db97d2115ed282b66f72e3dd6b5d679d91ddc3022100a5de92b16501133a2eb0f63680b880a87ed913b7afd4ea3c5983eeaf14beb147
    ReservedCode2: 304502207f5d863433c45e39fdbedfa4a3617bed82417542b284744af163015f30622738022100e3c871211ed7a5a721fb3621ea39c5665a48b652635795220e9baec6b45b92a1
---

# 贡献指南

感谢您对 SmartToken 项目的兴趣！我们非常欢迎并感谢社区的各种贡献，无论是代码改进、文档完善、Bug 报告还是新功能建议。

## 目录

- [行为准则](#行为准则)
- [快速开始](#快速开始)
- [开发环境设置](#开发环境设置)
- [开发流程](#开发流程)
- [代码规范](#代码规范)
- [测试要求](#测试要求)
- [提交信息规范](#提交信息规范)
- [Pull Request 流程](#pull-request-流程)
- [报告问题](#报告问题)
- [功能建议](#功能建议)
- [许可证](#许可证)

---

## 行为准则

参与本项目即表示您同意遵守我们的 [行为准则](CODE_OF_CONDUCT.md)。我们期望所有贡献者都能保持尊重和专业。

---

## 快速开始

```bash
# 1. Fork 项目到您的 GitHub 账户

# 2. 克隆您 fork 的仓库
git clone https://github.com/YOUR_USERNAME/smarttoken.git
cd smarttoken

# 3. 添加上游仓库
git remote add upstream https://github.com/smarttoken/smarttoken.git

# 4. 创建特性分支
git checkout -b feature/your-feature-name

# 5. 安装开发依赖
pip install -e ".[dev]"

# 6. 开始开发！
```

---

## 开发环境设置

### 系统要求

- Python 3.9 或更高版本
- Git
- Docker（可选，用于容器化开发）

### 安装开发依赖

```bash
# 克隆后进入目录
cd smarttoken

# 安装项目及开发依赖
pip install -e ".[dev]"

# 或使用 poetry（如果项目使用 poetry）
poetry install --with dev
```

### 运行测试

```bash
# 运行所有测试
pytest

# 运行特定测试文件
pytest tests/test_security.py

# 带覆盖率运行
pytest --cov=smarttoken --cov-report=html
```

### 代码质量检查

```bash
# 格式化代码
black smarttoken/
isort smarttoken/

# 代码检查
ruff check smarttoken/
mypy smarttoken/

# 全部检查
make lint
```

---

## 开发流程

### 创建特性分支

```bash
# 确保在最新主分支上
git checkout main
git pull upstream main

# 创建新分支
git checkout -b feature/awesome-feature
# 或
git checkout -b fix/bug-description
# 或
git checkout -b docs/improve-documentation
```

### 保持分支同步

在开发期间，定期从上游主分支拉取更新：

```bash
git fetch upstream
git rebase upstream/main
```

### 提交更改

```bash
# 查看更改
git status
git diff

# 暂存文件
git add path/to/changed/file.py

# 提交（使用规范的提交信息）
git commit -m "feat: add new routing algorithm"
```

### 推送并创建 PR

```bash
# 推送到您的 fork
git push origin feature/awesome-feature

# 在 GitHub 上创建 Pull Request
```

---

## 代码规范

### Python 代码规范

我们使用以下工具确保代码一致性：

- **Black** - 代码格式化
- **isort** - 导入排序
- **Ruff** - 代码检查（替代 flake8、pylint）
- **MyPy** - 类型检查

### 主要规范

1. **类型注解**
   - 所有公共函数和类应包含类型注解
   - 使用 `Optional` 而非 `Union[T, None]`

   ```python
   # ✅ 正确
   def process_request(prompt: str, model: Optional[str] = None) -> Dict[str, Any]:
       ...

   # ❌ 错误
   def process_request(prompt, model=None):
       ...
   ```

2. **文档字符串**
   - 所有公共模块、类、函数应包含 docstring
   - 使用 Google 风格的 docstring

   ```python
   def calculate_cost(input_tokens: int, output_tokens: int) -> float:
       """
       计算给定 token 数量的 API 调用成本。

       Args:
           input_tokens: 输入 token 数量
           output_tokens: 输出 token 数量

       Returns:
           总成本（美元）

       Raises:
               ValueError: 如果 token 数量为负数
       """
       if input_tokens < 0 or output_tokens < 0:
           raise ValueError("Token 数量不能为负数")
       ...
   ```

3. **导入顺序**
   - 标准库
   - 第三方库
   - 本地应用/库特定导入
   - 按字母排序

   ```python
   # 标准库
   import json
   import logging
   from pathlib import Path
   from typing import Any, Dict, Optional

   # 第三方库
   import httpx
   from fastapi import FastAPI

   # 本地导入
   from smarttoken.router import SmartRouter
   from smarttoken.security import SecurityManager
   ```

4. **命名规范**
   - 类名：`CamelCase`
   - 函数/变量：`snake_case`
   - 常量：`UPPER_SNAKE_CASE`
   - 私有成员：以 `_` 开头

   ```python
   # 类
   class SmartRouter:
       ...

   # 函数/变量
   def calculate_cost():
       max_retries = 3
       _private_cache = {}

   # 常量
   DEFAULT_TIMEOUT = 60
   MAX_TOKEN_LIMIT = 100000
   ```

### 安全规范

1. **敏感信息处理**
   - 永远不要在代码中硬编码 API Key 或密码
   - 使用环境变量或配置文件
   - 所有日志必须经过脱敏处理

2. **加密要求**
   - 使用 AES-256-GCM 进行加密
   - 使用 PBKDF2-HMAC-SHA256 进行密钥派生
   - 主密码不存储

---

## 测试要求

### 测试覆盖率

- 所有新功能必须包含测试
- 核心模块需要 80% 以上的覆盖率
- Bug 修复需要添加回归测试

### 测试文件命名

```
tests/
├── test_security.py      # 对应 smarttoken/security.py
├── test_router.py        # 对应 smarttoken/router.py
├── test_cache.py         # 对应 smarttoken/cache.py
└── ...
```

### 测试示例

```python
import pytest
from pathlib import Path
from smarttoken.security import SecurityManager

class TestSecurityManager:
    """安全模块测试"""

    def test_encrypt_decrypt(self, tmp_path):
        """测试加密解密功能"""
        manager = SecurityManager(data_dir=tmp_path)

        # 测试加密存储
        manager.setup_vault("test_password")
        manager.store_api_key("openai", "sk-test123")

        # 测试解密获取
        assert manager.get_api_key("openai") == "sk-test123"

    def test_sanitize_log(self):
        """测试日志脱敏"""
        # API Key 应被脱敏
        result = SecurityManager.sanitize_log("key: sk-abc123xyz789")
        assert "sk-abc123xyz789" not in result
        assert "[API_KEY_HIDDEN]" in result
```

### 运行测试

```bash
# 所有测试
pytest

# 特定文件
pytest tests/test_security.py -v

# 带覆盖率
pytest --cov=smarttoken --cov-report=term-missing

# 监控模式下开发
pytest --watch
```

---

## 提交信息规范

我们使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

### 格式

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### 类型

| 类型 | 说明 |
|------|------|
| `feat` | 新功能 |
| `fix` | Bug 修复 |
| `docs` | 文档更改 |
| `style` | 代码格式（不影响功能） |
| `refactor` | 重构（不是功能也不是修复） |
| `perf` | 性能优化 |
| `test` | 测试相关 |
| `chore` | 构建/工具更改 |

### 示例

```bash
# 功能
git commit -m "feat(router): add task type detection for code generation"

# 修复
git commit -m "fix(cache): resolve similarity threshold calculation error"

# 文档
git commit -m "docs: update README with new installation steps"

# 重构
git commit -m "refactor(security): extract encryption logic to separate module"
```

---

## Pull Request 流程

### PR 模板

当您创建 PR 时，请填写我们的模板：

```markdown
## 描述
请简要描述这个 PR 的目的和主要内容。

## 类型
- [ ] 新功能 (feat)
- [ ] Bug 修复 (fix)
- [ ] 文档更新 (docs)
- [ ] 代码重构 (refactor)
- [ ] 测试相关 (test)
- [ ] 其他 (chore)

## 相关问题
请使用 `Fixes #123` 或 `Relates to #456` 关联相关问题。

## 检查清单
- [ ] 代码遵循项目代码规范
- [ ] 添加了必要的测试
- [ ] 所有测试通过
- [ ] 文档已更新（如适用）
- [ ] 提交信息符合规范
```

### Review 流程

1. **自动化检查** - CI/CD 会自动运行：
   - 测试
   - 代码覆盖率
   - 代码质量检查
   - 类型检查

2. **Maintainer Review** - 项目维护者会：
   - 审查代码逻辑
   - 检查安全漏洞
   - 验证测试覆盖
   - 评估功能实现

3. **合并** - 当所有检查通过并获得至少 1 个维护者 approval 后：
   - 使用 Squash and Merge
   - 删除分支

---

## 报告问题

### 创建 Issue

请使用问题模板并包含：

1. **问题描述** - 清晰描述问题
2. **复现步骤** - 如何复现问题
3. **预期行为** - 应该发生什么
4. **实际行为** - 实际发生了什么
5. **环境信息**：
   - Python 版本
   - 操作系统
   - SmartToken 版本
   - 相关配置

### Issue 模板

```markdown
## 问题描述
[清晰描述问题]

## 复现步骤
1. [步骤1]
2. [步骤2]
3. [步骤3]

## 预期行为
[描述预期]

## 实际行为
[描述实际]

## 环境信息
- OS: [例如 macOS 13.0]
- Python: [例如 3.11.0]
- SmartToken: [例如 1.0.0]

## 额外信息
[任何其他有帮助的信息]
```

---

## 功能建议

### 建议新功能

我们非常欢迎新功能建议！请使用 Feature Request 模板：

```markdown
## 功能描述
描述您想要的功能

## 使用场景
这个功能解决什么问题？

## 提案解决方案
您认为如何实现最好？

## 备选方案
有哪些其他可能的方案？

## 其他信息
任何其他上下文或参考
```

### 优先级

我们根据以下因素评估功能优先级：

1. 社区需求程度
2. 与项目目标的契合度
3. 实现复杂度和维护成本
4. 安全性和性能影响

---

## 许可证

通过贡献代码，您同意将您的贡献按照 [Apache License 2.0](LICENSE) 许可证发布。

---

## 联系方式

- GitHub Issues: [https://github.com/smarttoken/smarttoken/issues](https://github.com/smarttoken/smarttoken/issues)
- 讨论区: [https://github.com/smarttoken/smarttoken/discussions](https://github.com/smarttoken/smarttoken/discussions)

---

再次感谢您的贡献！🎉
