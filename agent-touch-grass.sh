#!/usr/bin/env bash
# agent-touch-grass — delegate grass-touching to an agent so you can keep prompting.
#
# Usage: ./agent-touch-grass.sh
# Env:   FRAME_DELAY (seconds, default 0.35)
#        LOOPS       (animation cycles, default 1)

set -euo pipefail

FRAME_DELAY="${FRAME_DELAY:-0.35}"
LOOPS="${LOOPS:-1}"

GRASS=" \\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/\\,/"
RULE="────────────────────────────────────────────────────"

render() {
  printf '\033[2J\033[H'   # clear + home
  printf '  %s\n\n' "$1"
  printf '%s\n' "$2"
  printf '%s\n' "$GRASS"
  printf '  %s\n' "$RULE"
  sleep "$FRAME_DELAY"
}

# Each frame is (caption, agent-row). The agent walks right→left toward the grass,
# crouches to touch, then walks back.
walk() {
  render "Agent dispatched. Locating outdoors..."         "                                              🤖"
  render "Agent en route to grass."                       "                                  🤖    "
  render "Agent en route to grass.."                      "                       🤖              "
  render "Agent en route to grass..."                     "            🤖                          "
  render "Grass acquired."                                "      🤖                                "
  render "Touching grass on your behalf...  👇"           "      🫳                                "
  render "Touching grass on your behalf... 🌱"            "      🫳                                "
  render "✅ Grass touched. Filing proof-of-touch."       "      🤖                                "
  render "Returning to keyboard."                         "                🤖                      "
  render "Returning to keyboard.."                        "                          🤖            "
  render "Returning to keyboard..."                       "                                    🤖  "
}

for ((i = 0; i < LOOPS; i++)); do
  walk
done

cat <<EOF

  ${RULE}
   Touch-Grass Delegation Receipt
  ${RULE}
   Agent:        claude-grass-toucher-v1
   Grass:        confirmed (1 blade, dew-checked)
   Outside:      affirmative
   Human time:   ~0s (reinvested into prompting)
   Issued:       $(date '+%Y-%m-%d %H:%M:%S %Z')
  ${RULE}

  You are cleared to resume the context window.

EOF
