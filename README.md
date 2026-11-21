# huwei-skill：虎科同學站台 SKILL

以圖搜圖（CLIP，本機 CPU）＋ AI 確認（gpt-5.6-luna）認虎尾地標。給 `4-learn.4impact.cc` 的 agent 用。

```
huwei/
├── SKILL.md      說明書：同學說什麼 → agent 跑哪個指令；哪些事不准做
├── huwei.mjs     唯一的工具：ask / add / album / exam / miss
└── data/
    ├── album/<地標>/   相簿（同學可加，檔名 u-*）
    ├── exam/<地標>/    考卷（-正面 / -難）＋ _非地標/
    └── calib/          校準門檻用的非地標照（不考）
```

## 安裝（站台）

```bash
git clone https://github.com/4-learn/huwei-skill /tmp/huwei-skill && bash /tmp/huwei-skill/install.sh
echo "sk-..." > $DSH_HOME/skills/huwei/data/.openai_key   # 老師設定，或用 OPENAI_API_KEY
```

## 指令

| 指令 | 做什麼 |
|---|---|
| `ask <照片...>` | 以圖搜圖找前 3 名 → AI 看參考照確認；最像的 < 0.72 直接「不認得」 |
| `ask --plain <照片...>` | 對照組：不查相簿，AI 直接猜 |
| `add <地標> <照片...>` | 加進相簿；自動擋重複與考卷題目 |
| `album` | 相簿統計 |
| `exam [--plain] [--limit N]` | 考試，記錄歷史並和上次比較 |
| `miss [地標]` | 上次答錯的照片 |

基準（2026-11-21，Commons 照片）：正面 100%、難角度 92%、非地標說不認得 90%，88 題約 45 秒。
