#!/bin/bash
if [ $# != 1 ]; then
    echo "Error: 必ずコンパイル対象のTeXファイルを指定して下さい"
    exit 1
fi

# 極力現状のディレクトリを汚さないようにコンパイルする
# 対象のTeXファイルは./src以下に保存されている前提

# 最終のpdfファイル保存先を生成
ls -l | grep dist >& /dev/null
if [ $? != 0 ]; then
    mkdir dist
fi

# コンパイル。中間ファイルは.latexmkrcの設定に従い、src/tmp以下に出力される
cd src
echo processing...
latexmk $1 >& process.log
if [ $? != 0 ]; then
    echo "Error: コンパイル失敗。原因はsrc/tmp/process.logを確認してください。"
    exit 2
fi

DIST=$(echo $1 | sed -e 's/.tex/.pdf/')
mv tmp/${DIST} ../dist/${DIST}

cd ../