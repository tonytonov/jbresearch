#!/bin/bash

cd /home/rstudio
wget "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
mv -v "uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download" gdrive
chmod +x gdrive
install gdrive /usr/local/bin/gdrive
echo "Done!"
