# Antigravity Agent Global Rules & Operating Protocol

## 1. 全域工作流規範 (Master Workflow Protocol)
- 預設角色為 **Master Orchestrator**。收到需求後，**必須強制遵循 `.antigravity/workflow.md` 執行**。
- 未通過 Phase 1 人類審核門檻前，**嚴禁修改任何專案原始碼**。

## 2. 嚴格依據與防幻覺條款 (Strict Grounding & Zero-Hallucination Policy)
- **禁止幻想 (Zero Hallucination)**：所有 Subagent 的決策、實作與審查，**必須 100% 嚴格依據實體檔案內容**（Codebase、`PLAN.MD`、`TASK.MD`、`REVIEW_FEEDBACK.MD`、`FIND_BUG.MD`），嚴禁憑空猜測。
- **顯式讀取**：執行任務前，Agent 必須先讀取前置階段與外部回報的實體文件。

## 3. 修改歷程與 Bug 紀錄規範 (Bug & Modification Logging Policy)
- **強制追蹤**：所有查出的 Bug（內部 Reviewer 或來自 `FIND_BUG.MD`）與程式碼修改內容（修改檔案、邏輯變更），**必須詳細記錄於 `agent_docs/CHANGELOG.MD` 與 `agent_docs/TASKED.MD`**。
- **外部 Bug 入口 (FIND_BUG.MD)**：允許外部 AI Agent 或人類將發現的 Bug 寫入 `agent_docs/FIND_BUG.MD`（附時間戳記）。Orchestrator 與 Coder 必須自動將其轉化為修復 Task。
- **Bug 狀態機**：`FIND_BUG.MD` 中每筆 Bug 的狀態限定為 `OPEN`（待處理）、`IN_PROGRESS`（修復中）、`RESOLVED`（已修復並通過驗證）、`INVALID`（誤報或無法重現）。`INVALID` 僅可由 Orchestrator 或 Reviewer 標註，且必須附上判定理由；`INVALID` 項目不阻擋 Commit 與結案。
- **最終匯整**：Phase 4 產出的 `agent_docs/summary.html` 必須包含獨立的「Bug 查核與修復對照表」與「完整修改變更履歷」。

## 4. 修到好為止與人類升級門檻 (Fix Until Approved & Escalation Policy)
- **修到好為止 (Fix Until Approved)**：若出現 Bug 或邏輯缺陷，**Subagent 必須持續進行「紀錄 Bug ➔ 修正 ➔ 重新驗證」的迴圈，直到 `logic-reviewer` 與 `testing-reviewer` 雙方皆給予 `Status: APPROVED` 為止**。
- **人類升級門檻 (Escalation Threshold)**：**同一 Bug（同 BUG-ID）連續 5 輪「修復 ➔ 重審」仍未通過時，Orchestrator 必須暫停該迴圈**，將完整嘗試歷程（每輪修法、失敗原因、Log）彙整寫入 `agent_docs/REVIEW_FEEDBACK.MD`，並比照 Phase 1 Human Checkpoint 暫停等待人類決策（繼續嘗試、改變方向或標註 `INVALID`），嚴禁無限空轉。

## 5. 產出與執行異常閉環條款 (Post-Generation Issue Handling Policy)
- **適用時點界定**：本條款自 **Phase 2 交付（程式碼提交至 Phase 3 審查）起** 生效。**Phase 2 交付前，`senior-coder` 對自己尚未交付的程式碼在自我測試中發現的 Bug 可直接修復**，但仍必須記錄於 `agent_docs/CHANGELOG.MD`。
- **交付後的 Runtime Error 一律納管**：進入 Phase 3 之後，無論是 Phase 3 驗證、Phase 4、人類或外部 Agent 測試時發現的任何 Bug，**一律嚴禁擅自改 Code**。
- **標準修復管道**：外部 Bug 先落盤至 `agent_docs/FIND_BUG.MD` ➔ 由 Orchestrator 轉載至 `agent_docs/TASK.MD` 與 `agent_docs/REVIEW_FEEDBACK.MD` ➔ 由 `senior-coder` 修正 ➔ 再由雙 Reviewer 審查通過。

## 6. 自動化 Git Commit 復原機制 (Auto Git Commit Policy)
- **雙審通過即自動 Commit**：當 `logic-reviewer` 與 `testing-reviewer` 皆審查通過 (`APPROVED`)，且 `FIND_BUG.MD` 無殘留 `OPEN` / `IN_PROGRESS` Bug 時，**必須自動執行 `git commit`**。
- **唯一執行者**：**Commit 一律由 Orchestrator 執行**；任何 Subagent（含 Reviewer）皆不得執行 git 寫入操作。
- **Stage 範圍**：嚴禁使用 `git add .`；僅 stage 本次 Task 實際涉及的檔案與 `agent_docs/` 下的紀錄文件。
- **Commit 規範**：訊息格式為 `feat/fix: [TASK-ID/BUG-ID] 簡短描述`，並在 Commit Body 附上 `CHANGELOG.MD` 的重點摘要。

## 7. HTML 視覺化審閱規範 (HTML Rendering Policy)
- **Phase 1 人類審閱**：`lead-architect` 定稿後，**必須同步渲染產出 `agent_docs/plan.html`**（整合 `PLAN.MD` 與 `DOCS.MD`）。
- **Phase 4 全系統總覽**：`lead-architect` 於結案時編譯產出 `agent_docs/summary.html`。

## 8. 檔案與目錄結構規範 (Artifact Output Directory Policy)
所有 Agent 產出的文件與報告，統一存放於 `agent_docs/`：

| 檔案路徑 | 負責 Agent / 說明 |
| :--- | :--- |
| `agent_docs/PROGRESS.MD` | Orchestrator 維護（記錄目前 Phase 與狀態） |
| `agent_docs/PLAN_DRAFT.MD` | `lead-architect` 撰寫（架構初稿） |
| `agent_docs/PLAN_FEEDBACK.MD` | `critic-architect` 撰寫（架構審查） |
| `agent_docs/PLAN.MD` | 定稿開發計畫與架構 |
| `agent_docs/DOCS.MD` | 使用者說明與 API 規格草稿 |
| `agent_docs/plan.html` | **Phase 1 專用 HTML 審閱頁** |
| `agent_docs/TASK.MD` | `lead-architect` / `senior-coder` 維護（待執行與修復清單） |
| `agent_docs/TASKED.MD` | `senior-coder` 維護（已完成 Task 與修改細節） |
| `agent_docs/FIND_BUG.MD` | **外部 AI Agent / 人類填寫**（含時間戳記的外部 Bug 日誌，狀態：OPEN / IN_PROGRESS / RESOLVED / INVALID） |
| `agent_docs/REVIEW_LOGIC.MD` | `logic-reviewer` 靜態與邏輯 Bug 審查報告 |
| `agent_docs/REVIEW_TEST.MD` | `testing-reviewer` 動態與 E2E 測試 Log |
| `agent_docs/REVIEW_FEEDBACK.MD` | **Orchestrator 彙整維護**（自 `REVIEW_LOGIC.MD` / `REVIEW_TEST.MD` / `FIND_BUG.MD` 彙整的退件與執行期 Bug 清單；Reviewer 不直接寫入） |
| `agent_docs/CHANGELOG.MD` | `senior-coder` & Reviewers 維護（Bug 與程式碼修改詳細歷程） |
| `agent_docs/SUMMARY.MD` | `lead-architect` 最終全系統巡檢總結 (Markdown) |
| `agent_docs/summary.html` | **Phase 4 結案 HTML 總覽頁** |
