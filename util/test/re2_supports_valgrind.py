#!/usr/bin/env python
import os
import sys

chplenv_dir = os.path.join(os.path.dirname(__file__), '..')
sys.path.insert(0, os.path.abspath(chplenv_dir))

from chplenv import chpl_home_utils
from chplenv import chpl_3p_re2_configs

def get():
    """ Detects if re2 was built with CHPL_RE2_VALGRIND_SUPPORT set by checking
        for a sentinel file in the install dir """
    third_party = chpl_home_utils.get_chpl_third_party()
    uniq_cfg_path = chpl_3p_re2_configs.get_uniq_cfg_path()
    re2_valgrind = os.path.join(third_party, 're2', 'install',
                                uniq_cfg_path, 'CHPL_RE2_VALGRIND_SUPPORT')
    return os.path.exists(re2_valgrind)


def _main():
    re2_supports_valgrind = get()
    sys.stdout.write("{0}\n".format(re2_supports_valgrind))


if __name__ == '__main__':
    _main()
