# Felix' Fish Configuration Init File.

# Better Greeting.
function fish_greeting
    begin
        echo (date) " @ " (hostname)
        echo
        fortune art goedel wisdom tao literature songs-poems paradoxum
        echo
    end
end

# Fix a problem with paging on nixos, will be resolved once fish version is
# updated. https://github.com/NixOS/nixpkgs/issues/85158

set PAGER less
set LESS "-R"


function gitlog -d "More detailed, prettified output for git."
    git log --graph --abbrev-commit \
    --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
end
