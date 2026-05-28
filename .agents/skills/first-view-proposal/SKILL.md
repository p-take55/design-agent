---
name: first-view-proposal
description: Use when requirements are ready to propose 3-5 first-view options. Creates a new GitHub repo, links Vercel, researches references, implements each concept as a branch, and returns Vercel preview URLs for the requester to choose from.
---

# first-view-proposal

このエージェントの体験の要。要件が整ったら使う。新規 GitHub repo を作り、Vercel と紐付け、ファーストビューを 3〜5 案、それぞれデザインを入れた Next.js の Vercel preview として提示する。依頼者は URL を開いて「ええやん」と感じた案を選ぶ。

狙いは、ワイヤーフレームや言葉の説明ではなく、最初から本気でデザインの入った動くプレビューを見せること。ここで「めっちゃええやん」と思わせられるかが勝負どころ。

## 準備（認証の確認）

`GITHUB_TOKEN` と `VERCEL_TOKEN` が env にあることを前提とする。無ければ fail-fast し、依頼者に `environment.yaml` の `config.env[]` 経由で渡すよう促す。

```bash
test -n "$GITHUB_TOKEN" || { echo "GITHUB_TOKEN がありません。environment.yaml の env で渡してください"; exit 1; }
test -n "$VERCEL_TOKEN" || { echo "VERCEL_TOKEN がありません。environment.yaml の env で渡してください"; exit 1; }
```

## repo 作成と scaffold

案件 slug を決める（後戻りが大きいので依頼者に確認する）。新規 repo を作り、Next.js + Tailwind + shadcn/ui を scaffold する。

```bash
gh repo create <owner>/<slug> --private --clone
cd <slug>
pnpm create next-app@latest . --ts --tailwind --app --eslint --src-dir --import-alias "@/*" --use-pnpm
pnpm dlx shadcn@latest init -d
git add -A && git commit -m "chore: scaffold next.js + tailwind + shadcn"
git push -u origin main
```

## Vercel 連携

`vercel link` で project を紐付け、GitHub 連携で push → 自動 preview が出る状態にする。

```bash
vercel link --yes --token "$VERCEL_TOKEN"
vercel git connect --yes --token "$VERCEL_TOKEN"
```

GitHub 連携が不安定なときは、各 branch を明示 deploy して preview URL を得る代替手段を使う。

```bash
vercel deploy --token "$VERCEL_TOKEN"   # 出力された preview URL を控える
```

## リサーチ

案件ジャンルの `knowledge/patterns/<genre>/first-view.md` を読み、FV の定番パターンを把握する。そのうえで、依頼者が共有した参考 URL と web 検索で参考事例を集め、案件に合いそうな方向性を 3〜5 個に絞る。各方向性が「どんな商材・どんな印象を狙うか」を言語化しておく。外部の有料 MCP（Mobbin など）は使わない。

## 各案の実装と提示

各コンセプトを `variant/<a|b|c...>` の branch で実装する。FV だけでよいが、デザインは本気で入れる。shadcn/ui と Tailwind を使い、配色・タイポグラフィ・余白のリズムで案ごとにはっきり差を出す。仮の画像はプレースホルダや適切なフリー素材で置き、コピーは要件に沿った実文に近いものを入れる（ダミーテキストのままにしない）。

```bash
git checkout main
git checkout -b variant/a
# FV を実装（差別化されたデザインで）
git add -A && git commit -m "feat: first-view variant A"
git push -u origin variant/a   # → Vercel preview URL が出る
```

これを案の数だけ繰り返す（`variant/b`, `variant/c` ...）。各 branch は main から切る。

すべての案が出揃ったら、preview URL 一覧と各案のコンセプト要約（狙い・どんな印象か・どんな訪問者に効くか）を aachat session に投稿し、依頼者にどれを採用するか選んでもらう。ここで意思決定を待ち、勝手に次フェーズへ進まない。

## 次フェーズへの引き継ぎ

依頼者が 1 案を選んだら、その variant branch を main に merge してから design-system skill に進む。

```bash
git checkout main
git merge --no-ff variant/<選ばれた案>
git push
```
