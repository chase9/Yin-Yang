import subprocess
from setuptools import setup

subprocess.check_call(['scripts/build_ui.sh'])

# install additional files for system integration and the firefox plugin
# packagers need to specify the installation prefix where logo and desktop file should be placed
# src: https://stackoverflow.com/questions/25284879/install-desktop-file-with-setup-py
setup(
    data_files=[
        ('share/applications', ['resources/Yin-Yang.desktop']),
        ('share/icons/hicolor/scalable/apps', ['resources/logo.svg']),
        ('~/.local/share/systemd/user', ['resources/yin_yang.service', 'resources/yin_yang.timer']),
        ('/usr/lib/mozilla/native-messaging-hosts', ['resources/yin_yang.json'])
    ]
)
