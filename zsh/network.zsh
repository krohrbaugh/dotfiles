# macOS 10.13.x
alias flushdns="sudo killall -HUP mDNSResponder && echo macOS DNS Cache Reset"

# OS X 10.10.4
# alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# OS X 10.10
#alias flushdns="sudo discoveryutil udnsflushcaches"

# MacOS X 10.9
# alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# MacOS X 10.7 - 10.8
# alias flushdns="sudo killall -HUP mDNSResponder"

# MacOS X 10.5 - 10.6
# alias flushdns="sudo dscacheutil -flushcache"