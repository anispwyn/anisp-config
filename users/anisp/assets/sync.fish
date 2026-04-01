#!/usr/bin/env fish
set folders "[Halozy]" "[豚乙女]" "[森羅万象]" "[凋叶棕]" "[FELT]"

for folder in $folders
    rsync-ssl -Pritv "rsync://patchouli@rsync.thdisc.com:874/tlmc/$folder/" "./$folder/"
end
