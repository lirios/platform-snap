# -*- Mode:Python; indent-tabs-mode:nil; tab-width:4 -*-
#
# Copyright (C) 2018 Tim Süberkrüb <dev@timsueberkrueb.io>
# Copyright (C) 2016 Canonical Ltd
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""The qmake plugin is useful for building qmake-based parts.

These are projects that are built using .pro files.

This plugin uses the common plugin keywords as well as those for "sources".
For more information check the 'plugins' topic for the former and the
'sources' topic for the latter.

Additionally, this plugin uses the following plugin-specific keywords:

    - options:
      (list of strings)
      additional options to pass to the qmake invocation.
    - qt-version:
      (enum, 'qt4' or 'qt5')
      Version of Qt to use with qmake.
    - project-files:
      (list of strings)
      list of .pro files to pass to the qmake invocation.
"""

import os

import snapcraft
from snapcraft import common


class QmakePlugin(snapcraft.BasePlugin):

    @classmethod
    def schema(cls):
        schema = super().schema()
        schema['properties']['options'] = {
            'type': 'array',
            'minitems': 1,
            'uniqueItems': True,
            'items': {
                'type': 'string',
            },
            'default': [],
        }
        schema['properties']['qt-version'] = {
            'enum': ['qt4', 'qt5'],
            'defaukt': 'qt5'
        }
        schema['properties']['project-files'] = {
            'type': 'array',
            'minitems': 1,
            'uniqueItems': True,
            'items': {
                'type': 'string',
            },
            'default': [],
        }

        return schema

    @classmethod
    def get_pull_properties(cls):
        # Inform Snapcraft of the properties associated with pulling. If these
        # change in the YAML Snapcraft will consider the pull step dirty.
        return ['qt-version']

    @classmethod
    def get_build_properties(cls):
        # Inform Snapcraft of the properties associated with building. If these
        # change in the YAML Snapcraft will consider the build step dirty.
        return ['options', 'project-files']

    def __init__(self, name, options, project):
        super().__init__(name, options, project)

        self.build_packages.append('make')

    def build(self):
        super().build()

        env = os.environ.copy()

        sources = []
        if self.options.project_files:
            sourcedir = self.sourcedir
            source_subdir = getattr(self.options, 'source_subdir', None)
            if source_subdir:
                sourcedir = os.path.join(sourcedir, source_subdir)
            sources = [os.path.join(sourcedir, project_file)
                       for project_file in self.options.project_files]

        qmake = '{}/usr/lib/x86_64-linux-gnu/qt5/bin/qmake'.format(self.project.stage_dir)

        self.run([qmake] + self.options.options +
                 sources, env=env)

        self.run(['make', '-j{}'.format(
            self.parallel_build_count)], env=env)

        self.run(['make', 'install'],
                 env=env)
