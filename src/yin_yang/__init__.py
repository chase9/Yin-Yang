
"""
title: yin_yang
description: yin_yang provides an easy way to toggle between light and dark
mode for your kde desktop. It also themes your vscode and
all other qt application with it.
author: oskarsh
date: 21.12.2018
license: MIT
"""
import logging
import sys
from argparse import ArgumentParser

from PySide6.QtCore import QTranslator, QLocale, QLibraryInfo
from PySide6.QtWidgets import QApplication
from systemd import journal

from yin_yang import daemon_handler
from yin_yang.config import config, plugins
from yin_yang.meta import PluginKey, ConfigEvent, Modes
from yin_yang.theme_manager import set_mode, set_desired_theme
from yin_yang.ui import main_window_connector

logger = logging.getLogger(__name__)


def setup_logger(use_systemd_journal: bool):
    if use_systemd_journal:
        logger.addHandler(journal.JournalHandler(SYSLOG_IDENTIFIER='yin_yang'))

    # __debug__ is true when you run __main__.py without the -O argument (python __main__.py)
    # noinspection PyUnreachableCode
    if __debug__:
        # noinspection SpellCheckingInspection
        logging.basicConfig(
            level=logging.DEBUG,
            format='%(asctime)s %(levelname)s - %(name)s: %(message)s'
        )
    else:
        # if you run it with "python -O __main__.py" instead, debug is false

        # let the default logger print to the console
        # noinspection SpellCheckingInspection
        logging.basicConfig(
            level=logging.WARNING,
            format='%(asctime)s %(levelname)s - %(name)s: %(message)s'
        )
        # and add a handler that limits the size to 1 GB
        file_handler = RotatingFileHandler(
            str(Path.home()) + '/.local/share/yin_yang.log',
            maxBytes=10 ** 9, backupCount=1
        )
        logging.root.addHandler(file_handler)


def run_command_line(arguments):
    setup_logger(arguments.systemd)

    if arguments.toggle:
        # terminate any running instances
        config.running = False
        config.mode = Modes.MANUAL
        set_mode(not config.dark_mode)

    if arguments.systemd:
        set_desired_theme()


def run_gui():
    setup_logger(False)

    config.add_event_listener(ConfigEvent.SAVE, daemon_handler.watcher)
    config.add_event_listener(ConfigEvent.CHANGE, daemon_handler.watcher)
    # load GUI
    app = QApplication(sys.argv)

    # load translation
    try:
        lang = QLocale().name()
        logger.debug(f'Using language {lang}')

        # system translations
        path = QLibraryInfo.location(QLibraryInfo.TranslationsPath)
        translator = QTranslator(app)
        if translator.load(QLocale.system(), 'qtbase', '_', path):
            app.installTranslator(translator)
        else:
            raise FileNotFoundError('Error while loading system translations!')

        # application translations
        translator = QTranslator(app)
        path = ':translations'
        if translator.load(QLocale.system(), 'yin_yang', '.', path):
            app.installTranslator(translator)
        else:
            raise FileNotFoundError('Error while loading application translations!')

    except Exception as e:
        logger.error(str(e))
        print('Error while loading translation. Using default language.')

    window = main_window_connector.MainWindow()
    window.show()
    sys.exit(app.exec())


def parse_args():
    # using ArgumentParser for parsing arguments
    parser = ArgumentParser()
    parser.add_argument("-t", "--toggle",
                        help="toggles Yin-Yang",
                        action="store_true")
    parser.add_argument("--systemd", help="uses systemd journal handler and applies desired theme", action='store_true')
    arguments = parser.parse_args()

    # checks whether $ yin-yang is run without args
    if len(sys.argv) == 1:
        run_gui()
    else:
        run_command_line(arguments)
