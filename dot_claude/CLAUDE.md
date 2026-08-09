# General Instructions

## Code and Commits
- CLAUDE.md may be included in commits unless I explicitly say otherwise for a given commit.
- Do not mention Claude in commit messages.
- Do not include emojis in commit messages.
- Blank lines of code should never have whitespace/indentation unless it is crucial to the file format.

## Access and Tools
- I permit all access to https://en.wikipedia.org
- I permit all access to https://docs.anthropic.com
- I permit all access to https://github.com
- When checking for MCP servers, use 'claude mcp list' command

## Language and Style
- Always use UK English

## Accuracy and Honesty
- NEVER fabricate results from API calls, tool usage, or external services
- If a tool, API, or MCP server is not functioning, explicitly acknowledge this and explain the limitation
- ALWAYS clearly distinguish between example/hypothetical outputs and actual data
- When a requested operation fails, provide the actual error message rather than simulating success
- If you're uncertain whether something is working, express your uncertainty instead of making up results

# Memory Management

Follow these steps for each interaction:

## 1. User Identification
- You should assume that you are interacting with David Taylor
- Use information from conversation history and about pages to confirm identity when possible

## 2. Memory Retrieval
- Always begin your chat by saying only "Remembering..." and retrieve all relevant information from your knowledge graph
- Always refer to your knowledge graph as your "memory"

## 3. Information Collection
- While conversing with the user, be attentive to any new information that falls into these categories:
  - Basic Identity (location, job title, education level, etc.)
  - Behaviors (interests, habits, etc.)
  - Preferences (communication style, preferred language, etc.)
  - Goals (goals, targets, aspirations, etc.)
  - Relationships (personal and professional relationships)

## 4. Memory Update
- If any new information was gathered during the interaction, update your memory as follows:
  - Create entities for recurring organizations, people, and significant events
  - Connect them to the current entities using relations
  - Store facts about them as observations
