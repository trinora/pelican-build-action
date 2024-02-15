#!/bin/bash
set -e

echo 'Installing 🐍 Python Requirements'
pip install -r requirements.txt

# if [ -n "$PELICAN_THEME_FOLDER" ]; then
#     echo 'Installing Node Modules 🧰 '
#     pushd $PELICAN_THEME_FOLDER
#     npm install
#     popd
# fi

echo 'Building site 👷 '
pelican ${PELICAN_CONTENT_DIR:=content} -o ${PELICAN_OUTPUT_DIR:=output} -s ${PELICAN_CONFIG_FILE:=publishconf.py}
touch "${PELICAN_OUTPUT_DIR:=output}/.nojekyll"
