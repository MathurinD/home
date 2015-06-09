#/bin/bash


if [ !-e $1]
then
    touch $1

    echo "\\documentclass[a4paper, 12pt]{article}
    \\usepackage{enTete}

    \\title{$1}

    \\begin{document}

    \\maketitle

    \\end{document}
    " > $1
fi

