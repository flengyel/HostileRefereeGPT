param(
  [string[]] $Modules = @("category-theory", "recursion-categories"),
  [string] $Out = "build/hostile-referee-gpt-cat-rec.prompt.md",
  [int] $Limit = 8000
)

$ErrorActionPreference = "Stop"

$DefaultModules = @("category-theory", "recursion-categories")
$DefaultOut = "build/hostile-referee-gpt-cat-rec.prompt.md"

if (($Modules -join " ") -ne ($DefaultModules -join " ") -and $Out -eq $DefaultOut) {
  throw "nondefault Modules would overwrite $DefaultOut; set -Out build/scratch.prompt.md"
}

$Sources = @("header.md", "workflow.md") + ($Modules | ForEach-Object { "modules/$_.md" })

foreach ($Source in $Sources) {
  if (-not (Test-Path -LiteralPath $Source)) {
    throw "missing source file: $Source"
  }
}

$OutDir = Split-Path -Parent $Out
if ($OutDir) {
  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
}

$Temp = [IO.Path]::GetTempFileName()

try {
  $Stream = [IO.File]::Open($Temp, [IO.FileMode]::Create, [IO.FileAccess]::Write)

  try {
    foreach ($Source in $Sources) {
      $Bytes = [IO.File]::ReadAllBytes($Source)
      $Stream.Write($Bytes, 0, $Bytes.Length)
    }
  }
  finally {
    $Stream.Close()
  }

  $Text = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($Temp))
  $Chars = $Text.Length

  Write-Host "Built $Out ($Chars characters)"

  if ($Chars -gt $Limit) {
    throw "GPT Builder limit exceeded: $Chars > $Limit"
  }

  Move-Item -Force -LiteralPath $Temp -Destination $Out
}
finally {
  if (Test-Path -LiteralPath $Temp) {
    Remove-Item -Force -LiteralPath $Temp
  }
}