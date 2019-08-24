if [ $# -gt 4 ]; then
        echo Too many args: $#;
elif [ $# -le 0 ]; then
        echo No args!
elif [ $# -eq 4 ]; then
        if [ $1 == "mf" ]; then
                if [ -f $2 ]; then
                        echo Update file:$2, $3 to $4, please wait...
                fi
                echo -e "\033[33mFind ($3) in file: ($2).\033[0m"
                grep -n $3 $2
                echo $2 | xargs perl -pi -e "s|$3|$4|g"
                echo -e "\033[32mUpdate file result: $?.\n\033[33mFind ($4) in file: ($2)\033[0m"
                grep -n $4 $2
        fi
fi
echo -e "\033[32mDone.\033[0m"
