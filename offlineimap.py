# TODO: Replace `<ACCOUNT>` with account username

from pipes import quote
import subprocess


def get_username():
    return "<ACCOUNT>@gmail.com"


def get_password():
    try:
        # GMail requires a 3rd party app password, so we generate that and
        # store it in pass.gpg
        return subprocess.check_output('gpg -dq ~/Mail/<ACCOUNT>/pass.gpg',
                                       encoding='utf-8', shell=True).strip('\n')
    except subprocess.CalledProcessError as err:
        subprocess.call(('notify-send -u critical -c mail '
                         '"offlineimap: gpg -dq failed"',
                         quote(err.output if err.output else err.output)),
                        shell=True)
        raise err
