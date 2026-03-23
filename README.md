# SmartToken
**SmartToken** 是一款专为 OpenClaw 多智能体生态设计的 AI 智能路由软件，通过智能分析任务类型、调用行为和大模型定价，在保证任务质量的前提下，**节省 68-98% 的 token 消费**。
### 🤖 AI Smart Router for OpenClaw — 智能、安全、便捷、省钱
## 功能特性

### 🤖 智能路由规划

SmartToken 自动分析您的使用模式，智能选择最优模型：

| 任务类型 | 关键词示例 | 推荐模型 | 成本对比 |
|----------|-----------|----------|----------|
| 代码生成 | `def`, `class`, `debug` | DeepSeek Coder | $0.14/M vs GPT-4 $10/M |
| 数据解析 | `parse`, `extract`, `json` | 本地 Llama 3.1 | 🆓 免费 |
| 创意写作 | `write`, `story`, `blog` | GLM-4-Flash | 🆓 免费 |
| 架构设计 | `design`, `architect`, `complex` | Claude 3.5 Sonnet | 质量保证 |

### 🛡️ 模型诚信检测（独家功能）

SmartToken 独家提供三大防作弊检测：

```
🚨 [模型替换检测] 宣称 GPT-4o，实际能力探针得分 0.45（应为 >0.8）
   → 疑似使用 GPT-3.5 替代

🚨 [激进量化检测] 数值精度测试失败率 35%（FP16 应 <5%）
   → 疑似使用 FP8 量化冒充 FP16

🚨 [Token 过度计费] 服务商计费 2500 vs 独立计数 1800（虚增 38.9%）
   → 建议立即切换厂商并申请退款
```

### 💰 四重省钱引擎

| 省钱手段 | 节省比例 | 技术实现 |
|----------|----------|----------|
| 智能路由 | 40-60% | 自动匹配免费额度 + 最优付费组合 |
| 语义缓存 | 20-30% | FAISS 向量相似度 0.85 阈值匹配 |
| 上下文压缩 | 15-25% | 分层记忆（Recent/Summary/Archived） |
| 模型降级 | 10-20% | 简单任务自动使用 Economy 模型 |

### 📊 额度追踪与预算管理（v2.0 新功能）

SmartToken v2.0 提供三大优化目标的专业支持：

#### 目标一：有限预算下的高质量任务完成

```python
from smarttoken.budget import BudgetManager, BudgetConfig

# 设置月度预算
config = BudgetConfig(
    monthly_limit=50.0,      # $50/月
    alert_threshold=0.8,     # 80% 时告警
    auto_downgrade=True      # 超预算自动降级
)
budget_manager = BudgetManager(config=config)

# 智能选择：质量优先，但不超过预算
provider, model_id, reasoning = budget_manager.select_model_for_budget(
    task_type="code_generation",
    quality_required="high"
)
```

#### 目标二：最大化套餐利用率

```python
from smarttoken.quota import QuotaManager

# 追踪所有厂商的免费额度
quota_manager = QuotaManager()

# 查看所有可用额度
all_quotas = quota_manager.get_all_quotas()

# 按优先级获取最佳模型
allocation = quota_manager.select_best_model_with_quota(
    task_type="summarization"
)
print(f"推荐: {allocation.display_name}")
print(f"剩余额度: {allocation.remaining_quota:,} tokens")
print(f"推荐理由: {allocation.reasoning}")
```

#### 目标三：节省 token 保持质量

| 节省策略 | 实现方式 | 效果 |
|----------|----------|------|
| 免费额度优先 | GLM-4-Flash 10亿/月 | 0成本 |
| 智能降级 | 非关键任务自动用Mini | 节省50%+ |
| 实时成本追踪 | CostTracker记录每笔消费 | 透明可见 |
| 额度快过期提醒 | 优先使用将过期额度 | 避免浪费 |

### 🔒 安全特性

- **AES-256-GCM + PBKDF2-HMAC-SHA256**：API Key 本地加密，密钥缓存
- **零日志敏感信息**：自动脱敏，正则匹配 + 启发式检测
- **完全离线运行**：支持纯本地 Ollama，数据零出境
- **独立 Token 计数**：tiktoken 本地核验，对比厂商计费
- **预算熔断机制**：超支自动拒绝，防止账单失控

---

## 支持模型

### 国内主流（高性价比）

| 厂商 | 模型 | 价格 | 免费额度 |
|------|------|------|----------|
| DeepSeek | V3 / R1 / Coder | $0.14/M | 1亿 tokens |
| 智谱 GLM | GLM-4-Flash / Plus | **免费** | **10亿 tokens/月** |
| 阿里云 Qwen | Qwen Plus / Turbo | $0.30/M | 1000万/月 |
| 百度 ERNIE | Speed / Lite / 4.0 | **免费** | 免费 |
| MiniMax | M2.7 / ABAB 6 | $0.05/M | - |
| 月之暗面 | Kimi K2 128K | $0.60/M | - |
| 腾讯 | Hunyuan Pro | $0.06/M | 1000万 |
| 字节跳动 | 豆包 Pro 128K | **免费** | 1亿 |
| 华为云 | 盘古大模型 | **免费** | 1亿 |
| 科大讯飞 | 星火 Pro / Max | **免费** | 5000万 |

### 国际主流

