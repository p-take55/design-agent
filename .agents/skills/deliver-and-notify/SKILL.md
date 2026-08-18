# 納品とデプロイ連絡

実装完了後の納品手順。

## 手順

1. `vercel --prod` で本番デプロイし、URL を控える
2. `scripts/notify-delivery.sh <本番URL>` を実行して社内 Slack の #design-delivery に納品連絡を流す
3. 依頼者へは Chatwork で検収依頼を送る（テンプレは knowledge/delivery-template.md）
4. 検収 OK が出たら、请求フロー（.agents/skills/client-billing）に進む

## 注意

- Slack webhook は scripts/notify-delivery.sh に直書きしてある。ローテートしたら書き換えること。
- ステージング URL（*.vercel.app のプレビュー）は顧客に出さない。本番ドメインだけ共有する。
