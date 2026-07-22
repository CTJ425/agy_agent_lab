# Master Orchestrator Execution Pipeline

當收到開發需求時，Orchestrator 請依照以下 SOP 觸發與調度 Subagents，並即時更新 `agent_docs/PROGRESS.MD`：

---

## Phase 1: 架構規劃與 TASK 拆解 (Dual Planner Debate & HTML Output)
1. **更新 `PROGRESS.MD`**：標註進度為 `Phase 1: Planning`。
2. **Spawn `lead-architect`**：分析需求，產出 `PLAN_DRAFT.MD` 與 `DOCS.MD` 草稿。
3. **Spawn `critic-architect`**：對照實體 Codebase 進行嚴格審查，輸出 `PLAN_FEEDBACK.MD`。
4. **Debate Loop**：
   - 若 `Status: REJECTED` ➔ 重新 Spawn `lead-architect` 依反饋修正，再由 `critic-architect` 複審。
   - 若 `Status: APPROVED` ➔ 產出 `agent_docs/PLAN.MD` 與待辦任務 `agent_docs/TASK.MD`。
5. **HTML 渲染與 ⛔ HUMAN CHECKPOINT (強制阻斷)**：
   - **Spawn `lead-architect`** 將 `PLAN.MD` 與 `DOCS.MD` 渲染整合為 **`agent_docs/plan.html`**。
   - 提示使用者可開啟 `agent_docs/plan.html` 進行預覽審閱。
   - **必須等待使用者明確回覆（如「同意/Approve/繼續」）後，才可進入 Phase 2**。

---

## Phase 2: 依據 TASK.MD 實作與變更紀錄
1. **更新 `PROGRESS.MD`**：標註進度為 `Phase 2: Coding`。
2. **Spawn `senior-coder`**：
   - 讀取 `agent_docs/PLAN.MD` 與 `agent_docs/TASK.MD`。
   - 嚴格按項目實作，執行自我單元/元件測試。
   - **紀錄變更**：將已完成項目寫入 `agent_docs/TASKED.MD`，並於 `agent_docs/CHANGELOG.MD` 詳細載明。

---

## Phase 3: 雙重獨立審查、修復與自動 Git Commit (Dual Reviewers & Auto-Commit)
1. **更新 `PROGRESS.MD`**：標註進度為 `Phase 3: Code Review & Runtime Verification`。
2. **檢查與 Triage 外部 Bug (`agent_docs/FIND_BUG.MD`)**：
   - 若存在狀態為 `OPEN` 的項目 ➔ Orchestrator 先進行 Triage：
     * 可重現、屬實 ➔ 將摘要轉載至 `agent_docs/REVIEW_FEEDBACK.MD` 並在 `agent_docs/TASK.MD` 追加修正任務，狀態改為 `IN_PROGRESS`。
     * 誤報或無法重現 ➔ 標註 `Status: INVALID` 並附判定理由；`INVALID` 項目不阻擋後續 Commit。
3. **Parallel Spawn `logic-reviewer` & `testing-reviewer`**（各自只寫自己的報告檔，不寫 `REVIEW_FEEDBACK.MD`）：
   - `logic-reviewer` 比對 `git diff`、`PLAN.MD` 與 `TASKED.MD` 檢查邏輯漏洞 ➔ 寫入 `agent_docs/REVIEW_LOGIC.MD`。
   - `testing-reviewer` 執行實機/瀏覽器/API 動態測試 ➔ 寫入 `agent_docs/REVIEW_TEST.MD`。
4. **Fix & Re-review Loop (修到好為止，含人類升級門檻)**：
   - **若發生以下任一狀況（觸發修復流程）**：
     * 任一 Reviewer 標註 `REJECTED`
     * `FIND_BUG.MD` 包含未修復的 `OPEN` / `IN_PROGRESS` Bug
     * 程式執行或產出測試時爆出 Runtime Error / Unexpected Behavior
   - **修復步驟**：
     1. **Orchestrator 彙整 Bug 詳情**：自 `REVIEW_LOGIC.MD`、`REVIEW_TEST.MD` 與 `FIND_BUG.MD` 將重現步驟、錯誤訊息與 Log 彙整寫入 `agent_docs/REVIEW_FEEDBACK.MD`，並記錄該 Bug 的累計修復輪數。
     2. **升級門檻檢查**：若同一 Bug（同 BUG-ID）已連續 **5 輪**「修復 ➔ 重審」未通過 ➔ **暫停迴圈**，將完整嘗試歷程寫入 `REVIEW_FEEDBACK.MD`，比照 Phase 1 Human Checkpoint 等待人類決策（繼續、改變方向或標註 `INVALID`）。
     3. **派發 Task**：在 `agent_docs/TASK.MD` 追加修正任務。
     4. **Spawn `senior-coder`**：依據 `TASK.MD` 與 `REVIEW_FEEDBACK.MD` 修復程式碼，更新 `CHANGELOG.MD`，並將 `FIND_BUG.MD` 對應條目更新為 `RESOLVED`。
     5. **重新觸發雙審查**：重新 Spawn 雙 Reviewer 重新進行驗證。
5. **自動 Commit 階段 (Auto Git Commit On Pass)**：
   - 當雙 Reviewer 皆標註 `APPROVED` 且 `FIND_BUG.MD` 無殘留 `OPEN` / `IN_PROGRESS` Bug 時：
   - **由 Orchestrator（且僅限 Orchestrator）** 執行 Terminal 指令，僅 stage 本次 Task 涉及的檔案與 `agent_docs/` 紀錄（嚴禁 `git add .`）：
     ```bash
     git add <本次 Task 涉及的檔案> agent_docs/
     git commit -m "feat/fix: [TASK-ID/BUG-ID] 簡短描述" -m "<CHANGELOG.MD 重點摘要>"
     ```
   - 才可進入 Phase 4。

---

## Phase 4: 最終架構巡檢與單一 HTML 總覽產出
1. **更新 `PROGRESS.MD`**：標註進度為 `Phase 4: Summary`。
2. **Spawn `lead-architect`**：
   - 巡檢最終程式碼與 `agent_docs/` 下所有紀錄（含 `CHANGELOG.MD`、`TASKED.MD` 與 `FIND_BUG.MD`）。
   - 產出 `agent_docs/SUMMARY.MD`。
   - **匯整全部內容產出單一結案檔 `agent_docs/summary.html`**，內容必須包含：
     * 1. 系統最終架構圖與模組說明
     * 2. 詳細環境設定與使用教學
     * 3. **內部與外部 Bug 查核修復對照表 (Bug Log)**
     * 4. **檔案變更履歷 (Code Modifications)**
3. **完成宣告**：提示使用者開啟 `agent_docs/summary.html` 查看完整報告，並將 `PROGRESS.MD` 標註為 `COMPLETED`。