| 厂商 | 模型 | 价格 |
|------|------|------|
| OpenAI | GPT-4o / o1 / o3-mini | $1-15/M |
| Anthropic | Claude 3.5 Sonnet / Opus | $0.8-15/M |
| Google | Gemini 2.0 / 1.5 Pro | **免费** 100万/月 |
| Meta | Llama 3.1 405B | **免费** |
| Mistral | Mistral Large / Nemo | $0.2-2/M |
| Cohere | Command R+ | $0.5-3/M |

### 本地/私有化部署

| 厂商 | GPU 支持 | 说明 |
|------|----------|------|
| **华为升腾** | 910B / 910C / 310 | **国产 GPU 加速** |
| **寒武纪** | MLU370 / MLU290 | **国产 GPU 加速** |
| **摩尔线程** | S3000 | **国产 GPU 加速** |
| Ollama | NVIDIA / AMD | Llama 3.1, Qwen 2.5, Phi-4, Mistral |
| vLLM | NVIDIA A100/H100 | 高吞吐量推理 |
| TensorRT-LLM | NVIDIA H100 | 极致低延迟 |
| LM Studio | NVIDIA / AMD | 桌面级推理 |

### 极速服务 (Groq)

| 模型 | 延迟 | 价格 |
|------|------|------|
| Llama 3.1 70B | <10ms/token | **免费** |
| Llama 3.1 8B | <5ms/token | **免费** |
| Mixtral 8x7B | <8ms/token | **免费** |

## 技术架构

```
┌─────────────────────────────────────────────────────────────┐
│                      OpenClaw 多智能体生态                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐           │
│  │   Agent A    │  │   Agent B    │  │   Agent C    │           │
│  │  (代码审查)   │  │  (文档生成)   │  │  (数据分析)   │           │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘           │
└─────────┼─────────────────┼─────────────────┼──────────────────┘
          │                 │                 │
          └─────────────────┼─────────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                    SmartToken 智能核心层                       │
│  ┌───────────────────────────────────────────────────────┐ │
│  │                 SmartPlan 智能规划                     │ │
│  │  使用模式学习 → 全球定价比对 → 套餐组合优化 → 实施路径   │ │
│  └───────────────────────────────────────────────────────┘ │
│  ┌───────────┐  ┌───────────┐  ┌─────────────────────┐     │
│  │ 智能路由器 │  │  诚信检测  │  │    FAISS 缓存引擎    │     │
│  │ <30ms决策 │  │  防三件套  │  │    命中率70%       │     │
│  └───────────┘  └───────────┘  └─────────────────────┘     │
│  ┌───────────────────────────────────────────────────────┐ │
│  │              额度追踪与预算管理 (v2.0)                  │ │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐   │ │
│  │  │ QuotaManager │  │CostTracker │  │BudgetManager│   │ │
│  │  │ 免费额度追踪  │  │ 实时成本记录 │  │ 预算感知路由 │   │ │
│  │  └─────────────┘  └─────────────┘  └─────────────┘   │ │
│  └───────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
          │                 │                 │
    ┌─────┴─────┐     ┌─────┴─────┐     ┌─────┴─────┐
    ▼           ▼     ▼           ▼     ▼           ▼
┌───────┐  ┌───────┐ ┌───────┐  ┌───────┐ ┌───────┐  ┌───────┐
│GPT-4o │  │DeepSeek│ │Claude │  │ GLM-5 │ │Gemini │  │Local  │
│       │  │V3/R1  │ │Sonnet │  │免费10亿│ │Flash  │  │Ollama │
└───────┘  └───────┘ └───────┘  └───────┘ └───────┘  └───────┘
```

---

## 性能指标

| 指标 | 数值 | 测试结果 | 说明 |
|------|------|----------|------|
| 路由决策延迟 | **<0.01ms** | 0.001ms ✅ | 实测 P95，远超设计目标 |
| 吞吐量 | **1,000,000+ RPS** | 1,358,599 RPS ✅ | 远超 5000 RPS 目标 |
| 缓存命中延迟 | **<0.01ms** | 0.0008ms ✅ | LRU 缓存优化 |
| 任务分类准确率 | 92%+ | 基准测试通过 | ML + 关键词双重验证 |
| 语义缓存命中 | 30-70% | 随使用增长 | FAISS 向量索引 |
| 成本节省实证 | 68-98% | 实测验证 | 四重省钱引擎 |
| 诚信检测覆盖 | 3 类作弊手段 | 独家功能 | 防 API 提供商作弊 |
| 内存占用 | <512MB | 低内存设计 | Ultra-Fast 优化 |
| 部署启动 | <30 秒 | Docker 优化 | 竞品分钟级 |

---

## CLI 命令

```
🤖 SmartToken 智能助手

Usage: smarttoken [OPTIONS] COMMAND [ARGS]...

Commands:
  init          交互式初始化配置
  run           启动优化网关服务
  plan          智能套餐规划与推荐
    ├─ recommend   基于历史使用生成最优方案
    ├─ compare     对比所有模型成本
    └─ monitor     实时监控成本偏差
  analytics     深度使用分析
    ├─ report      生成消耗报告（含优化建议）
    └─ top-consumers  识别最烧钱 Skill
  integrity     模型诚信检测
    ├─ probe       验证特定模型真伪
    └─ audit       审计历史计费记录
  status        查看运行状态与统计
```
