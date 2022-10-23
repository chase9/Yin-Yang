import logging
from datetime import time, datetime
from threading import Thread

from yin_yang import config, PluginKey
from yin_yang.config import plugins

logger = logging.getLogger(__name__)


def should_be_dark(time_current: time, time_light: time, time_dark: time) -> bool:
    """Compares two times with current time"""

    if time_light < time_dark:
        return not (time_light <= time_current < time_dark)
    else:
        return time_dark <= time_current < time_light


def set_mode(dark: bool, force=False):
    """Activates light or dark theme"""

    if not force and dark == config.dark_mode:
        return

    logger.info(f'Switching to {"dark" if dark else "light"} mode.')
    for p in plugins:
        if config.get_plugin_key(p.name, PluginKey.ENABLED):
            try:
                logger.info(f'Changing theme in plugin {p.name}')
                p_thread = Thread(target=p.set_mode, args=[dark], name=p.name)
                p_thread.start()
            except Exception as e:
                logger.error('Error while changing theme in ' + p.name, exc_info=e)

    config.dark_mode = dark


def set_desired_theme(force: bool = False):
    time_light, time_dark = config.times
    set_mode(should_be_dark(
        datetime.now().time(),
        time_light,
        time_dark
    ), force)
