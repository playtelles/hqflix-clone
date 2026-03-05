$paths = @("c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\oferta.html", "c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\ultima-chance.html")
$r = [char]0xFFFD
foreach ($path in $paths) {
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        $content = $content.Replace("N${r}O", "N&Atilde;O")
        $content = $content.Replace("P${r}GINA", "P&Aacute;GINA")
        $content = $content.Replace("${r}NICA", "&Uacute;NICA")
        $content = $content.Replace("VOC${r}.", "VOC&Ecirc;.")
        $content = $content.Replace("experi${r}ncia", "experi&ecirc;ncia")
        $content = $content.Replace("t${r}tulos", "t&iacute;tulos")
        $content = $content.Replace("Vital${r}cio", "Vital&iacute;cio")
        $content = $content.Replace("Atualiza${r}es", "Atualiza&ccedil;&otilde;es")
        $content = $content.Replace("Di${r}rias", "Di&aacute;rias")
        $content = $content.Replace("Edi${r}es", "Edi&ccedil;&otilde;es")
        $content = $content.Replace("Pr${r}prio", "Pr&oacute;prio")
        $content = $content.Replace("R${r}pido", "R&aacute;pido")
        $content = $content.Replace("N${r}o,", "N&atilde;o,")
        $content = $content.Replace("B${r}sico", "B&aacute;sico")
        $content = $content.Replace("${r}LTIMA", "&Uacute;LTIMA")
        
        $utf8NoBOM = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($path, $content, $utf8NoBOM)
    }
}
