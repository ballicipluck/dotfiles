function touchp --description 'touch a file, creating parent directories'
    mkdir -p (dirname -- $argv[1]); and touch $argv
end
