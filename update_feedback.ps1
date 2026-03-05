$paths = @("c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\index.html", "c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\oferta.html", "c:\Users\fabio\.gemini\antigravity\scratch\hqflix-clone\ultima-chance.html")

foreach ($path in $paths) {
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

        # 1. Remove duplicated "Atualizações Diárias" checkmark item (both HTML string versions handling)
        $content = $content -replace '<li>\s*<svg[^>]*>\s*<path fill="#00E676"[^>]*>\s*</svg>\s*<strong>Atualizações Diárias</strong></li>', ''
        $content = $content -replace '<li>\s*<svg[^>]*>\s*<path fill="#00E676"[^>]*>\s*</svg>\s*<strong>Atualiza&ccedil;&otilde;es Di&aacute;rias</strong></li>', ''
        
        # 2. Update the background padding and SVG of the bonus list item
        # We find the li with style="color: var(--accent-gold); font-weight: bold; background: rgba(255, 215, 0, 0.1); padding: 5px; border-radius: 5px;"
        $content = $content -replace '<li[^>]*>\s*<svg viewBox="0 0 24 24" style="filter: drop-shadow\(0 0 3px var\(--accent-gold\)\);">\s*<path fill="#FFD700"\s*d="M20 6h-2.18[^"]+"\s*/>\s*</svg>\s*<strong>Atualiza[^<]+raros</strong>', '<li style="color: var(--accent-gold); font-weight: bold;"><svg viewBox="0 0 24 24" style="filter: drop-shadow(0 0 2px var(--accent-gold));"><path fill="#FFD700" d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg> <strong>Atualizações diárias, pacote terror, ebooks e audiobooks raros</strong>'
        
        $content = $content -replace '<li[^>]*>\s*<svg viewBox="0 0 24 24" style="filter: drop-shadow\(0 0 3px var\(--accent-gold\)\);">\s*<path fill="#FFD700"\s*d="M20 6h-2.18[^"]+"\s*/>\s*</svg>\s*<strong>Atualiza&ccedil;&otilde;es[^<]+raros</strong>\s*</li>', '<li style="color: var(--accent-gold); font-weight: bold;"><svg viewBox="0 0 24 24" style="filter: drop-shadow(0 0 2px var(--accent-gold));"><path fill="#FFD700" d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg> <strong>Atualiza&ccedil;&otilde;es di&aacute;rias, pacote terror, ebooks e audiobooks raros</strong></li>'
        
        # 3. Handle index specific changes
        if ($path -match 'index\.html') {
            # Update "Recebe Atualização" -> "Atualização"
            $content = $content -replace '<h4 class="bonus-title">Recebe Atualização Diária</h4>', '<h4 class="bonus-title">Atualização Diária</h4>'
            
            # Update Hero card layout
            $oldHero = '<div class="hero-card" style="background: none; display: grid; padding: 0; overflow: hidden;">\s*<img[^>]+>\s*<div\s*style="grid-area: 1 / 1; width: 100%; height: 100%; background: linear-gradient[^>]+>\s*</div>\s*<div class="hero-card-content" style="grid-area: 1 / 1; z-index: 2; padding: 1\.5rem 1rem;">'
            
            $newHero = '<div class="hero-card" style="background: rgba(11, 14, 20, 0.95); border: 1px solid rgba(255, 215, 0, 0.3); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8), inset 0 0 40px rgba(255, 215, 0, 0.1); display: block; padding: 0; overflow: hidden;">' + "`n" + '                    <div class="hero-card-content" style="padding: 0.5rem;">'
            
            $content = $content -replace $oldHero, $newHero
        }

        $utf8NoBOM = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($path, $content, $utf8NoBOM)
    }
}
