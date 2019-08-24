function replace_file_string() {
        if [ -f $1 ]; then
                echo Update file:$1, $2 to $3, please wait...
        fi
        echo -e "\033[33mFind ($2) in file: ($1).\033[0m"
        grep -n $2 $1
        echo $1 | xargs perl -pi -e "s|$2|$3|g"
        echo -e "\033[32mUpdate file result: $?.\n\033[33mFind ($3) in file: ($1)\033[0m"
        grep -n $3 $1
}

function lunch_and_make_spreadtrum() {
        git checkout .
        rm -rf out*
        source $1
        if [ $3 != "0" ]; then
lunch $2 << XXG
$3
XXG
        else
lunch $2
        fi
        make -j6 2>&1 | tee b1.log
        if [ $4 = "ota" ]; then
                make -j6 otapackage 2>&1 | tee b2.log
        fi
        ./make_pac_sign.sh $5 $6
}

function make_mtk() {
        echo enter make mtk
        git checkout .
        rm -rf mediatek/external/vtmal/custom/common mediatek/kernel/trace32/z725_ramdisk.img mediatek/preloader/preloader_z725.bin
        rm -rf out*
        ./mk -o=TARGET_BUILD_VARIANT=user $1 n
        ./release.sh $1 $2
}

if [ $# -le 0 ]; then
        echo No args!
elif [ $1 = "mf" ]; then
        replace_file_string $1 $2 $3 $4
elif [ $1 = "mfnv" ]; then
        # e.g. m mfnv 
        replace_file_string ./build/tools/buildinfo.sh $2 $3
        git add ./build/tools/buildinfo.sh
        git commit -m "qyp:发布新版本（$3）"
        git show HEAD
# a = spreadtrum, b = mtk
elif [ $1 = "ab" ]; then
        # e.g. m ab z603s-user z603s-twocamera ota z603s Version01
        lunch_and_make_spreadtrum ./build/envsetup.sh $2 $3 $4 $5 $6
elif [ $1 = "bb" ]; then
        make_mtk $2 $3
fi

echo -e "\033[32mDone.\033[0m"
