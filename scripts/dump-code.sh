#!/usr/bin/env bash

set -euo pipefail

ROOT="${1:-.}"

# Directories that should never appear in the dump.
EXCLUDED_DIRS=(
    ".git"
    ".idea"
    ".vscode"
    ".cache"
    "__pycache__"
    "node_modules"
    "target"
    "build"
    "build_files"
    "dist"
    "out"
    "output"
)

# LaTeX/compiler/editor/generated files.
EXCLUDED_PATTERNS=(
    "*.aux"
    "*.bbl"
    "*.bcf"
    "*.blg"
    "*.fdb_latexmk"
    "*.fls"
    "*.fmt"
    "*.fot"
    "*.glg"
    "*.glo"
    "*.gls"
    "*.glsdefs"
    "*.idx"
    "*.ilg"
    "*.ind"
    "*.ist"
    "*.lof"
    "*.log"
    "*.lot"
    "*.nav"
    "*.out"
    "*.run.xml"
    "*.snm"
    "*.synctex"
    "*.synctex.gz"
    "*.toc"
    "*.vrb"
    "*.xdv"

    "*.pdf"
    "*.dvi"
    "*.ps"

    "*.pyc"
    "*.pyo"

    "*.swp"
    "*.swo"
    "*~"
    ".DS_Store"
)

build_find_excludes() {
    local expr=()
    local dir pattern

    for dir in "${EXCLUDED_DIRS[@]}"; do
        expr+=(-path "*/$dir" -o -path "*/$dir/*" -o)
    done

    for pattern in "${EXCLUDED_PATTERNS[@]}"; do
        expr+=(-name "$pattern" -o)
    done

    unset 'expr[${#expr[@]}-1]'

    printf '%s\0' "${expr[@]}"
}

is_excluded() {
    local path="$1"
    local base
    base="$(basename "$path")"

    local dir pattern

    for dir in "${EXCLUDED_DIRS[@]}"; do
        if [[ "$path" == */"$dir" || "$path" == */"$dir"/* ]]; then
            return 0
        fi
    done

    for pattern in "${EXCLUDED_PATTERNS[@]}"; do
        if [[ "$base" == $pattern ]]; then
            return 0
        fi
    done

    return 1
}

is_text_file() {
    local file="$1"

    case "$file" in
        *.tex|*.sty|*.cls|*.bib|*.bbx|*.cbx|*.lbx|\
        *.md|*.txt|*.rst|\
        *.toml|*.yaml|*.yml|*.json|*.xml|\
        *.ini|*.cfg|*.conf|\
        *.sh|*.bash|*.zsh|\
        *.py|*.rs|*.lua|*.pl|*.rb|*.js|*.ts|\
        *.mk|Makefile|makefile|GNUmakefile|\
        *.gitignore|*.gitattributes|\
        Dockerfile|LICENSE|README)
            return 0
            ;;
    esac

    # Fallback: include anything that appears to be text.
    [[ -f "$file" ]] && grep -Iq . "$file" 2>/dev/null
}

print_rule() {
    printf '%*s\n' 80 '' | tr ' ' '─'
}

echo
echo "PROJECT"
echo "======="
echo
printf 'Root: %s\n\n' "$(realpath "$ROOT")"

echo "TREE"
echo "===="
echo

if command -v tree >/dev/null 2>&1; then
    IGNORE="$(
        IFS='|'
        echo "${EXCLUDED_DIRS[*]}|${EXCLUDED_PATTERNS[*]}"
    )"

    tree -a \
        --dirsfirst \
        -I "$IGNORE" \
        "$ROOT"
else
    echo "(tree is not installed; using find)"
    echo

    find "$ROOT" -mindepth 1 -print \
        | sort \
        | while IFS= read -r path; do
            if ! is_excluded "$path"; then
                printf '%s\n' "${path#"$ROOT"/}"
            fi
        done
fi

echo
echo
echo "FILE CONTENTS"
echo "============="
echo

while IFS= read -r -d '' file; do
    is_excluded "$file" && continue
    is_text_file "$file" || continue

    relative="${file#"$ROOT"/}"

    print_rule
    printf 'FILE: %s\n' "$relative"
    print_rule
    echo

    if [[ -s "$file" ]]; then
        cat "$file"

        # Ensure the next header never gets glued to a file without final \n.
        [[ "$(tail -c 1 "$file" 2>/dev/null | wc -l)" -eq 0 ]] && echo
    else
        echo "[empty file]"
    fi

    echo
done < <(
    find "$ROOT" -type f -print0 | sort -z
)

print_rule
echo "END OF PROJECT"
print_rule
