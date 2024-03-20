from datetime import datetime

import weechat

weechat.register('themes', 'Teon', '0.1', 'MIT', 'My color theme settings', '', 'UTF-8')


_LIGHT_THEME_SETTINGS = {
        'buflist.format.buffer_current': '"${color:,0}${format_buffer}"',
        'fset.color.line_selected_bg1': 0,
        'fset.color.line_selected_bg2': 0,
        'fset.color.name_changed': 'yellow',
        'fset.color.value_changed': 'yellow',
        'weechat.bar.status.color_bg': 0,
        'weechat.bar.status.color_bg_inactive': 8,
        'weechat.bar.title.color_bg': 0,
        'weechat.bar.title.color_bg_inactive': 8,
        }


_DARK_THEME_SETTINGS = {
        'buflist.format.buffer_current': '"${color:,17}${format_buffer}"',
        'fset.color.line_selected_bg1': 24,
        'fset.color.line_selected_bg2': 24,
        'fset.color.name_changed': 185,
        'fset.color.value_changed': 185,
        'weechat.bar.status.color_bg': 234,
        'weechat.bar.status.color_bg_inactive': 232,
        'weechat.bar.title.color_bg': 234,
        'weechat.bar.title.color_bg_inactive': 232,
        }


_CURRENT_THEME = None

def theme_cb(_data, _buffer, args):
    global _CURRENT_THEME
    if args == 'light':
        weechat.prnt('', 'Setting light theme')
        for setting, value in _LIGHT_THEME_SETTINGS.items():
            weechat.command('', '/set {} {}'.format(setting, value))
        _CURRENT_THEME = 'light'
    elif args == 'dark':
        weechat.prnt('', 'Setting dark theme')
        for setting, value in _DARK_THEME_SETTINGS.items():
            weechat.command('', '/set {} {}'.format(setting, value))
        _CURRENT_THEME = 'dark'
    return weechat.WEECHAT_RC_OK


cmd_hook = weechat.hook_command('theme', 'Select a theme', 'light|dark', '', 'light || dark', 'theme_cb', '')


def theme_for_time_of_day_timer_cb(_data, _remaining_calls):
    global _CURRENT_THEME
    curr_hour = datetime.now().hour
    if curr_hour > 7 and curr_hour < 17:
        if _CURRENT_THEME != 'light':
            theme_cb(None, None, 'light')
    elif _CURRENT_THEME != 'dark':
        theme_cb(None, None, 'dark')
    return weechat.WEECHAT_RC_OK


timer_hook = weechat.hook_timer(60 * 1000, 0, 0, 'theme_for_time_of_day_timer_cb', '')
