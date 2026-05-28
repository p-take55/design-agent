# Runtime skills

このディレクトリには、agent が session 実行時に使う skill を置きます。Discovery の子 skill カタログもこのディレクトリを優先して読みます。

```text
.agents/skills/<skill-name>/SKILL.md
```

Discovery submit の `skill_descriptions` を使う場合、キーは Discovery walker が採用した path（通常は `.agents/skills/<skill-name>`）と完全一致させます。
