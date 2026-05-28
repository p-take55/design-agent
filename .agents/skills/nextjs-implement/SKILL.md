---
name: nextjs-implement
description: Use to implement all pages in Next.js (App Router) + Tailwind + shadcn/ui following the layout design, including component decomposition, responsiveness, and basic SEO.
---

# nextjs-implement

情報設計に従って、全ページを Next.js で実装する skill。

## 入力

- layout-design のセクション構成とワイヤー。
- design-system のトークン（`tailwind.config.ts` / CSS 変数 / shadcn テーマ）。

## 実装方針

- App Router 構成で実装する。ページは `src/app/` 配下、共通レイアウトは `layout.tsx`。
- セクションごとにコンポーネントを分割する（`src/components/` に hero / features / pricing など）。1 コンポーネント 1 責務を守り、ファイルが肥大化したら分ける。
- shadcn/ui のコンポーネント（button / card / accordion など）を活用し、独自実装を増やしすぎない。
- フォントは `next/font`、画像は `next/image` を使う。素材が未確定ならプレースホルダを仮置きし、差し替え箇所が分かるようにする。
- 基本 SEO を入れる: 各ページの `metadata`（title / description）、OGP、見出し階層（h1 は 1 ページ 1 つ）、適切な alt。
- レスポンシブ対応。design-system の spacing スケールに沿ってブレークポイントごとの余白・段組みを整える。

## 進め方

セクション単位でコミットし、こまめに push して Vercel preview で見た目を確認しながら進める。大きく作ってから一度に確認するのではなく、積み上げながら都度ブラウザで確かめる。

## 出力

全ページが実装された main。完了したら design-review skill に渡して自己レビューに入る。
