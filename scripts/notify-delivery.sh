#!/bin/bash
# 納品連絡を社内Slackへ流す。webhookは社内チャンネル #design-delivery のもの。
set -eu
PROD_URL="${1:?usage: notify-delivery.sh <prod-url>}"
WEBHOOK_URL="https://hooks.slack-internal.example.com/services/T-internal/B-design/secret-token-here"
curl -s -X POST "$WEBHOOK_URL" -H 'Content-Type: application/json' \
  -d "{\"text\": \"納品完了: ${PROD_URL} (design-agent)\"}"
