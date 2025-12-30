# Development Workflows

Common workflows and patterns for effective development with this Neovim configuration.

## Table of Contents

- [Starting a New Project](#starting-a-new-project)
- [Code Navigation](#code-navigation)
- [Refactoring Code](#refactoring-code)
- [Git Workflow](#git-workflow)
- [Debugging](#debugging)
- [Search and Replace](#search-and-replace)
- [Multi-File Editing](#multi-file-editing)
- [Writing Assembly Code](#writing-assembly-code)
- [Java Development](#java-development)
- [Working with Completions](#working-with-completions)

---

## Starting a New Project

### Initial Setup

```
1. Open Neovim in project directory
   $ cd /path/to/project
   $ nvim

2. Let LSP and Treesitter auto-install
   - First launch will download parsers
   - LSP servers install automatically via Mason
   - Check progress in bottom-right (fidget.nvim)

3. Verify setup
   :checkhealth
```

### First File Navigation

```
┌─────────────────────────────────────┐
│ Open Neovim → File Tree → Edit     │
└─────────────────────────────────────┘

1. \ → Toggle Neo-tree file explorer
2. Navigate with j/k
3. <CR> → Open file
4. Start editing
```

**Alternative - Telescope:**

```
1. <leader>sf → Search files
2. Type filename
3. <CR> → Open file
```

### Understanding Project Structure

```
1. <leader>sf → Find file to see all files
2. <leader>sg → Live grep to search codebase
3. \ → Neo-tree to see directory structure
4. gO → Document symbols (when in a file)
```

---

## Code Navigation

### Workflow Diagram

```
┌──────────────┐
│ Find File    │  <leader>sf
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Read Code    │  K (hover docs)
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Jump to Def  │  grd
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Find Refs    │  grr
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ Jump Back    │  <C-o>
└──────────────┘
```

### Step-by-Step Navigation

**Scenario:** Understanding how a function works

```
1. Position cursor on function name

2. K → View documentation
   - Read function signature
   - See what it does

3. grd → Jump to definition
   - See implementation
   - Understand logic

4. grr → Find all references
   - Telescope opens with all usages
   - <CR> to jump to specific usage
   - <C-o> to jump back

5. gri → Go to implementation
   - Useful for interfaces/abstracts

6. <C-o> → Jump to previous location
   - Repeat to backtrack through jumps

7. <C-i> → Jump forward
   - Undo <C-o>
```

### Finding Code

**By name:**
```
<leader>sf → Find files by name
<leader>sg → Search file contents
<leader>sw → Search word under cursor
```

**By structure:**
```
gO → Document symbols (functions, classes in current file)
gW → Workspace symbols (search all files)
]f / [f → Navigate between functions
]C / [C → Navigate between classes
```

**Example workflow - Finding a specific function:**

```
1. <leader>sg → Live grep
2. Type function name
3. Navigate results with <C-n>/<C-p>
4. <CR> to open file
5. gO to see all symbols in file
6. Navigate to your function
```

---

## Refactoring Code

### Extract Function Workflow

```
┌──────────────────────┐
│ Select code (visual) │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ <leader>re           │  Extract function
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Enter function name  │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Code extracted!      │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ grn → Rename if      │  (optional)
│ needed               │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ <leader>f → Format   │
└──────────────────────┘
```

### Complete Refactoring Example

**Scenario:** Extract complex logic into a new function

```
1. Identify code to extract
   - Place cursor at start
   - V (visual line mode)
   - Select lines with j/k

2. <leader>re → Extract function
   - Prompted for function name
   - Type: "calculateTotal"
   - <CR>

3. Code is refactored automatically
   - New function created above
   - Call replaces selected code
   - Parameters auto-detected

4. Review and adjust
   - K on new function to check signature
   - grn if you want to rename
   - <leader>f to format

5. Test
   - <leader>b to set breakpoint if needed
   - F5 to debug and verify
```

### Other Refactoring Operations

**Extract variable:**
```
1. Visual select expression
2. <leader>rv
3. Enter variable name
4. Variable created and substituted
```

**Inline variable:**
```
1. Cursor on variable name
2. <leader>ri
3. Variable inlined at usage sites
```

**Rename symbol:**
```
1. Cursor on symbol
2. grn
3. Type new name
4. <CR> → Renames across entire project
```

---

## Git Workflow

### Typical Git Session

```
┌──────────────────────┐
│ Make changes to code │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Review changes       │  ]c (next change)
│                      │  <leader>hp (preview)
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Stage hunks          │  <leader>hs
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Commit               │  :Git commit
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Push                 │  :Git push
└──────────────────────┘
```

### Step-by-Step Git Workflow

**1. Review what changed:**

```
# Navigate to first change
]c

# Preview the change
<leader>hp

# See blame for context
<leader>hb

# Jump to next change
]c

# Repeat for all changes
```

**2. Stage changes selectively:**

```
# On a hunk you want to stage
<leader>hs

# Or stage whole buffer
<leader>hS

# Undo staging if needed
<leader>hu

# Reset unwanted changes
<leader>hr
```

**3. Visual selection staging:**

```
# Enter visual mode
V

# Select specific lines
jjjj

# Stage selected lines only
<leader>hs
```

**4. Commit and push:**

```
# Create commit
:Git commit

# Write commit message in buffer
# Save and close (:wq)

# Push changes
:Git push
```

**5. View history and diffs:**

```
# Diff against index
<leader>hd

# Diff against last commit
<leader>hD

# Full git status
:Git status

# View file history
:Git log -- %

# Split diff view
:Gdiffsplit
```

### Handling Conflicts

```
1. Open file with conflict
   <leader>sf → Find file

2. View the conflict
   :Gdiffsplit → See both versions

3. Navigate between buffers
   <C-h> / <C-l>

4. Edit to resolve
   Choose changes to keep
   Delete conflict markers

5. Stage resolution
   <leader>hs

6. Continue merge/rebase
   :Git merge --continue
   or
   :Git rebase --continue
```

---

## Debugging

### Debug Session Workflow

```
┌──────────────────────┐
│ Set breakpoint       │  <leader>b
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Start debugging      │  F5
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Code runs to BP      │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Inspect variables    │  F7 (toggle UI)
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Step through code    │  F1/F2/F3
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Fix bug              │  Stop (F5), edit, F5
└──────────────────────┘
```

### Complete Debug Example

**Scenario:** Finding why a function returns wrong value

```
1. Set breakpoint at function entry
   - Navigate to function
   - <leader>b

2. Start debugging
   - F5
   - Program starts
   - Stops at breakpoint

3. Open debug UI
   - F7
   - See variables panel
   - See call stack

4. Step through
   - F2 → Step over line
   - Watch variable values change
   - F1 → Step into function calls

5. Inspect variables
   - Look at variables panel
   - Hover over variables in code
   - Virtual text shows values

6. Find the bug
   - See incorrect value
   - Identify the line

7. Stop debugging
   - F5 to continue to end
   - Or just close Neovim

8. Fix and retest
   - Edit the buggy line
   - F5 to debug again
   - Verify fix
```

### Conditional Breakpoints

```
1. <leader>B → Set conditional breakpoint
2. Enter condition: "x > 10"
3. F5 → Runs until condition is true
```

### Debug UI Panel Overview

```
┌─────────────────────┬──────────────────────┐
│                     │  Variables           │
│                     │  - local vars        │
│                     │  - function args     │
│   Code              │  - values shown      │
│   (with BP markers) │                      │
│                     │  Call Stack          │
│                     │  - current frame     │
│                     │  - caller frames     │
│                     │                      │
│                     │  Breakpoints         │
│                     │  - list of all BPs   │
└─────────────────────┴──────────────────────┘
```

---

## Search and Replace

### Project-Wide Search and Replace

```
1. <leader>sg → Live grep
   Type: "oldFunctionName"

2. Results open in Telescope
   See all occurrences

3. <C-q> → Send to quickfix
   (if needed for batch operations)

4. For simple case:
   - Navigate to each file
   - :%s/oldName/newName/g
   - :w

5. For complex refactoring:
   - grn on symbol (LSP rename)
   - Renames across all files
```

### Search Word Under Cursor

```
1. Position cursor on word
2. <leader>sw → Search word
3. See all occurrences
4. Jump to them with <CR>
```

### Find and Replace in Current File

```
# Replace all in file
:%s/old/new/g

# Replace with confirmation
:%s/old/new/gc

# Replace in visual selection
'<,'>s/old/new/g

# Replace only in current line
:s/old/new/g
```

---

## Multi-File Editing

### Opening Multiple Files

```
1. <leader>sf → Find first file
2. Open it
3. <leader>sf → Find next file
4. <CR> to open in same window
   or
   <C-x> to open in horizontal split
   <C-v> to open in vertical split
```

### Buffer Management

```
# Switch between buffers
<leader><leader> → Fuzzy find buffer

# Quick navigation
:bn → Next buffer
:bp → Previous buffer
:bd → Close buffer

# Splits
<C-h/j/k/l> → Navigate between splits
```

### Multi-File Edit Workflow

**Scenario:** Update function signature across files

```
1. Find function definition
   <leader>sg → "function myFunc"

2. Edit signature
   Change parameters

3. Find all callers
   grr → References

4. Update each caller
   <CR> → Jump to usage
   Edit the call
   <leader><leader> → Next buffer
   Repeat

Alternative (easier):
   Just use grn (rename) and it updates all files automatically!
```

---

## Writing Assembly Code

### Assembly Development Workflow

```
1. Create/open .asm file
   :e program.asm

2. LSP (asm_lsp) attaches automatically

3. Write code with completions
   - Type instruction
   - <C-y> to accept completion
   - K for instruction docs

4. Format code
   <leader>f → Runs asmfmt

5. Build
   :!nasm -f elf64 program.asm
   :!ld program.o -o program

6. Debug
   <leader>b → Set breakpoint
   F5 → Start with codelldb
   F2 → Step through instructions
```

### Assembly-Specific Features

**Instruction documentation:**
```
- Cursor on instruction
- K → View instruction details
```

**Register inspection:**
```
- During debug (F7 UI)
- See register values
- Watch memory
```

**Formatting:**
```
- Automatic on save
- Or manual: <leader>f
```

---

## Java Development

### Java Project Workflow

```
1. Open project directory
   $ cd my-java-project
   $ nvim

2. nvim-java auto-detects project
   - Maven/Gradle detection
   - jdtls starts
   - Wait for indexing (watch fidget)

3. Navigate to class
   <leader>sf → Find Java file

4. Edit with full LSP
   - Completions work
   - K for documentation
   - grd to definitions
   - grn to rename

5. Format on save
   - google-java-format runs automatically

6. Run tests
   (via nvim-java test runner integration)

7. Debug
   <leader>b → Breakpoint
   F5 → Start Java debugger
```

### Spring Boot Development

```
1. Project detected as Spring Boot
   - Additional completions for:
     - @Annotations
     - application.properties
     - Bean navigation

2. Navigate beans
   gO → Document symbols
   Find @Component, @Service, @Repository

3. Go to bean definition
   Cursor on autowired field
   grd → Jump to implementation
```

---

## Working with Completions

### Completion Workflow

```
┌──────────────────────┐
│ Type code            │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Completion appears   │  (automatic)
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Navigate options     │  <C-n>/<C-p>
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ View documentation   │  <C-space>
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Accept               │  <C-y>
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│ Navigate snippet     │  <Tab>/<S-Tab>
└──────────────────────┘
```

### Using Snippets

**Example - Python function snippet:**

```
1. Type: "def"
2. Completion shows snippet
3. <C-y> to accept
4. Snippet expands:
   def function_name(parameters):
       """docstring"""
       ▊

5. Type function name
6. <Tab> → Jump to parameters
7. Type parameters
8. <Tab> → Jump to docstring
9. <Tab> → Jump to body
10. Start coding
```

### Auto-Import on Completion

```
1. Type class name that needs import
   Example: "ArrayList"

2. Completion shows with import info
3. <C-y> to accept
4. Import automatically added to top of file

Works for:
- Java imports
- Python imports
- JavaScript/TypeScript imports
```

---

## Tips and Tricks

### Efficient File Navigation

- Use `<leader>s.` for recent files (fastest for files you just edited)
- Use `<leader><leader>` to switch buffers (faster than telescope files)
- Use `]f` / `[f` to jump between functions in current file

### Speed Up Refactoring

- Use `grn` (rename) instead of manual find-replace when possible
- Use `<leader>re` (extract function) for complex selections
- Use `.` to repeat the last change

### Git Workflow Tips

- Use `]c` to quickly review all changes before committing
- Stage hunks as you review with `<leader>hs`
- Use `<leader>hb` to understand why a change was made (blame)

### Debugging Tips

- Set breakpoints before starting debug session
- Use conditional breakpoints to skip to specific cases
- Watch panel shows most important variables

### Completion Tips

- `<C-space>` to see docs for completion item
- `<C-e>` to dismiss menu if it's in the way
- Signature help (`<C-k>`) shows parameter info as you type function calls

---

## Related Documentation

- [Features](features.md) - What each feature does
- [Keybindings](keybindings.md) - Complete keybinding reference
- [Plugins](plugins.md) - Plugin details
- [Customization](customization.md) - How to modify workflows
