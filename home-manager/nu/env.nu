def create_left_prompt [] {
    ^starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

def create_right_prompt [] {
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | date format '%m/%d/%Y %r')
    ] | str join)

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

let-env PROMPT_COMMAND = {|| create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

let-env PROMPT_INDICATOR = {|| "> " }
let-env PROMPT_INDICATOR_VI_INSERT = {|| "> " }
let-env PROMPT_INDICATOR_VI_NORMAL = {|| ": " }
let-env PROMPT_MULTILINE_INDICATOR = {|| "::: " }

let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

let-env PATH = ($env.PATH | split row (char esep) | prepend '/home/micgao/.cargo/bin')
let-env OPENAI_API_KEY = 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
