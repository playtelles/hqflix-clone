$paths = @("c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\oferta.html", "c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\ultima-chance.html")
foreach ($path in $paths) {
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path)
        
        # Replace description in pricing card complete
        $content = $content -replace '<p class="pricing-desc">Leve a experi[^<]+</p>', '<p class="pricing-desc" style="background: var(--accent-gold); color: #000; padding: 4px 10px; border-radius: 4px; font-weight: 800; display: inline-block; font-size: 1.1rem; text-transform: uppercase;">PAGAMENTO &Uacute;NICO</p>'
        
        # Remove +18
        $content = $content -replace '<li>\s*<svg[^>]*>\s*<path[^>]*>\s*</svg>\s*<strong>Pacote \+18 Exclusivo</strong>\s*</li>', ''
        
        # Replace bonus
        $bonus = '' +
'<li style="color: var(--accent-gold); font-weight: bold; background: rgba(255, 215, 0, 0.1); padding: 5px; border-radius: 5px;"><svg viewBox="0 0 24 24" style="filter: drop-shadow(0 0 3px var(--accent-gold));">' + "`n" + `
'    <path fill="#FFD700" d="M20 6h-2.18c.11-.31.18-.65.18-1 0-1.66-1.34-3-3-3-1.05 0-1.96.54-2.5 1.35l-.5.67-.5-.68C10.96 2.54 10.05 2 9 2 7.34 2 6 3.34 6 5c0 .35.07.69.18 1H4c-1.11 0-1.99.89-1.99 2L2 19c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V8c0-1.11-.89-2-2-2zm-5-2c.55 0 1 .45 1 1s-.45 1-1 1h-4v-2h4zM9 4c.55 0 1 .45 1 1v2H6c0-.55.45-1 1-1s1-.45 1-1zm-5 4h16v2H4V8zm0 11v-9h16v9H4z" />' + "`n" + `
'</svg> <strong>Atualiza&ccedil;&otilde;es di&aacute;rias, pacote terror, ebooks e audiobooks raros</strong></li>'
        $content = $content -replace '<li>\s*<svg[^>]*>\s*<path[^>]*>\s*</svg>\s*<strong>Os 4 B[^<]+Inclusos</strong>\s*</li>', $bonus
        
        # Replace URL specific to file
        if ($path -match 'oferta\.html') {
            $content = $content -replace 'https://loja\.hqflixbrasil\.com/checkout/v5/[a-zA-Z0-9]+', 'https://loja.hqflixbrasil.com/checkout/v5/tJGcU8PWuhvthBSaVSUM'
        } elseif ($path -match 'ultima-chance\.html') {
            $content = $content -replace 'https://loja\.hqflixbrasil\.com/checkout/v5/[a-zA-Z0-9]+', 'https://loja.hqflixbrasil.com/checkout/v5/8tyB789qdesqFAygRaTK'
        }
        
        [System.IO.File]::WriteAllText($path, $content)
    }
}
