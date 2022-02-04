from django.conf import settings
from django.core.exceptions import PermissionDenied

from library import utils as lib_utils, global_vars

from user_agents import parse
import json


def context_data(request):

    http_host = lib_utils.get_http_host(request)

    if 'HTTP_USER_AGENT' in request.META:
        ua = request.META['HTTP_USER_AGENT']
    else:
        # msg = 'User with no UA? {}'.format(request.META)
        # logic.get('slack').send(msg, 'server')
        raise PermissionDenied()

    OS_SYSTEM = None
    BROWSER = None
    if ua:
        user_agents_parse = parse(ua)
        OS_SYSTEM = user_agents_parse.os.family
        BROWSER = user_agents_parse.browser.family

    is_mobile = lib_utils.is_mobile(request)


    return {
        'SITE_NAME': settings.SITE_NAME,
        'DEFAULT_META_TITLE': settings.DEFAULT_META_TITLE,
        'DEFAULT_META_DESCRIPTION': settings.DEFAULT_META_DESCRIPTION,

        'VERSION': settings.VERSION,
        'OS_SYSTEM': OS_SYSTEM,
        'BROWSER': BROWSER,

        'IS_MOBILE': is_mobile,
        'is_ipad': lib_utils.is_ipad_http_host(request),
        'SITE_URL': lib_utils.get_absolute_base_url(),
        'DEBUG': settings.DEBUG,
    }
